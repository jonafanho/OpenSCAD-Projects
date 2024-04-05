include <constellations.scad>

points = [
    [ 0, 0, 24 ],
    [ 170, 0, 23 ],
    [ 268, 188, 24 ],
    [ 560, 136, 25 ],
    [ 729, 291, 24 ],
];
connections = [
    [ 0, 1, 2, 3, 4 ],
];
scale = [ 524, 52 ];

constellation(points, connections, scale);