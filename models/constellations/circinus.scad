include <constellations.scad>

points = [
  [295, 0, 255],
  [1819, 1767, 192],
  [2587, 2700, 333],
  [0, 334, 224],
];
connections = [
  [0, 1, 2, 3],
];
scale = [4853, 480];

constellation(points, connections, scale);
