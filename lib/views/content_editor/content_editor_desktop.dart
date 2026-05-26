part of content_editor_view;

class _ContentEditorDesktop extends StatelessWidget {
  final ContentEditorViewModel viewModel;
  const _ContentEditorDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            viewModel.isEditMode
                ? 'Editing — ${viewModel.type}'
                : 'New — ${viewModel.type}',
            style: const TextStyle(fontSize: 20)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Consumer(
            builder: (context, ref, _) => FilledButton.icon(
              onPressed: viewModel.isLoading
                  ? null
                  : () async {
                      final ok = await viewModel.save();
                      if (ok && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Saved!')),
                        );
                      }
                    },
              icon: const Icon(Icons.cloud_upload_outlined),
              label: const Text('Publish'),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Left: metadata + block list ---
                Expanded(
                  flex: 3,
                  child: _EditorCanvas(viewModel),
                ),
                // --- Right: toolbox + thumbnail ---
                SizedBox(
                  width: 280,
                  child: _EditorToolbox(viewModel),
                ),
              ],
            ),
    );
  }
}
