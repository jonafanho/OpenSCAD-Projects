include <constellations.scad>

points = [
    [ 0, 51, 27 ],
    [ 806, 0, 24 ],
    [ 1114, 273, 25 ],
    [ 923, 525, 26 ],
    [ 353, 234, 23 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 0 ],
];
scale = [ 526, 52 ];

constellation(points, connections, scale);