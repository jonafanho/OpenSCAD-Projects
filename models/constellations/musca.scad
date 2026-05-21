include <constellations.scad>

points = [
  [3557, 0, 291],
  [1820, 436, 256],
  [878, 932, 387],
  [1154, 2439, 273],
  [0, 2228, 293],
  [474, 475, 343],
];
connections = [
  [0, 1, 2, 3, 4, 5, 2],
];
scale = [4855, 480];

constellation(points, connections, scale);
