include <constellations.scad>

points = [
    [ 0, 0, 32 ],
    [ 514, 191, 53 ],
    [ 674, 320, 43 ],
    [ 693, 399, 34 ],
];
connections = [
    [ 0, 1, 2, 3 ],
];
scale = [ 525, 52 ];

constellation(points, connections, scale);