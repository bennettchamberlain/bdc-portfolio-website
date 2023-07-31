part of home_page_view;

class _HomePageTablet extends StatelessWidget {
  final HomePageViewModel viewModel;

  _HomePageTablet (this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('HomePageTablet'),
      ),
    );
  }
}
