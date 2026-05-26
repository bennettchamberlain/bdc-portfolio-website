library content_editor_view;

import 'package:bdc_website_v2/core/models/content_block.dart';
import 'package:bdc_website_v2/views/content_editor/content_editor_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import '../../components/content_blocks/content_block_widget.dart';

part 'content_editor_desktop.dart';
part 'content_editor_mobile.dart';

class ContentEditorView extends StatelessWidget {
  const ContentEditorView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContentEditorViewModel>.reactive(
      viewModelBuilder: () => ContentEditorViewModel(context),
      builder: (context, viewModel, _) {
        return ScreenTypeLayout.builder(
          mobile: (_) => _ContentEditorMobile(viewModel),
          tablet: (_) => _ContentEditorDesktop(viewModel),
          desktop: (_) => _ContentEditorDesktop(viewModel),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Metadata fields (title / author / desc)
// ─────────────────────────────────────────────────────────────
class _MetadataFields extends StatefulWidget {
  final ContentEditorViewModel vm;
  const _MetadataFields(this.vm);

  @override
  State<_MetadataFields> createState() => _MetadataFieldsState();
}

class _MetadataFieldsState extends State<_MetadataFields> {
  late final TextEditingController _titleCtrl;
  late final TextEditingController _authorCtrl;
  late final TextEditingController _descCtrl;
  bool _synced = false;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.vm.title);
    _authorCtrl = TextEditingController(text: widget.vm.authorName);
    _descCtrl = TextEditingController(text: widget.vm.desc);
    _synced = widget.vm.title.isNotEmpty;
  }

  @override
  void didUpdateWidget(_MetadataFields old) {
    super.didUpdateWidget(old);
    // Sync controllers once when edit data finishes loading
    if (!_synced && widget.vm.title.isNotEmpty) {
      _titleCtrl.text = widget.vm.title;
      _authorCtrl.text = widget.vm.authorName;
      _descCtrl.text = widget.vm.desc;
      _synced = true;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _authorCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _titleCtrl,
          decoration: const InputDecoration(
            labelText: 'Title',
            border: OutlineInputBorder(),
          ),
          onChanged: (v) => widget.vm.title = v,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _authorCtrl,
          decoration: const InputDecoration(
            labelText: 'Author',
            border: OutlineInputBorder(),
          ),
          onChanged: (v) => widget.vm.authorName = v,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _descCtrl,
          decoration: const InputDecoration(
            labelText: 'Short description / subtitle',
            border: OutlineInputBorder(),
          ),
          maxLines: 2,
          onChanged: (v) => widget.vm.desc = v,
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Thumbnail picker
// ─────────────────────────────────────────────────────────────
class _ThumbnailPicker extends StatelessWidget {
  final ContentEditorViewModel vm;
  const _ThumbnailPicker(this.vm);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Thumbnail',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 6),
        if (vm.thumbnailUrl.isNotEmpty)
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(vm.thumbnailUrl,
                    height: 120, width: double.infinity, fit: BoxFit.cover),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: IconButton.filled(
                  onPressed: () => vm.setThumbnail(''),
                  icon: const Icon(Icons.close, size: 16),
                  style: IconButton.styleFrom(
                      backgroundColor: Colors.black54,
                      minimumSize: const Size(28, 28)),
                ),
              ),
            ],
          )
        else
          Consumer(
            builder: (context, ref, _) => OutlinedButton.icon(
              onPressed: () => vm.pickAndUploadThumbnail(ref),
              icon: const Icon(Icons.add_photo_alternate_outlined),
              label: const Text('Upload thumbnail'),
            ),
          ),
        // also allow picking from already-uploaded image blocks
        if (vm.imageUrls.isNotEmpty) ...[
          const SizedBox(height: 8),
          const Text('Or pick from content images:',
              style: TextStyle(fontSize: 12, color: Colors.white54)),
          const SizedBox(height: 4),
          SizedBox(
            height: 64,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: vm.imageUrls.length,
              separatorBuilder: (_, __) => const SizedBox(width: 6),
              itemBuilder: (_, i) {
                final url = vm.imageUrls[i];
                return GestureDetector(
                  onTap: () => vm.setThumbnail(url),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: vm.thumbnailUrl == url
                            ? Colors.blue
                            : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(url,
                          height: 60, width: 60, fit: BoxFit.cover),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Editor canvas — the reorderable list of blocks
// ─────────────────────────────────────────────────────────────
class _EditorCanvas extends StatelessWidget {
  final ContentEditorViewModel vm;
  const _EditorCanvas(this.vm);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ReorderableListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          onReorder: vm.reorderBlocks,
          itemCount: vm.blocks.length,
          itemBuilder: (context, index) {
            final block = vm.blocks[index];
            return _EditableBlock(
              key: ValueKey(block.id),
              block: block,
              vm: vm,
            );
          },
        ),
        const SizedBox(height: 8),
        Center(child: _AddBlockFab(vm)),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Single editable block card
// ─────────────────────────────────────────────────────────────
class _EditableBlock extends StatefulWidget {
  final ContentBlock block;
  final ContentEditorViewModel vm;
  const _EditableBlock({super.key, required this.block, required this.vm});

  @override
  State<_EditableBlock> createState() => _EditableBlockState();
}

class _EditableBlockState extends State<_EditableBlock> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    final block = widget.block;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header row
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.drag_handle, size: 18, color: Colors.white38),
                  const SizedBox(width: 8),
                  _blockIcon(block.type),
                  const SizedBox(width: 8),
                  Text(
                    _blockLabel(block),
                    style: const TextStyle(fontSize: 13, color: Colors.white70),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.delete_outline,
                        size: 18, color: Colors.redAccent),
                    tooltip: 'Remove block',
                    onPressed: () => widget.vm.removeBlock(block.id),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    size: 18,
                    color: Colors.white38,
                  ),
                ],
              ),
            ),
          ),
          if (_expanded) _BlockEditor(block: block, vm: widget.vm),
        ],
      ),
    );
  }

  String _blockLabel(ContentBlock b) {
    switch (b.type) {
      case ContentBlockType.heading:
        return b.content?.isNotEmpty == true ? b.content! : 'Heading';
      case ContentBlockType.paragraph:
        return b.content?.isNotEmpty == true ? b.content! : 'Paragraph';
      case ContentBlockType.image:
        return b.url?.isNotEmpty == true ? b.url! : 'Image';
      case ContentBlockType.video:
        return b.url?.isNotEmpty == true ? b.url! : 'Video';
      case ContentBlockType.code:
        return '${b.language ?? 'code'} snippet';
      case ContentBlockType.divider:
        return '— Divider —';
    }
  }

  Widget _blockIcon(ContentBlockType t) {
    switch (t) {
      case ContentBlockType.heading:
        return const Icon(Icons.title, size: 16, color: Colors.white54);
      case ContentBlockType.paragraph:
        return const Icon(Icons.text_fields, size: 16, color: Colors.white54);
      case ContentBlockType.image:
        return const Icon(Icons.image_outlined, size: 16, color: Colors.white54);
      case ContentBlockType.video:
        return const Icon(Icons.videocam_outlined,
            size: 16, color: Colors.white54);
      case ContentBlockType.code:
        return const Icon(Icons.code, size: 16, color: Colors.white54);
      case ContentBlockType.divider:
        return const Icon(Icons.horizontal_rule,
            size: 16, color: Colors.white54);
    }
  }
}

