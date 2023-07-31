part of about_view;

class _AboutDesktop extends StatefulWidget {
  final AboutViewModel viewModel;

  _AboutDesktop(this.viewModel);

  @override
  State<_AboutDesktop> createState() => _AboutDesktopState();
}

class _AboutDesktopState extends State<_AboutDesktop> {
  bool selectedNavigation = false;
  bool pageAnimation = false;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          selectedNavigation = true;
        }));
    Future.delayed(const Duration(milliseconds: 600))
        .then((value) => setState(() {
              pageAnimation = true;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    Stack(
                      children: [
                        Container(
                          height: 1000,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            AnimatedContainer(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 8)),
                              curve: Curves.fastOutSlowIn,
                              duration: const Duration(milliseconds: 1100),
                              height: pageAnimation ? 980 : 0,
                              width: size.width,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    FutureBuilder<Resume?>(
                                        future: widget.viewModel.getResumeUrl(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return CircularProgressIndicator();
                                          } else {
                                            return SizedBox(
                                              height: 980,
                                              width: 1000,
                                              child: SfPdfViewer.network(
                                                  snapshot.data!.url,
                                                  initialZoomLevel: 1.5,
                                                  canShowPaginationDialog: true,
                                                  canShowScrollHead: true,
                                                  canShowScrollStatus: true),
                                            );
                                          }
                                        }),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    MyFooter(mobile: false)
                  ],
                ),
                //PUT EVERYTIHING HERE
                // Positioned(
                //   top: 600,
                //   width: size.width,
                //   child: MyFooter(
                //     mobile: false,
                //   ),
                // ),
                const MyNavigationBar(mobile: false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
