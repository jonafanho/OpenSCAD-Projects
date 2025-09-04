include <constellations.scad>

points = [
    [ 279, 386, 23 ],
    [ 259, 284, 32 ],
    [ 202, 47, 36 ],
    [ 50, 0, 32 ],
    [ 0, 315, 35 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 1 ],
];
scale = [ 460, 44 ];

constellation(points, connections, scale);
