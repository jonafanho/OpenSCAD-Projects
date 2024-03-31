include <constellations.scad>

points = [
    [ 150, 0, 25 ],
    [ 84, 100, 30 ],
    [ 145, 145, 24 ],
    [ 102, 237, 26 ],
    [ 179, 298, 24 ],
    [ 0, 415, 25 ],
    [ 94, 478, 24 ],
    [ 261, 652, 25 ],
    [ 243, 754, 28 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 5, 6, 7, 8 ],
];
scale = [ 524, 53 ];

constellation(points, connections, scale);