// ─────────────────────────────────────────────────────────────
// Block-type-specific editing form
// ─────────────────────────────────────────────────────────────
class _BlockEditor extends StatelessWidget {
  final ContentBlock block;
  final ContentEditorViewModel vm;
  const _BlockEditor({required this.block, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: _buildForm(context),
    );
  }

  Widget _buildForm(BuildContext context) {
    switch (block.type) {
      case ContentBlockType.heading:
        return _HeadingForm(block: block, vm: vm);
      case ContentBlockType.paragraph:
        return _ParagraphForm(block: block, vm: vm);
      case ContentBlockType.image:
        return _ImageForm(block: block, vm: vm);
      case ContentBlockType.video:
        return _VideoForm(block: block, vm: vm);
      case ContentBlockType.code:
        return _CodeForm(block: block, vm: vm);
      case ContentBlockType.divider:
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Divider(),
        );
    }
  }
}

class _HeadingForm extends StatefulWidget {
  final ContentBlock block;
  final ContentEditorViewModel vm;
  const _HeadingForm({required this.block, required this.vm});
  @override
  State<_HeadingForm> createState() => _HeadingFormState();
}

class _HeadingFormState extends State<_HeadingForm> {
  late TextEditingController _ctrl;
  late int _level;
  late String _align;
  late Color _color;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.block.content);
    _level = widget.block.level ?? 1;
    _align = widget.block.align ?? 'left';
    _color = _parseColor(widget.block.colorHex);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _save() {
    widget.vm.updateBlock(
      widget.block.id,
      widget.block.copyWith(
        content: _ctrl.text,
        level: _level,
        align: _align,
        colorHex: '#${_color.value.toRadixString(16).substring(2).toUpperCase()}',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _ctrl,
          decoration: const InputDecoration(labelText: 'Heading text'),
          onChanged: (_) => _save(),
        ),
        const SizedBox(height: 8),
        Row(children: [
          const Text('Level:', style: TextStyle(fontSize: 13)),
          const SizedBox(width: 8),
          ...([1, 2, 3].map((l) => Padding(
                padding: const EdgeInsets.only(right: 4),
                child: ChoiceChip(
                  label: Text('H$l'),
                  selected: _level == l,
                  onSelected: (_) {
                    setState(() => _level = l);
                    _save();
                  },
                ),
              ))),
          const SizedBox(width: 16),
          const Text('Align:', style: TextStyle(fontSize: 13)),
          const SizedBox(width: 8),
          _AlignPicker(
              value: _align,
              onChanged: (v) {
                setState(() => _align = v);
                _save();
              }),
          const Spacer(),
          _ColorSwatch(
            color: _color,
            onChanged: (c) {
              setState(() => _color = c);
              _save();
            },
          ),
        ]),
      ],
    );
  }
}

