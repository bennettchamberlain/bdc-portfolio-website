part of blog_view;

class _BlogDesktop extends StatefulWidget {
  final BlogViewModel viewModel;

  const _BlogDesktop(this.viewModel);

  @override
  State<_BlogDesktop> createState() => _BlogDesktopState();
}

class _BlogDesktopState extends State<_BlogDesktop> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) => setState(() {
          widget.viewModel.selectedNavigation = true;
        }));

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 110,
                    ),

                    //PUT EVERYTIHING HERE
                    Container(
                      decoration: BoxDecoration(border: Border.all(width: 8)),
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: SizedBox(
                          height: 800,
                          child: FutureBuilder<List<Blog>>(
                              future: widget.viewModel.blogs,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  if (snapshot.data!.isNotEmpty &&
                                      !snapshot.hasError) {
                                    return ListView.builder(
                                        itemBuilder: (context, index) {
                                          Blog blog = snapshot.data![index];
                                          return BlogCard(
                                            id: blog.id,
                                            mobile: false,
                                            type: widget.viewModel.type,
                                            blog: blog,
                                          );
                                        },
                                        itemCount: snapshot.data!.length);
                                  } else {
                                    return const Text("No Blogs to Show");
                                  }
                                }
                              }),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    const MyFooter(mobile: false),
                  ],
                ),
                const MyNavigationBar(mobile: false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
