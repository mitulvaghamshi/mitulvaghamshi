import 'package:flutter/material.dart';
import 'package:sphere/models/surface.dart';

@immutable
class SurfaceList extends StatelessWidget {
  const SurfaceList({super.key, required this.onSelect});

  final ValueChanged<Surface> onSelect;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 210,
      itemCount: Surface.values.length - 1, // Excluding background
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final surface = Surface.values[index];
        return InkWell(
          onTap: () => onSelect(surface),
          child: Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(surface.thumbPath),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  surface.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}
