part of admin_dashboard_view;

class _AdminDashboardTablet extends StatelessWidget {
  final AdminDashboardViewModel viewModel;

  _AdminDashboardTablet (this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('AdminDashboardTablet'),
      ),
    );
  }
}
