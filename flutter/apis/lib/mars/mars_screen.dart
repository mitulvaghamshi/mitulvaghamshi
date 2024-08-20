import 'package:apis/common/image_widget.dart';
import 'package:apis/mars/mars.dart';
import 'package:flutter/cupertino.dart';

@immutable
class MarsScreen extends StatelessWidget {
  const MarsScreen.builder(this.photos, {super.key});

  final Iterable<Mars> photos;

  @override
  Widget build(BuildContext context) {
    const baseWidth = 180;
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.biggest.width;
      final count = width ~/ baseWidth;
      return CustomScrollView(slivers: [
        const CupertinoSliverNavigationBar(
          largeTitle: Text('Mars Photos'),
        ),
        SliverSafeArea(
          minimum: const EdgeInsets.all(16),
          sliver: SliverGrid.builder(
            itemCount: photos.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: count,
              childAspectRatio: 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) => ImageWidget(
              url: photos.elementAt(index).imageUrl,
              size: count == 1 ? width : ((width % baseWidth) / 2) + baseWidth,
            ),
          ),
        ),
      ]);
    });
  }
}
