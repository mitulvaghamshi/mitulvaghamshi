import 'package:cupertino_store/models/app_state.dart';
import 'package:cupertino_store/pages/gallery/widgets/gallery_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

const _cardRatio = 12 / 18;

@immutable
class GalleryWidget extends StatefulWidget {
  const GalleryWidget({super.key, required this.count});

  final int count;

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  late final _model = context.read<AppState>();

  late final _pageCtrl = PageController(initialPage: widget.count - 1)
    ..addListener(_onPageChanged);

  late double _activeCard = widget.count - 1;

  void _onPageChanged() => _activeCard = _pageCtrl.page!;

  @override
  void dispose() {
    _pageCtrl.removeListener(_onPageChanged);
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      AspectRatio(
        aspectRatio: _cardRatio,
        child: ListenableBuilder(
          listenable: _pageCtrl,
          builder: (context, child) => Stack(
            children: .generate(widget.count, (index) {
              return GalleryItem(
                pageIndex: index,
                activeCard: _activeCard,
                product: _model.getProductBy(index),
              );
            }),
          ),
        ),
      ),
      Positioned.fill(
        child: PageView.builder(
          reverse: true,
          itemCount: widget.count,
          controller: _pageCtrl,
          itemBuilder: (_, _) => const SizedBox(),
        ),
      ),
    ],
  );
}
