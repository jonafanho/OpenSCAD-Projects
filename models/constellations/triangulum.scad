include <constellations.scad>

points = [
    [ 9, 59, 29 ],
    [ 0, 82, 37 ],
    [ 107, 0, 50 ],
    [ 350, 378, 44 ],
];
connections = [
    [ 0, 1, 2, 3, 1 ],
];
scale = [ 693, 69 ];

constellation(points, connections, scale);