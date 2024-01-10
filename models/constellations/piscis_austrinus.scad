include <constellations.scad>

points = [
    [ 1078, 272, 28 ],
    [ 1107, 419, 34 ],
    [ 767, 404, 33 ],
    [ 427, 361, 35 ],
    [ 121, 415, 38 ],
    [ 70, 397, 36 ],
    [ 0, 171, 88 ],
    [ 272, 0, 36 ],
    [ 743, 375, 29 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 2, 0 ],
];
scale = [ 694, 69 ];

constellation(points, connections, scale);