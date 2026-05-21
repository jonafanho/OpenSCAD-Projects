include <constellations.scad>

points = [
  [0, 0, 259],
  [4291, 3347, 326],
  [9105, 8252, 243],
  [9511, 9456, 299],
  [11556, 8292, 236],
];
connections = [
  [0, 1, 2, 3, 4],
];
scale = [4853, 480];

constellation(points, connections, scale);
