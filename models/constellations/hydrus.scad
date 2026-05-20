include <constellations.scad>

points = [
  [4387, 0, 367],
  [4242, 3027, 214],
  [2939, 3378, 255],
  [2126, 3191, 253],
  [5704, 8377, 372],
  [0, 6477, 325],
];
connections = [
  [0, 1, 2, 3, 4, 5],
];
scale = [4857, 480];

constellation(points, connections, scale);
