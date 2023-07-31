part of blog_view;

class _BlogTablet extends StatelessWidget {
  final BlogViewModel viewModel;

  _BlogTablet (this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('BlogTablet'),
      ),
    );
  }
}
