part of content_editor_view;

class _ContentEditorMobile extends StatelessWidget {
  final ContentEditorViewModel viewModel;
  const _ContentEditorMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editor — ${viewModel.type}',
            style: const TextStyle(fontSize: 18)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Consumer(
            builder: (context, ref, _) => IconButton(
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
              tooltip: 'Publish',
            ),
          ),
        ],
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(12),
              children: [
                _MetadataFields(viewModel),
                const SizedBox(height: 12),
                _ThumbnailPicker(viewModel),
                const SizedBox(height: 16),
                _EditorCanvas(viewModel),
                const SizedBox(height: 80),
              ],
            ),
      floatingActionButton: _AddBlockFab(viewModel),
    );
  }
}
