part of create_bog_view;

class _CreateBogMobile extends StatefulWidget {
  final CreateBogViewModel viewModel;

  const _CreateBogMobile(this.viewModel);

  @override
  State<_CreateBogMobile> createState() => _CreateBogMobileState();
}

class _CreateBogMobileState extends State<_CreateBogMobile> {
  @override
  void initState() {
    widget.viewModel.controller = QuillEditorController();
    widget.viewModel.controller.onTextChanged((text) {
      debugPrint('listening to $text');
    });
    super.initState();
  }

  @override
  void dispose() {
    /// please do not forget to dispose the controller
    widget.viewModel.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              " New Blog",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: LoadingOverlay(
        isLoading: widget.viewModel.isLoading,
        child: SafeArea(
          child: ListView(children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(hintText: "Author Name"),
                    onChanged: (val) {
                      widget.viewModel.authorName = val;
                    },
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: "Title"),
                    onChanged: (val) {
                      widget.viewModel.title = val;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 50,
              child: ToolBar.scroll(
                toolBarColor: widget.viewModel.toolbarColor,
                toolBarConfig: widget.viewModel.customToolBarList,
                padding: const EdgeInsets.all(8),
                iconSize: 25,
                iconColor: widget.viewModel.toolbarIconColor,
                activeIconColor: Colors.greenAccent.shade400,
                controller: widget.viewModel.controller,
                crossAxisAlignment: CrossAxisAlignment.center,
                direction: Axis.horizontal,
              ),
            ),
           ListView.builder(
            itemCount: widget.viewModel.elements.length,
            itemBuilder: (context, index) {
             
             return widget.viewModel.elements[index].getWidget();
            }),
            SizedBox(height: 10),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final singleImageProgress =
                    ref.watch(singleUploadProgressProvider);
                return SizedBox(
                  width: 300,
                  child: Column(
                    children: [
                      const Text(
                        "Image Library",
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      singleImageProgress != 0
                          ? CircularPercentIndicator(
                              radius: 60,
                              lineWidth: 5.0,
                              percent: singleImageProgress,
                              center: Text(
                                (singleImageProgress).toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              progressColor: Colors.green,
                            )
                          : GestureDetector(
                              onTap: () => widget.viewModel.getImage(ref),
                              child: SizedBox(
                                height: 45,
                                width: 300,
                                child: Card(
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                      child: Text(
                                    "Add Image",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 925,
                        width: 400,
                        child:
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                stream: widget.viewModel.getImages,
                                builder: (builder, snap) {
                                  if (snap.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (!snap.hasData &&
                                      snap.hasError &&
                                      snap.data == null) {
                                    return const Text("nothing to show");
                                  } else {
                                    print('length ${snap.data!.size}');
                                    return GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 3.0,
                                          mainAxisSpacing: 2.0,
                                        ),
                                        itemCount: snap.data?.size,
                                        itemBuilder: (context, index) {
                                          if (snap.connectionState ==
                                              ConnectionState.waiting) {}
                                          print(snap.data!.docs[index]
                                              .data()['url']);
                                          return GestureDetector(
                                            onTap: () {
                                              widget.viewModel
                                                  .insertNetworkImage(snap
                                                      .data!.docs[index]
                                                      .data()['url']);
                                            },
                                            child: Stack(
                                              children: [
                                                FastCachedImage(
                                                  url: snap.data!.docs[index]
                                                      .data()['url'],
                                                  fit: BoxFit.cover,
                                                  fadeInDuration:
                                                      const Duration(
                                                          seconds: 1),
                                                  errorBuilder: (context,
                                                      exception, stacktrace) {
                                                    return Text(
                                                        stacktrace.toString());
                                                  },
                                                  loadingBuilder:
                                                      (context, progress) {
                                                    debugPrint(
                                                        'Progress: ${progress.isDownloading} ${progress.downloadedBytes} / ${progress.totalBytes}');
                                                    return Container(
                                                      color: Colors.white,
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          if (progress
                                                                  .isDownloading &&
                                                              progress.totalBytes !=
                                                                  null)
                                                            Text(
                                                                '${progress.downloadedBytes ~/ 1024} / ${progress.totalBytes! ~/ 1024} kb',
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .red)),
                                                          SizedBox(
                                                              width: 120,
                                                              height: 120,
                                                              child: CircularProgressIndicator(
                                                                  color: Colors
                                                                      .red,
                                                                  value: progress
                                                                      .progressPercentage
                                                                      .value)),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: QudsPopupButton(
                                                      items: [
                                                        QudsPopupMenuWidget(
                                                            builder: (c) =>
                                                                Container(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10),
                                                                    child:
                                                                        IntrinsicHeight(
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          IconButton(
                                                                              tooltip: 'Remove Image',
                                                                              onPressed: () {
                                                                                widget.viewModel.deleteImage(snap.data!.docs[index].id);
                                                                              },
                                                                              icon: const Icon(
                                                                                Icons.delete,
                                                                                color: Colors.red,
                                                                              )),
                                                                          const VerticalDivider(),
                                                                          IconButton(
                                                                              tooltip: 'Set as Blog Thumbnail',
                                                                              onPressed: () {
                                                                                widget.viewModel.selectThumnail(snap.data!.docs[index].data()['url']);
                                                                              },
                                                                              icon: const Icon(
                                                                                Icons.add_photo_alternate_rounded,
                                                                                color: Colors.blue,
                                                                              )),
                                                                          VerticalDivider(),
                                                                        ],
                                                                      ),
                                                                    )))
                                                      ],
                                                      child: Icon(Icons.menu)),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  }
                                }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: FilledButton(
                            onPressed: () async =>
                                await widget.viewModel.uploadBlog(),
                            child: const Text(
                              'Upload Blog',
                              style: TextStyle(color: Colors.black),
                            )),
                      )
                    ],
                  ),
                );
              },
            )
          ]),
        ),
      ),
    );
  }
}
