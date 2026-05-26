part of admin_dashboard_view;

class _AdminDashboardTablet extends StatelessWidget {
  final AdminDashboardViewModel viewModel;
  const _AdminDashboardTablet(this.viewModel);

  @override
  Widget build(BuildContext context) => _AdminBody(viewModel);
}

