include <constellations.scad>

points = [
  [4867, 0, 208],
  [4180, 2582, 250],
  [6443, 3333, 282],
  [0, 7498, 238],
];
connections = [
  [0, 1, 2, 3, 1],
];
scale = [4855, 480];

constellation(points, connections, scale);
