part of about_view;

class _AboutMobile extends StatefulWidget {
  final AboutViewModel viewModel;

  const _AboutMobile(this.viewModel);

  @override
  State<_AboutMobile> createState() => _AboutMobileState();
}

class _AboutMobileState extends State<_AboutMobile> {
  bool pageAnimation = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 600))
        .then((value) => setState(() {
              pageAnimation = true;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double containerWidth = size.width - 30 - 16;
    final double pdfHeight = containerWidth * (792.0 / 612.0);
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
                    const SizedBox(height: 65),
                    AnimatedContainer(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black, width: 8)),
                      curve: Curves.fastOutSlowIn,
                      duration: const Duration(milliseconds: 1100),
                      height: pageAnimation ? pdfHeight : 0,
                      width: size.width - 30,
                      child: _ResumePdfSection(
                        resumeFuture: widget.viewModel.getResumeUrl(),
                        containerWidth: containerWidth,
                      ),
                    ),
                    const SizedBox(height: 20),
                    MyFooter(mobile: true),
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

