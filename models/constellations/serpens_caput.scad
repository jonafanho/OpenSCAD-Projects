include <constellations.scad>

points = [
  [730, 10449, 298],
  [617, 6617, 284],
  [1360, 5620, 394],
  [2552, 3680, 280],
  [1199, 1305, 288],
  [0, 1186, 272],
  [924, 0, 254],
];
connections = [
  [0, 1, 2, 3, 4, 5, 6, 4],
];
scale = [4855, 480];

constellation(points, connections, scale);
