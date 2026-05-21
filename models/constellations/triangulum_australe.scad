include <constellations.scad>

points = [
  [0, 2856, 494],
  [2433, 0, 369],
  [3361, 1510, 253],
  [3981, 2696, 365],
];
connections = [
  [0, 1, 2, 3, 0],
];
scale = [4855, 480];

constellation(points, connections, scale);
