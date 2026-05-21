include <constellations.scad>

points = [
  [0, 2462, 151],
  [1667, 536, 152],
  [5903, 0, 227],
  [6912, 229, 168],
  [5611, 1111, 189],
  [3773, 2316, 154],
];
connections = [
  [0, 1, 2, 3, 4, 5, 0],
];
scale = [3641, 360];

constellation(points, connections, scale);
