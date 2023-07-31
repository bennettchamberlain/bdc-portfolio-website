part of home_page_view;

class _HomePageDesktop extends StatefulWidget {
  final HomePageViewModel viewModel;
  
  const _HomePageDesktop (this.viewModel);

  @override
  State<_HomePageDesktop> createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<_HomePageDesktop> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          widget.viewModel.selectedNavigation = true;
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 110,
                        ),
                        //PUT EVERYTIHING HERE
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 450,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 8, color: Colors.black)),
                              child: Image.asset("assets/images/headshot.jpg"),
                            ),
                            const SizedBox(width: 15),
                            AnimatedContainer(
                              curve: Curves.fastOutSlowIn,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 8, color: Colors.black)),
                              duration: const Duration(milliseconds: 1600),
                              height: widget.viewModel.selectedNavigation ? 505 : 0,
                              width: size.width - 495,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: SizedBox(
                                    width: 500,
                                    child: AnimatedTextKit(
                                      totalRepeatCount: 1,
                                      animatedTexts: [
                                        TyperAnimatedText(
                                            "Software Engineer\nProject Manager\nLifelong Student",
                                            speed: const Duration(
                                              milliseconds: 100,
                                            ),
                                            textStyle: const TextStyle(
                                                fontFamily: "Helvetica-Bold",
                                                fontSize: 50))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 25),
                        const MyFooter(mobile: false),
                      ],
                    ),
                    const MyNavigationBar(mobile: false),
                  ],
                ),
              ),
              const MyMarquee(
                  mobile: false,
                  text:
                      " Pixel perfect designs. Cross-platform applications. Full-stack websites. "),
            ],
          ),
        ),
      ),
    );
  }
}
