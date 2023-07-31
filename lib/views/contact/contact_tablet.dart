part of contact_view;

class _ContactTablet extends StatelessWidget {
  final ContactViewModel viewModel;

  _ContactTablet (this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('ContactTablet'),
      ),
    );
  }
}
