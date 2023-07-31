part of create_content_view;

class _CreateContentMobile extends ConsumerWidget {
  final CreateContentViewModel viewModel;

  _CreateContentMobile(this.viewModel);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final type = VRouter.of(context).pathParameters['type'];
    final uploadProgress = ref.watch(uploadProgressProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              viewModel.uploadBlog(ref);
            },
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon(Icons.file_upload)),
          )
        ],
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Flutter",
              style: TextStyle(fontSize: 22),
            ),
            Text(
              "Blog",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              viewModel.getImage(ref);
            },
            child: viewModel.selectedImage!.length > 5
                ? SizedBox(
                    height: 450,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            height: 350,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            child: const Icon(Icons.add_a_photo,
                                color: Colors.black45),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: ListView.builder(
                              itemCount: viewModel.selectedImages.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  height: 250,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              viewModel.selectThumbnail(index);
                                            },
                                            icon: const Icon(
                                              Icons.sticky_note_2_outlined,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                          Text(
                                              index ==
                                                      viewModel
                                                          .selectedThumbnail
                                                  ? "Thumbnail"
                                                  : "",
                                              style: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontWeight: FontWeight.bold)),
                                          IconButton(
                                            onPressed: () {
                                              viewModel.removeImage(index);
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.redAccent,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 300,
                                        width: 200,
                                        child: LoadingOverlay(
                                          isLoading: true,
                                          progressIndicator:
                                              UploadWidget(item: index),
                                          child: Container(
                                            height: 200,
                                            width: 200,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              border: Border.all(
                                                  color: index ==
                                                          viewModel
                                                              .selectedThumbnail
                                                      ? Colors.redAccent
                                                      : Colors.blue,
                                                  width: 4),
                                            ),
                                            child: Image.memory(
                                              viewModel.selectedImages[index]!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)),
                    child: const Icon(Icons.add_a_photo, color: Colors.black45),
                  ),
          ),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(hintText: "Author Name"),
                  onChanged: (val) {
                    viewModel.authorName = val;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(hintText: "Title"),
                  onChanged: (val) {
                    viewModel.title = val;
                  },
                ),
                TextField(
                  maxLines: null,
                  decoration: const InputDecoration(hintText: "Description"),
                  onChanged: (val) {
                    viewModel.desc = val;
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
