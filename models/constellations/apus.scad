include <constellations.scad>

points = [
  [2765, 882, 276],
  [336, 608, 271],
  [0, 0, 246],
  [647, 488, 245],
];
connections = [
  [0, 1, 2, 3],
];
scale = [4855, 480];

constellation(points, connections, scale);
