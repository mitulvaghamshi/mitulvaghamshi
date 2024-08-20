import 'package:flutter/material.dart';
import 'package:flutter_sphere/utils/surface.dart';
import 'package:flutter_sphere/widgets/sphere_widget.dart';
import 'package:flutter_sphere/widgets/surface_list.dart';

@immutable
class SphereApp extends StatefulWidget {
  const SphereApp({super.key});

  @override
  State<SphereApp> createState() => _SphereAppState();
}

class _SphereAppState extends State<SphereApp> {
  Surface _surface = .values.first;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Surface.stars.path),
          fit: .cover,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: SphereWidget(
              key: ValueKey(_surface.name),
              surface: _surface,
              latitude: 15,
              radius: View.of(context).physicalSize.width / 2.0 - 10.0,
            ),
          ),
          SizedBox(
            height: 100,
            child: SurfaceList(
              onSelect: (value) => setState(() => _surface = value),
            ),
          ),
        ],
      ),
    ),
  );
}
