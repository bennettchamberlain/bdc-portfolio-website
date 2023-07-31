part of login_view;

class _LoginDesktop extends StatelessWidget {
  final LoginViewModel viewModel;
  
  const _LoginDesktop (this.viewModel);
  
  @override
  Widget build(BuildContext context) {
     return SignInScreen(
            providers: viewModel.providers,
            showAuthActionSwitch: true,
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
              context.vRouter.to("/adminDashboard");
              }),
            ],
          );
  }
}
