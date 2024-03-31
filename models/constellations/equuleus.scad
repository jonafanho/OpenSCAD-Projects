include <constellations.scad>

points = [
    [ 97, 0, 31 ],
    [ 26, 8, 33 ],
    [ 0, 334, 38 ],
];
connections = [
    [ 0, 1, 2 ],
];
scale = [ 691, 69 ];

constellation(points, connections, scale);