include <constellations.scad>

points = [
  [0, 0, 272],
  [6859, 3585, 214],
  [7682, 4171, 176],
  [7913, 5069, 181],
  [7505, 5984, 185],
  [5667, 8274, 190],
  [5727, 10391, 198],
];
connections = [
  [0, 1, 2, 3, 4, 5, 6],
];
scale = [4855, 480];

constellation(points, connections, scale);
