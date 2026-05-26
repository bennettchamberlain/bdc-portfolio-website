part of admin_dashboard_view;

class _AdminDashboardMobile extends StatelessWidget {
  final AdminDashboardViewModel viewModel;
  const _AdminDashboardMobile(this.viewModel);

  @override
  Widget build(BuildContext context) => _AdminBody(viewModel);
}

