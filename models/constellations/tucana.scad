include <constellations.scad>

points = [
  [0, 2417, 287],
  [4334, 0, 261],
  [7633, 1710, 367],
  [6513, 3792, 226],
  [1837, 3508, 226],
  [776, 3261, 244],
];
connections = [
  [0, 1, 2, 3, 4, 5, 0],
];
scale = [4855, 480];

constellation(points, connections, scale);
