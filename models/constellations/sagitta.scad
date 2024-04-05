include <constellations.scad>

points = [
    [ 0, 0, 43 ],
    [ 185, 74, 40 ],
    [ 307, 116, 33 ],
    [ 291, 152, 34 ],
];
connections = [
    [ 0, 1, 2 ],
    [ 1, 3 ],
];
scale = [ 691, 69 ];

constellation(points, connections, scale);