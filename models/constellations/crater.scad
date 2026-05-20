include <constellations.scad>

points = [
  [2203, 0, 214],
  [3653, 516, 207],
  [4215, 2380, 296],
  [6473, 4161, 255],
  [5070, 6334, 228],
  [3578, 3805, 255],
  [1303, 4162, 213],
  [0, 3622, 188],
];
connections = [
  [0, 1, 2, 3, 4, 5, 6, 7],
  [2, 5],
];
scale = [4855, 480];

constellation(points, connections, scale);
