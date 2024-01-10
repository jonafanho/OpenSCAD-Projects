include <constellations.scad>

points = [
    [ 0, 1281, 37 ],
    [ 57, 1168, 30 ],
    [ 205, 1115, 25 ],
    [ 294, 953, 29 ],
    [ 667, 929, 26 ],
    [ 1172, 607, 24 ],
    [ 1328, 96, 25 ],
    [ 1577, 0, 25 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 5, 6, 7 ],
];
scale = [ 524, 52 ];

constellation(points, connections, scale);