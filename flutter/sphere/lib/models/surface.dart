enum Surface {
  sun('Sun'),
  mercury('Mercury'),
  venus('Venus'),
  earth('Earth'),
  moon('Moon'),
  mars('Mars'),
  jupiter('Jupiter'),
  saturn('Saturn'),
  uranus('Uranus'),
  neptune('Neptune'),
  custom('Custom'),
  stars('Stars');

  const Surface(this.name);

  final String name;
}

extension Utils on Surface {
  String get path => 'assets/${name.toLowerCase()}.webp';
  String get thumbPath => 'assets/thumb/${name.toLowerCase()}.webp';
}
