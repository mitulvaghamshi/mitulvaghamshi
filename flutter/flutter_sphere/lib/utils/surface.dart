enum const Surface(final String name) {
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
}

extension Utils on Surface {
  String get path => 'assets/${name.toLowerCase()}.webp';
  String get thumbPath => 'assets/thumb/${name.toLowerCase()}.webp';
}
