include <constellations.scad>

points = [
  [0, 283, 203],
  [3075, 0, 152],
  [5383, 530, 160],
  [1846, 1491, 173],
];
connections = [
  [0, 1, 2, 3, 0],
];
scale = [3639, 360];

constellation(points, connections, scale);
