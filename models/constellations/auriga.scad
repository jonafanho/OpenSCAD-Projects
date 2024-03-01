include <constellations.scad>

points = [
    [ 403, 466, 19 ],
    [ 392, 364, 24 ],
    [ 269, 274, 65 ],
    [ 9, 332, 35 ],
    [ 0, 617, 28 ],
    [ 253, 924, 38 ],
    [ 473, 743, 27 ],
    [ 30, 0, 19 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 5, 6, 2, 7, 3 ],
];
scale = [ 365, 34 ];

constellation(points, connections, scale);