part of error_view;

class _ErrorDesktop extends StatefulWidget {
  final ErrorViewModel viewModel;

  const _ErrorDesktop(this.viewModel);

  @override
  State<_ErrorDesktop> createState() => _ErrorDesktopState();
}

class _ErrorDesktopState extends State<_ErrorDesktop> {
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
                          height: 150,
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: const RiveAnimation.asset(
                              '/animations/404.riv',
                              artboard: '404-error.svg',
                              fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 50),
                        const SizedBox(height: 50),
                        const MyFooter(mobile: false),
                      ],
                    ),
                    const MyNavigationBar(mobile: false),
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
