part of blog_details_view;

class _BlogDetailsMobile extends StatelessWidget {
  final BlogDetailsViewModel viewModel;

  const _BlogDetailsMobile(this.viewModel);

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
              ListView(
                padding:
                    const EdgeInsets.fromLTRB(20, 130, 20, 24),
                children: [
                  blogAdBanner(
                    adUnitCode: viewModel.adUnitCode,
                    debug: true,
                    width: double.infinity,
                    height: 100,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    blog.title,
                    style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Primetime',
                        color: Colors.black),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'By ${blog.authorName}',
                    style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                        color: Colors.black),
                  ),
                  if (blog.desc.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(blog.desc,
                        style: const TextStyle(
                            fontSize: 15, color: Colors.black54)),
                  ],
                  const Divider(height: 32),
                  ...blog.blocks.map((b) => ContentBlockWidget(block: b)),
                  const SizedBox(height: 40),
                  MyFooter(mobile: true),
                ],
              ),
              const MyNavigationBar(mobile: true),
            ],
          );
        },
      ),
    );
  }
}
