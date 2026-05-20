include <constellations.scad>

points = [
  [0, 840, 197],
  [387, 2257, 250],
  [1278, 2653, 220],
  [1994, 2493, 275],
  [2774, 2162, 448],
  [3515, 1038, 288],
  [2931, 0, 249],
];
connections = [
  [0, 1, 2, 3, 4, 5, 6],
];
scale = [4855, 480];

constellation(points, connections, scale);
