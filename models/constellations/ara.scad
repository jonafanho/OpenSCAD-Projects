include <constellations.scad>

points = [
  [0, 332, 287],
  [2669, 0, 368],
  [5079, 1770, 257],
  [4954, 3101, 340],
  [5367, 4674, 280],
  [2785, 5284, 293],
  [3148, 3183, 319],
  [3135, 2745, 372],
];
connections = [
  [0, 1, 2, 3, 4, 5, 6, 7, 1],
];
scale = [4855, 480];

constellation(points, connections, scale);