class _ParagraphForm extends StatefulWidget {
  final ContentBlock block;
  final ContentEditorViewModel vm;
  const _ParagraphForm({required this.block, required this.vm});
  @override
  State<_ParagraphForm> createState() => _ParagraphFormState();
}

class _ParagraphFormState extends State<_ParagraphForm> {
  late TextEditingController _ctrl;
  late String _align;
  late double _fontSize;
  late String _fontWeight;
  late Color _color;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.block.content);
    _align = widget.block.align ?? 'left';
    _fontSize = widget.block.fontSize ?? 16;
    _fontWeight = widget.block.fontWeight ?? 'normal';
    _color = _parseColor(widget.block.colorHex);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _save() {
    widget.vm.updateBlock(
      widget.block.id,
      widget.block.copyWith(
        content: _ctrl.text,
        align: _align,
        fontSize: _fontSize,
        fontWeight: _fontWeight,
        colorHex: '#${_color.value.toRadixString(16).substring(2).toUpperCase()}',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _ctrl,
          maxLines: null,
          decoration: const InputDecoration(labelText: 'Paragraph text'),
          onChanged: (_) => _save(),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Row(mainAxisSize: MainAxisSize.min, children: [
              const Text('Align:', style: TextStyle(fontSize: 13)),
              const SizedBox(width: 6),
              _AlignPicker(
                  value: _align,
                  onChanged: (v) {
                    setState(() => _align = v);
                    _save();
                  }),
            ]),
            Row(mainAxisSize: MainAxisSize.min, children: [
              const Text('Size:', style: TextStyle(fontSize: 13)),
              const SizedBox(width: 6),
              SizedBox(
                width: 64,
                child: TextField(
                  controller:
                      TextEditingController(text: _fontSize.toStringAsFixed(0)),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      isDense: true, contentPadding: EdgeInsets.all(6)),
                  onChanged: (v) {
                    final d = double.tryParse(v);
                    if (d != null) {
                      setState(() => _fontSize = d);
                      _save();
                    }
                  },
                ),
              ),
            ]),
            Row(mainAxisSize: MainAxisSize.min, children: [
              const Text('Weight:', style: TextStyle(fontSize: 13)),
              const SizedBox(width: 6),
              DropdownButton<String>(
                value: _fontWeight,
                isDense: true,
                items: const [
                  DropdownMenuItem(value: 'normal', child: Text('normal')),
                  DropdownMenuItem(value: 'bold', child: Text('bold')),
                  DropdownMenuItem(value: 'w100', child: Text('w100')),
                  DropdownMenuItem(value: 'w300', child: Text('w300')),
                  DropdownMenuItem(value: 'w500', child: Text('w500')),
                ],
                onChanged: (v) {
                  if (v != null) {
                    setState(() => _fontWeight = v);
                    _save();
                  }
                },
              ),
            ]),
            _ColorSwatch(
              color: _color,
              onChanged: (c) {
                setState(() => _color = c);
                _save();
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _ImageForm extends StatelessWidget {
  final ContentBlock block;
  final ContentEditorViewModel vm;
  const _ImageForm({required this.block, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (block.url != null && block.url!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(block.url!,
                  height: 160, width: double.infinity, fit: BoxFit.cover),
            ),
          ),
        Consumer(
          builder: (context, ref, _) => OutlinedButton.icon(
            onPressed: vm.isLoading && vm.uploadingBlockId == block.id
                ? null
                : () => vm.pickAndUploadImage(ref, block.id),
            icon: const Icon(Icons.upload_file_outlined),
            label: Text(block.url?.isNotEmpty == true
                ? 'Replace image'
                : 'Upload image'),
          ),
        ),
        if (vm.isLoading && vm.uploadingBlockId == block.id)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: LinearProgressIndicator(value: vm.uploadProgress),
          ),
        const SizedBox(height: 8),
        TextField(
          decoration: const InputDecoration(
              labelText: 'Caption (optional)', isDense: true),
          controller:
              TextEditingController(text: block.caption),
          onChanged: (v) =>
              vm.updateBlock(block.id, block.copyWith(caption: v)),
        ),
      ],
    );
  }
}

class _VideoForm extends StatelessWidget {
  final ContentBlock block;
  final ContentEditorViewModel vm;
  const _VideoForm({required this.block, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'YouTube or video URL',
            hintText: 'https://...',
          ),
          controller: TextEditingController(text: block.url),
          onChanged: (v) => vm.updateBlock(block.id, block.copyWith(url: v)),
        ),
        const SizedBox(height: 8),
        const Text('— or —',
            style: TextStyle(color: Colors.white38, fontSize: 12)),
        const SizedBox(height: 8),
        Consumer(
          builder: (context, ref, _) => OutlinedButton.icon(
            onPressed: vm.isLoading && vm.uploadingBlockId == block.id
                ? null
                : () => vm.pickAndUploadVideo(ref, block.id),
            icon: const Icon(Icons.upload_file_outlined),
            label: const Text('Upload video file'),
          ),
        ),
        if (vm.isLoading && vm.uploadingBlockId == block.id)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: LinearProgressIndicator(value: vm.uploadProgress),
          ),
      ],
    );
  }
}

