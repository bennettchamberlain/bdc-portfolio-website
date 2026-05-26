part of admin_dashboard_view;

class _AdminDashboardDesktop extends StatelessWidget {
  final AdminDashboardViewModel viewModel;
  const _AdminDashboardDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) => _AdminBody(viewModel);
}

