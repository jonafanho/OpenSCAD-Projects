include <constellations.scad>

points = [
  [77, 877, 140],
  [0, 109, 144],
  [2022, 0, 170],
  [3434, 2831, 144],
];
connections = [
  [0, 1, 2, 3, 0],
];
scale = [3641, 360];

constellation(points, connections, scale);