class _CodeForm extends StatefulWidget {
  final ContentBlock block;
  final ContentEditorViewModel vm;
  const _CodeForm({required this.block, required this.vm});
  @override
  State<_CodeForm> createState() => _CodeFormState();
}

class _CodeFormState extends State<_CodeForm> {
  late TextEditingController _ctrl;
  late String _lang;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.block.content);
    _lang = widget.block.language ?? 'dart';
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _save() {
    widget.vm
        .updateBlock(widget.block.id, widget.block.copyWith(content: _ctrl.text, language: _lang));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          const Text('Language:', style: TextStyle(fontSize: 13)),
          const SizedBox(width: 8),
          DropdownButton<String>(
            value: _lang,
            isDense: true,
            items: const [
              DropdownMenuItem(value: 'dart', child: Text('Dart')),
              DropdownMenuItem(value: 'javascript', child: Text('JavaScript')),
              DropdownMenuItem(value: 'python', child: Text('Python')),
              DropdownMenuItem(value: 'swift', child: Text('Swift')),
              DropdownMenuItem(value: 'kotlin', child: Text('Kotlin')),
              DropdownMenuItem(value: 'bash', child: Text('Bash')),
              DropdownMenuItem(value: 'json', child: Text('JSON')),
              DropdownMenuItem(value: 'yaml', child: Text('YAML')),
              DropdownMenuItem(value: 'text', child: Text('Plain text')),
            ],
            onChanged: (v) {
              if (v != null) {
                setState(() => _lang = v);
                _save();
              }
            },
          ),
        ]),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: _ctrl,
            maxLines: null,
            style: const TextStyle(
                fontFamily: 'monospace', fontSize: 13, color: Color(0xFFD4D4D4)),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '// paste your code here',
              hintStyle: TextStyle(color: Colors.white24),
            ),
            onChanged: (_) => _save(),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Right-side toolbox (desktop)
