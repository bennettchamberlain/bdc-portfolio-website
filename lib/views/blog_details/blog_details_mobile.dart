part of blog_details_view;

class _BlogDetailsMobile extends StatelessWidget {
  final BlogDetailsViewModel viewModel;

  _BlogDetailsMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Blog>(
          future: viewModel.getBlog(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(50.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FlutterAdManagerWeb(
                            adUnitCode: viewModel.adUnitCode,
                            debug: true,
                            width: 1100,
                            height: 100,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Text(
                              snapshot.data!.title,
                              style: const TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Primetime'),
                            ),
                          ),
                          const Divider(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                            child: Text(
                              'By ${snapshot.data!.authorName}',
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 20),
                            ),
                          ),
                          const Divider(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(height: 40.0),
                          Text(
                            snapshot.data!.desc,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ]);
            }
          }),
    );
  }
}
