import 'package:flutter/material.dart';
import 'package:sphere/models/surface.dart';

@immutable
class SurfaceList extends StatelessWidget {
  const SurfaceList({super.key, required this.onSelect});

  final ValueChanged<Surface> onSelect;

  @override
  Widget build(BuildContext context) => ListView.builder(
    itemExtent: 210,
    itemCount: Surface.values.length - 1, // Excluding background
    scrollDirection: .horizontal,
    itemBuilder: (context, index) => InkWell(
      onTap: () => onSelect(.values[index]),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: .circular(4),
            child: Image.asset(Surface.values[index].thumbPath),
          ),
          Card(
            child: Padding(
              padding: const .all(4),
              child: Text(
                Surface.values[index].name,
                style: const TextStyle(fontWeight: .bold),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
