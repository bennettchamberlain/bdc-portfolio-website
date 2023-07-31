part of about_view;

class _AboutTablet extends StatelessWidget {
  final AboutViewModel viewModel;

  _AboutTablet (this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('AboutTablet'),
      ),
    );
  }
}
