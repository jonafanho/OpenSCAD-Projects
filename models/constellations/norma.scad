include <constellations.scad>

points = [
  [1680, 0, 212],
  [1981, 1962, 217],
  [920, 2416, 198],
  [672, 2441, 260],
  [0, 1246, 230],
];
connections = [
  [0, 1, 2, 3, 4, 0],
];
scale = [4855, 480];

constellation(points, connections, scale);
