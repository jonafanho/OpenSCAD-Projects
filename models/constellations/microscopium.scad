include <constellations.scad>

points = [
  [70, 1, 212],
  [1780, 0, 215],
  [2932, 758, 203],
  [2942, 5721, 196],
  [0, 4206, 207],
];
connections = [
  [0, 1, 2, 3, 4, 0],
];
scale = [4856, 480];

constellation(points, connections, scale);
