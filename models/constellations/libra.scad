include <constellations.scad>

points = [
    [ 0, 1077, 32 ],
    [ 17, 990, 32 ],
    [ 24, 292, 30 ],
    [ 253, 0, 44 ],
    [ 581, 356, 41 ],
    [ 410, 839, 35 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 5 ],
    [ 2, 4 ],
];
scale = [ 524, 52 ];

constellation(points, connections, scale, false, false);