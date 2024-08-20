enum Surface {
  sun(name: 'Sun'),
  mercury(name: 'Mercury'),
  venus(name: 'Venus'),
  earth(name: 'Earth'),
  moon(name: 'Moon'),
  mars(name: 'Mars'),
  jupiter(name: 'Jupiter'),
  saturn(name: 'Saturn'),
  uranus(name: 'Uranus'),
  neptune(name: 'Neptune'),
  custom(name: 'Custom'),
  stars(name: 'Stars'),
  ;

  const Surface({required this.name});

  final String name;

  String get path => 'assets/sphere/${name.toLowerCase()}.webp';
  String get thumbPath => 'assets/sphere/thumb/${name.toLowerCase()}.webp';
}
