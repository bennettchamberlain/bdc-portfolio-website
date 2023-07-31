part of blog_view;

class _BlogMobile extends StatefulWidget {
  final BlogViewModel viewModel;

  const _BlogMobile(this.viewModel);

  @override
  State<_BlogMobile> createState() => _BlogMobileState();
}

class _BlogMobileState extends State<_BlogMobile> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) => setState(() {
          widget.viewModel.selectedNavigation = true;
        }));

    super.initState();
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
                        padding: const EdgeInsets.all(15),
                        child: SizedBox(
                          height: 400,
                          child: FutureBuilder<List<Blog>>(
                              future: widget.viewModel.blogs,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return ListView.builder(
                                      itemBuilder: (context, index) {
                                        Blog blog = snapshot.data![index];
                                        return BlogCard(
                                          id: blog.id,

                                          // blogContent: [Text(blog.title)],

                                          mobile: true,
                                          type: widget.viewModel.type,
                                        );
                                      },
                                      itemCount: snapshot.data!.length);
                                }
                              }),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    const MyFooter(mobile: true),
                  ],
                ),
                const MyNavigationBar(mobile: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
