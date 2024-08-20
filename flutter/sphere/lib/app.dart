import 'package:flutter/material.dart';
import 'package:sphere/models/surface.dart';
import 'package:sphere/widgets/sphere_widget.dart';
import 'package:sphere/widgets/surface_list.dart';

@immutable
class SphereApp extends StatefulWidget {
  const SphereApp({super.key});

  @override
  SphereAppState createState() => SphereAppState();
}

class SphereAppState extends State<SphereApp> {
  Surface surface = Surface.values.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Surface.stars.path),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(children: [
          Expanded(
            child: SphereWidget(
              latitude: 15,
              longitude: 0,
              surface: surface,
              key: ValueKey(surface),
              alignment: Alignment.center,
              radius: View.of(context).physicalSize.width / 2.0 - 10.0,
            ),
          ),
          SizedBox(
            height: 100,
            child: SurfaceList(onSelect: (value) {
              setState(() => surface = value);
            }),
          )
        ]),
      ),
    );
  }
}
