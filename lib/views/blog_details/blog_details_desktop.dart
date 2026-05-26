part of blog_details_view;

class _BlogDetailsDesktop extends StatelessWidget {
  final BlogDetailsViewModel viewModel;

  const _BlogDetailsDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Blog>(
        future: viewModel.getBlog(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.hasError) {
            return const Center(child: Text('Content not found.'));
          }
          final blog = snapshot.data!;
          return Stack(
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 860),
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(40, 130, 40, 32),
                    children: [
                      blogAdBanner(
                        adUnitCode: viewModel.adUnitCode,
                        debug: false,
                        width: double.infinity,
                        height: 100,
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          border: Border.all(width: 4),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              blog.title,
                              style: const TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Primetime',
                                  color: Colors.black),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'By ${blog.authorName}',
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            if (blog.desc.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                blog.desc,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      ...blog.blocks
                          .map((b) => ContentBlockWidget(block: b)),
                      const SizedBox(height: 48),
                      MyFooter(mobile: false),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              const MyNavigationBar(mobile: false),
            ],
          );
        },
      ),
    );
  }
}
