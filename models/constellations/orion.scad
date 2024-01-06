include <constellations.scad>

points = [
    [ 83, 5, 19 ],     [ 0, 245, 19 ],    [ 92, 431, 21 ],  [ 141, 501, 65 ], [ 296, 893, 44 ],
    [ 224, 1209, 40 ], [ 553, 1134, 70 ], [ 471, 919, 29 ], [ 389, 829, 38 ], [ 342, 863, 44 ],
    [ 455, 555, 45 ],  [ 363, 418, 27 ],  [ 754, 273, 22 ], [ 815, 461, 20 ], [ 820, 535, 29 ],
    [ 809, 593, 24 ],  [ 780, 722, 24 ],  [ 739, 754, 20 ], [ 178, 0, 19 ],   [ 43, 222, 20 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 4 ],
    [ 18, 19, 2 ],
    [ 8, 10, 11, 3 ],
    [ 10, 14 ],
    [ 12, 13, 14, 15, 16, 17 ],
];
scale = [ 407, 40 ];

constellation(points, connections, scale, false, false);