include <constellations.scad>

points = [
  [245, 0, 274],
  [0, 444, 253],
  [16, 1144, 253],
  [241, 1704, 221],
  [788, 2440, 211],
  [3450, 2443, 218],
];
connections = [
  [0, 1, 2, 3, 4, 5],
];
scale = [4855, 480];

constellation(points, connections, scale);
