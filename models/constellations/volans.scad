include <constellations.scad>

points = [
  [0, 383, 261],
  [1750, 0, 279],
  [4936, 113, 263],
  [4971, 2394, 295],
  [3552, 3181, 265],
  [2637, 1200, 237],
];
connections = [
  [0, 1, 2, 3, 4, 5, 1],
];
scale = [4854, 480];

constellation(points, connections, scale);
