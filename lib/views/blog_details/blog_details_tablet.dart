part of blog_details_view;

class _BlogDetailsTablet extends StatelessWidget {
  final BlogDetailsViewModel viewModel;

  _BlogDetailsTablet (this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('BlogDetailsTablet'),
      ),
    );
  }
}
