include <constellations.scad>

points = [
    [539, 45, 40],
    [319, 0, 10],
    [249, 106, 17],
    [131, 116, 16],
    [25, 194, 11],
    [0, 213, 11],
    [5, 263, 13],
    [94, 326, 11],
    [175, 289, 18],
    [102, 230, 13],
    [92, 188, 11],
];
connections = [
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
];
scale = [172, 16];

constellation(points, connections, scale);