include <constellations.scad>

points = [
  [6283, 0, 242],
  [4713, 1497, 325],
  [2597, 2646, 213],
  [1026, 5148, 311],
  [710, 6831, 236],
  [0, 5671, 216],
];
connections = [
  [0, 1, 2, 3, 4, 5, 3, 1],
];
scale = [4855, 480];

constellation(points, connections, scale);
