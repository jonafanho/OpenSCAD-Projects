include <constellations.scad>

points = [
  [0, 0, 244],
  [1437, 1681, 272],
  [2159, 4784, 214],
  [617, 2102, 213],
  [472, 1731, 202],
];
connections = [
  [0, 1, 2, 3, 0],
];
scale = [4854, 480];

constellation(points, connections, scale);
