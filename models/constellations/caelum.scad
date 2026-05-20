include <constellations.scad>

points = [
  [0, 0, 23],
  [224, 77, 20],
  [233, 305, 24],
  [318, 460, 20],
];
connections = [
  [0, 1, 2, 3],
];
scale = [487, 49];

constellation(points, connections, scale);
