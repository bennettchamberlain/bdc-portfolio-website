part of login_view;

class _LoginMobile extends StatelessWidget {
  final LoginViewModel viewModel;

  const _LoginMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providers: viewModel.providers,
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) {
          context.vRouter.to("/adminDashboard");
        }),
      ],
    );
  }
}