// ─────────────────────────────────────────────────────────────
class _EditorToolbox extends StatelessWidget {
  final ContentEditorViewModel vm;
  const _EditorToolbox(this.vm);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _MetadataFields(vm),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          _ThumbnailPicker(vm),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          const Text('Add block',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          _AddBlockButtons(vm),
        ],
      ),
    );
  }
}

class _AddBlockButtons extends StatelessWidget {
  final ContentEditorViewModel vm;
  const _AddBlockButtons(this.vm);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        _addBtn(Icons.title, 'H1', () => vm.addBlock(ContentBlock.heading(level: 1))),
        _addBtn(Icons.format_size, 'H2', () => vm.addBlock(ContentBlock.heading(level: 2))),
        _addBtn(Icons.text_fields, 'Para', () => vm.addBlock(ContentBlock.paragraph())),
        _addBtn(Icons.image_outlined, 'Image', () => vm.addBlock(ContentBlock.image())),
        _addBtn(Icons.videocam_outlined, 'Video', () => vm.addBlock(ContentBlock.video())),
        _addBtn(Icons.code, 'Code', () => vm.addBlock(ContentBlock.code())),
        _addBtn(Icons.horizontal_rule, 'Divider', () => vm.addBlock(ContentBlock.divider())),
      ],
    );
  }

  Widget _addBtn(IconData icon, String label, VoidCallback onTap) {
    return ActionChip(
      avatar: Icon(icon, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      onPressed: onTap,
    );
  }
}

// ─────────────────────────────────────────────────────────────
// FAB for mobile "add block"
// ─────────────────────────────────────────────────────────────
class _AddBlockFab extends StatelessWidget {
  final ContentEditorViewModel vm;
  const _AddBlockFab(this.vm);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showAddSheet(context),
      tooltip: 'Add block',
      child: const Icon(Icons.add),
    );
  }

  void _showAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            _tile(context, Icons.title, 'Heading 1', () => vm.addBlock(ContentBlock.heading(level: 1))),
            _tile(context, Icons.format_size, 'Heading 2', () => vm.addBlock(ContentBlock.heading(level: 2))),
            _tile(context, Icons.text_fields, 'Paragraph', () => vm.addBlock(ContentBlock.paragraph())),
            _tile(context, Icons.image_outlined, 'Image', () => vm.addBlock(ContentBlock.image())),
            _tile(context, Icons.videocam_outlined, 'Video', () => vm.addBlock(ContentBlock.video())),
            _tile(context, Icons.code, 'Code Block', () => vm.addBlock(ContentBlock.code())),
            _tile(context, Icons.horizontal_rule, 'Divider', () => vm.addBlock(ContentBlock.divider())),
          ],
        ),
      ),
    );
  }

  Widget _tile(BuildContext ctx, IconData icon, String label, VoidCallback fn) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        fn();
        Navigator.pop(ctx);
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────
class _AlignPicker extends StatelessWidget {
  final String value;
  final void Function(String) onChanged;
  const _AlignPicker({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      isDense: true,
      items: const [
        DropdownMenuItem(value: 'left', child: Icon(Icons.format_align_left, size: 16)),
        DropdownMenuItem(value: 'center', child: Icon(Icons.format_align_center, size: 16)),
        DropdownMenuItem(value: 'right', child: Icon(Icons.format_align_right, size: 16)),
        DropdownMenuItem(value: 'justify', child: Icon(Icons.format_align_justify, size: 16)),
      ],
      onChanged: (v) { if (v != null) onChanged(v); },
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  final Color color;
  final void Function(Color) onChanged;
  const _ColorSwatch({required this.color, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickColor(context),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white38),
          ),
        ),
        const SizedBox(width: 4),
        const Text('Color', style: TextStyle(fontSize: 12)),
      ]),
    );
  }

  void _pickColor(BuildContext context) {
    Color picked = color;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Pick a color'),
        content: ColorPicker(
          pickerColor: color,
          onColorChanged: (c) => picked = c,
        ),
        actions: [
          TextButton(
            onPressed: () {
              onChanged(picked);
              Navigator.pop(context);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}

Color _parseColor(String? hex) {
  if (hex == null || hex.isEmpty) return Colors.white;
  try {
    final h = hex.replaceFirst('#', '');
    return Color(int.parse('FF$h', radix: 16));
  } catch (_) {
    return Colors.white;
  }
}
