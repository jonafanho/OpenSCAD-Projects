include <constellations.scad>

points = [
    [ 484, 0, 40 ],
    [ 471, 358, 33 ],
    [ 0, 817, 47 ],
    // [ 889, 467, 32 ],
];
connections = [
    [ 0, 1, 2 ],
];
scale = [ 694, 69 ];

constellation(points, connections, scale);