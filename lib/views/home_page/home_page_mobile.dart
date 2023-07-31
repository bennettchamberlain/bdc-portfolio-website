part of home_page_view;

class _HomePageMobile extends StatefulWidget {
  final HomePageViewModel viewModel;

  const _HomePageMobile (this.viewModel);

  @override
  State<_HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<_HomePageMobile> {
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
                        const SizedBox(height: 65),
                        //PUT EVERYTIHING HERE
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 8, color: Colors.black)),
                              child: Image.asset("assets/images/headshot.jpg"),
                            ),
                            const SizedBox(height: 15),
                            AnimatedContainer(
                              curve: Curves.fastOutSlowIn,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 8, color: Colors.black)),
                              duration: const Duration(milliseconds: 1600),
                              height: widget.viewModel.selectedNavigation ? 150 : 0,
                              width: size.width,
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
                                                fontSize: 20))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 25),
                        MyFooter(mobile: true),
                      ],
                    ),
                    const MyNavigationBar(mobile: true),
                  ],
                ),
              ),
              const MyMarquee(
                  mobile: true,
                  text:
                      " Pixel perfect designs. Cross-platform applications. Full-stack websites. "),
            ],
          ),
        ),
      ),
    );
  }
}
