include <constellations.scad>

points = [
    [0, 182, 36],
    [91, 46, 35],
    [260, 85, 38],
    [389, 25, 24],
    [610, 0, 37],
    [591, 109, 31],
    [441, 125, 31],
];
connections = [
    [0, 1, 2, 3, 4, 5, 6, 3],
];
scale = [500, 50];

constellation(points, connections, scale);
