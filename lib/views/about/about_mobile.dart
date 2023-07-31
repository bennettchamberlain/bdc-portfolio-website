part of about_view;

class _AboutMobile extends StatefulWidget {
  final AboutViewModel viewModel;

  const _AboutMobile(this.viewModel);

  @override
  State<_AboutMobile> createState() => _AboutMobileState();
}

class _AboutMobileState extends State<_AboutMobile> {
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
                      height: 65,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 700,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 8)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            AnimatedContainer(
                              curve: Curves.fastOutSlowIn,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(width: 8, color: Colors.black),
                                ),
                              ),
                              duration: const Duration(milliseconds: 1100),
                              height: pageAnimation ? 690 : 0,
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
                                              height: 690,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  50,
                                              child: SfPdfViewer.network(
                                                  snapshot.data!.url,
                                                  initialZoomLevel: 1,
                                                  enableDoubleTapZooming: true,
                                                  canShowScrollHead: true,
                                                  canShowScrollStatus: false),
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
                    const SizedBox(height: 20),
                    MyFooter(mobile: true)
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
                const MyNavigationBar(mobile: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
