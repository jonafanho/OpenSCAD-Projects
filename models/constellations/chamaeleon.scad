include <constellations.scad>

points = [
  [5802, 194, 256],
  [5616, 404, 236],
  [2225, 0, 253],
  [198, 263, 213],
  [0, 915, 242],
  [2053, 960, 229],
];
connections = [
  [0, 1, 2, 3, 4, 5, 2],
];
scale = [4855, 480];

constellation(points, connections, scale);
