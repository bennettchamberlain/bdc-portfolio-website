part of create_bog_view;

class _CreateBogTablet extends StatelessWidget {
  final CreateBogViewModel viewModel;

  _CreateBogTablet (this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('CreateBogTablet'),
      ),
    );
  }
}
