include <constellations.scad>

points = [
  [0, 3640, 293],
  [1616, 733, 205],
  [4608, 0, 221],
  [6019, 1122, 337],
  [9372, 3216, 396],
  [6800, 5364, 367],
  [4856, 5267, 310],
  [3062, 5146, 224],
];
connections = [
  [0, 1, 2, 3, 4, 5, 6, 7, 0],
];
scale = [3640, 360];

constellation(points, connections, scale);
