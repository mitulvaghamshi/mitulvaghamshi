import 'package:flutter/cupertino.dart';

@immutable
class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, required this.url, required this.size});

  final String url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        url,
        fit: BoxFit.cover,
        width: size,
        height: size,
        cacheWidth: size.toInt(),
        cacheHeight: size.toInt(),
        frameBuilder: (_, child, frame, __) => AnimatedCrossFade(
          duration: const Duration(seconds: 1),
          firstChild: const Center(child: CupertinoActivityIndicator()),
          secondChild: child,
          crossFadeState: frame == null
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ),
      ),
    );
  }
}
