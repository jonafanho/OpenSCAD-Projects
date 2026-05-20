include <constellations.scad>

points = [
  [0, 2946, 174],
  [1959, 2167, 175],
  [4495, 0, 255],
  [3968, 1676, 168],
  [3199, 3979, 217],
];
connections = [
  [0, 1, 2, 3, 4, 0],
];
scale = [3641, 360];

constellation(points, connections, scale);
