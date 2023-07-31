part of admin_dashboard_view;

class _AdminDashboardDesktop extends StatelessWidget {
  final AdminDashboardViewModel viewModel;

  const _AdminDashboardDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Dashboard"), actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            FirebaseAuth.instance.signOut();
            context.vRouter.to("/login");
          },
        )
      ]),
      body: SingleChildScrollView(
          child: Center(
              child: Column(children: [
        const SizedBox(height: 20),
        TextButton(
          child: const Text("Add a new Blog"),
          onPressed: () {
            context.vRouter.to("/createBlog/blogs");
          },
        ),
        const SizedBox(height: 20),
        TextButton(
          child: const Text("Add a new Project"),
          onPressed: () {
            context.vRouter.to("/createBlog/projects");
          },
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: viewModel.handleUploadButtonPressed,
          child: const Text("Replace resume on about page"),
        )
      ]))),
    );
  }
}
