include <constellations.scad>

points = [
  [0, 0, 230],
  [960, 847, 199],
  [1098, 991, 222],
  [972, 1358, 225],
  [1819, 2644, 273],
  [168, 1487, 317],
];
connections = [
  [0, 1, 2, 3, 4, 5, 0],
];
scale = [4855, 480];

constellation(points, connections, scale);
