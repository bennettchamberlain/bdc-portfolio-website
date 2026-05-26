import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart' as hex;
import '../../core/models/content_block.dart';

/// Read-only renderer for a single [ContentBlock].
class ContentBlockWidget extends StatelessWidget {
  final ContentBlock block;

  const ContentBlockWidget({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    switch (block.type) {
      case ContentBlockType.heading:
        return _HeadingBlock(block);
      case ContentBlockType.paragraph:
        return _ParagraphBlock(block);
      case ContentBlockType.image:
        return _ImageBlock(block);
      case ContentBlockType.video:
        return _VideoBlock(block);
      case ContentBlockType.code:
        return _CodeBlock(block);
      case ContentBlockType.divider:
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Divider(thickness: 1),
        );
    }
  }
}

class _HeadingBlock extends StatelessWidget {
  final ContentBlock block;
  const _HeadingBlock(this.block);

  @override
  Widget build(BuildContext context) {
    final level = block.level ?? 1;
    final sizes = {1: 36.0, 2: 28.0, 3: 22.0};
    final size = sizes[level] ?? 28.0;
    Color color = Colors.black;
    try {
      if (block.colorHex != null && block.colorHex!.isNotEmpty) {
        color = hex.HexColor(block.colorHex!);
      }
    } catch (_) {}

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        block.content ?? '',
        textAlign: _textAlign(block.align),
        style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.bold,
          color: color,
          fontFamily: 'Primetime',
        ),
      ),
    );
  }
}

class _ParagraphBlock extends StatelessWidget {
  final ContentBlock block;
  const _ParagraphBlock(this.block);

  @override
  Widget build(BuildContext context) {
    Color color = Colors.black;
    try {
      if (block.colorHex != null && block.colorHex!.isNotEmpty) {
        color = hex.HexColor(block.colorHex!);
      }
    } catch (_) {}

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        block.content ?? '',
        textAlign: _textAlign(block.align),
        style: TextStyle(
          fontSize: block.fontSize ?? 16,
          fontWeight: _fontWeight(block.fontWeight),
          fontFamily: block.fontFamily ?? 'Helvetica',
          color: color,
        ),
      ),
    );
  }
}

class _ImageBlock extends StatelessWidget {
  final ContentBlock block;
  const _ImageBlock(this.block);

  @override
  Widget build(BuildContext context) {
    if (block.url == null || block.url!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              block.url!,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Container(
                height: 200,
                color: Colors.grey.shade100,
                child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
              ),
            ),
          ),
          if (block.caption != null && block.caption!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                block.caption!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: Colors.black54),
              ),
            ),
        ],
      ),
    );
  }
}

class _VideoBlock extends StatelessWidget {
  final ContentBlock block;
  const _VideoBlock(this.block);

  @override
  Widget build(BuildContext context) {
    final url = block.url ?? '';
    if (url.isEmpty) return const SizedBox.shrink();
    // Embed YouTube iframes on web; for storage videos show a link
    final isYoutube = url.contains('youtube.com') || url.contains('youtu.be');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white24),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.play_circle_outline, size: 36, color: Colors.white70),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isYoutube ? 'YouTube Video' : 'Video',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Text(
                    url,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final ContentBlock block;
  const _CodeBlock(this.block);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (block.language != null && block.language!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  block.language!,
                  style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 12,
                      fontFamily: 'monospace'),
                ),
              ),
            SelectableText(
              block.content ?? '',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                color: Color(0xFFD4D4D4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- helpers ---
TextAlign _textAlign(String? align) {
  switch (align) {
    case 'center':
      return TextAlign.center;
    case 'right':
      return TextAlign.right;
    case 'justify':
      return TextAlign.justify;
    default:
      return TextAlign.left;
  }
}

FontWeight _fontWeight(String? fw) {
  switch (fw) {
    case 'bold':
      return FontWeight.bold;
    case 'w100':
      return FontWeight.w100;
    case 'w200':
      return FontWeight.w200;
    case 'w300':
      return FontWeight.w300;
    case 'w400':
      return FontWeight.w400;
    case 'w500':
      return FontWeight.w500;
    default:
      return FontWeight.normal;
  }
}
