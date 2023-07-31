part of error_view;

class _ErrorTablet extends StatelessWidget {
  final ErrorViewModel viewModel;

  _ErrorTablet (this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('ErrorTablet'),
      ),
    );
  }
}
