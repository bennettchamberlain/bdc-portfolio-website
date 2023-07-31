part of create_content_view;

class _CreateContentTablet extends StatelessWidget {
  final CreateContentViewModel viewModel;

  _CreateContentTablet (this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('CreateContentTablet'),
      ),
    );
  }
}
