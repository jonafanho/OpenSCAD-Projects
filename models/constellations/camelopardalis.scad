include <constellations.scad>

points = [
    [ 0, 13, 17 ],
    [ 131, 274, 16 ],
    [ 438, 267, 17 ],
    [ 487, 0, 16 ],
    [ 641, 136, 18 ],
    [ 847, 197, 18 ],
    [ 509, 466, 19 ],
    [ 656, 657, 17 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 5 ],
    [ 2, 6, 7 ],
];
scale = [ 355, 36 ];

constellation(points, connections, scale);