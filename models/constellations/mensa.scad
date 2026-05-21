include <constellations.scad>

points = [
  [0, 1713, 193],
  [1242, 2374, 187],
  [2409, 1783, 174],
  [2377, 0, 181],
];
connections = [
  [0, 1, 2, 3],
];
scale = [4856, 480];

constellation(points, connections, scale);
