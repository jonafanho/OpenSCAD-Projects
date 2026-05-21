include <constellations.scad>

points = [
  [0, 537, 278],
  [906, 0, 185],
  [1552, 659, 239],
  [2452, 1354, 207],
  [4069, 5067, 289],
  [6683, 7507, 250],
  [5603, 10099, 269],
  [3206, 7335, 244],
  [745, 6179, 336],
];
connections = [
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 4],
];
scale = [3641, 360];

constellation(points, connections, scale);
