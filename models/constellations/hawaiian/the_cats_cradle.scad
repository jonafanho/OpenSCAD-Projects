include <../constellations.scad>

points = [
    [ 141, 501, 65 ],
    [ 296, 893, 44 ],
    [ 224, 1209, 40 ],
    [ 553, 1134, 70 ],
    [ 389, 829, 38 ],
    [ 342, 863, 44 ],
    [ 455, 555, 45 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 5, 1 ],
    [ 4, 6, 0 ],
];
scale = [ 407, 40 ];

constellation(points, connections, scale);