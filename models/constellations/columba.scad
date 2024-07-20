include <constellations.scad>

points = [
    [ 730, 138, 39 ],
    [ 607, 26, 57 ],
    [ 446, 143, 50 ],
    [ 341, 638, 38 ],
    [ 0, 0, 40 ],
    [ 361, 117, 34 ],
];
connections = [
    [ 0, 1, 2, 3 ],
    [ 4, 5, 2 ],
];
scale = [ 694, 69 ];

constellation(points, connections, scale);