part of error_view;

class _ErrorMobile extends StatefulWidget {
  final ErrorViewModel viewModel;

  _ErrorMobile (this.viewModel);

  @override
  State<_ErrorMobile> createState() => _ErrorMobileState();
}

class _ErrorMobileState extends State<_ErrorMobile> {
 

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: const SelectableText(
                            "This page doesnt exist...Awkward",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 500),
                          child: const RiveAnimation.asset(
                              '/animations/404.riv',
                              artboard: '404-error.svg',
                              fit: BoxFit.contain),
                        ),
                        const MyFooter(mobile: true),
                      ],
                    ),
                    const MyNavigationBar(mobile: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
