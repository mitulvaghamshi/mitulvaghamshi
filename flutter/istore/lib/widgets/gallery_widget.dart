import 'package:istore/widgets/gallery_item.dart';
import 'package:flutter/cupertino.dart';

@immutable
class GalleryWidget extends StatelessWidget {
  GalleryWidget({super.key, required this.count});

  final int count;

  late final currentCard = ValueNotifier(count - 1.0);
  late final PageController controller = PageController(initialPage: count - 1)
    ..addListener(() => currentCard.value = controller.page!);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ValueListenableBuilder(
        valueListenable: currentCard,
        builder: (context, value, child) => AspectRatio(
          aspectRatio: 12.0 / 18.0 * 1.2,
          child: LayoutBuilder(builder: (_, constraints) {
            return Stack(
              children: List.generate(count, (index) {
                return GalleryItem(
                  index: index,
                  currentCard: value,
                  constraints: constraints,
                );
              }),
            );
          }),
        ),
      ),
      Positioned.fill(
        child: PageView.builder(
          reverse: true,
          itemCount: count,
          controller: controller,
          itemBuilder: (_, __) => const SizedBox(),
        ),
      ),
    ]);
  }
}
