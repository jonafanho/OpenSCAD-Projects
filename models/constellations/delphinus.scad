include <constellations.scad>

points = [
    [ 227, 335, 37 ],
    [ 151, 105, 42 ],
    [ 56, 76, 33 ],
    [ 0, 0, 39 ],
    [ 117, 15, 40 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 1 ],
];
scale = [ 693, 69 ];

constellation(points, connections, scale);