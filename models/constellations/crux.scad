include <constellations.scad>

points = [
    [ 0, 179, 86 ],
    [ 304, 129, 54 ],
    [ 148, 0, 77 ],
    [ 171, 401, 106 ],
];
connections = [
    [ 0, 1 ],
    [ 2, 3 ],
];
scale = [ 694, 69 ];

constellation(points, connections, scale);