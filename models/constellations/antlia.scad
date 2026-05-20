include <constellations.scad>

points = [
  [0, 2388, 165],
  [2037, 0, 181],
  [6381, 1908, 170],
];
connections = [
  [0, 1, 2],
];
scale = [3641, 360];

constellation(points, connections, scale);
