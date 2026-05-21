include <constellations.scad>

points = [
  [0, 0, 259],
  [670, 2656, 287],
  [1006, 3708, 263],
];
connections = [
  [0, 1, 2],
];
scale = [4855, 480];

constellation(points, connections, scale);
