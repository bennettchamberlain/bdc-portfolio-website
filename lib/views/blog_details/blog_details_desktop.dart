part of blog_details_view;

class _BlogDetailsDesktop extends StatelessWidget {
  final BlogDetailsViewModel viewModel;

  const _BlogDetailsDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Blog>(
          future: viewModel.getBlog(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              List<UIComponent> components = snapshot.data!.getAllUIElements();
              List<UIComponent> componentsM2 =
                  snapshot.data!.getAllUIElements();

              componentsM2.removeAt(0);
              componentsM2.removeAt(0);

              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width - 10,
                    decoration: BoxDecoration(border: Border.all(width: 8)),
                    child: Column(
                      children: [
                        components[0].getWidget(),
                        Text("By: ${snapshot.data!.authorName}"),
                        SizedBox(height: 10)
                      ],
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width - 10,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(width: 8),
                              bottom: BorderSide(width: 8),
                              left: BorderSide(width: 8))),
                      child: components[1].getWidget()),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    constraints: BoxConstraints(maxWidth: 100),
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(width: 8),
                            bottom: BorderSide(width: 8),
                            left: BorderSide(width: 8))),
                    child: Column(
                      children: componentsM2.map((e) => e.getWidget()).toList(),
                    ),
                  ),
                  MyFooter(mobile: false),
                  SizedBox(height: 20)
                ],
                //children: components.map((e) => e.getWidget()).toList(),
              );
              //  viewModel.setHtmlText(snapshot.data!.html);
              // return ListView(
              //     physics: ClampingScrollPhysics(),
              //     shrinkWrap: true,
              //     children: [
              //       Container(
              //         margin: const EdgeInsets.all(10.0),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [

              //             Padding(
              //               padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
              //               child: Text(
              //                 snapshot.data!.title,
              //                 style: const TextStyle(
              //                     fontSize: 50,
              //                     fontWeight: FontWeight.bold,
              //                     fontFamily: 'Primetime'),
              //               ),
              //             ),
              //             const Divider(
              //               height: 10,
              //             ),
              //             Padding(
              //               padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
              //               child: Text(
              //                 'By ${snapshot.data!.authorName}',
              //                 style: const TextStyle(
              //                     fontStyle: FontStyle.italic, fontSize: 20),
              //               ),
              //             ),
              //             const Divider(
              //               height: 10,
              //             ),
              //             const SizedBox(
              //               height: 20,
              //             ),
              //             SizedBox(
              //               height: 100,
              //               width: 400,
              //               child: Padding(
              //                  padding: const EdgeInsets.symmetric(horizontal: 250,vertical: 20
              //                  ),
              //                  child: ListView(
              //                           shrinkWrap: true,
              //                   children: viewModel.elements.map((e) => e.getWidget()).toList(),
              //                         ),
              //                ),
              //             ),
              //             const SizedBox(height: 40.0),
              //             Text(
              //               snapshot.data!.desc,
              //               style: const TextStyle(fontSize: 16),
              //             ),
              //             //   FlutterAdManagerWeb(
              //             //   adUnitCode: viewModel.adUnitCode,
              //             //   debug: false,
              //             //   width: double.infinity,
              //             //   height: 100,

              //             // ),
              //           //  const BannerAdUnit()
              //           ],
              //         ),
              //       ),
              //     ]);
            }
          }),
    );
  }
}
