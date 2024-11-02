include <constellations.scad>

points = [
    [ 0, 49, 23 ],
    [ 38, 73, 22 ],
    [ 206, 161, 41 ],
    [ 430, 0, 27 ],
];
connections = [
    [ 0, 1, 2, 3 ],
];
scale = [ 523, 52 ];

constellation(points, connections, scale);