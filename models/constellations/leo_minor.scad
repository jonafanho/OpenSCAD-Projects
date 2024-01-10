include <constellations.scad>

points = [
    [ 843, 0, 25 ],
    [ 496, 86, 25 ],
    [ 299, 165, 23 ],
    [ 0, 124, 30 ],
    [ 279, 10, 27 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 1 ],
];
scale = [ 523, 52 ];

constellation(points, connections, scale);