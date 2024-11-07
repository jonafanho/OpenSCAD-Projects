include <constellations.scad>

points = [
    [ 0, 294, 36 ],
    [ 210, 187, 35 ],
    [ 360, 215, 38 ],
    [ 558, 245, 24 ],
    [ 896, 118, 37 ],
    [ 906, 310, 31 ],
    [ 636, 379, 31 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 5, 6, 3 ],
];
scale = [ 352, 35 ];

constellation(points, connections, scale);