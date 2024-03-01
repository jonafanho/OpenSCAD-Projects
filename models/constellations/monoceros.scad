include <constellations.scad>

points = [
    [ 357, 1015, 29 ],
    [ 0, 676, 26 ],
    [ 739, 541, 27 ],
    [ 1055, 390, 25 ],
    [ 1370, 277, 27 ],
    [ 1252, 134, 25 ],
    [ 1147, 0, 24 ],
    [ 1299, 883, 30 ],
    [ 1481, 845, 29 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 5, 6 ],
    [ 3, 5 ],
    [ 2, 7, 8 ],
];
scale = [ 523, 52 ];

constellation(points, connections, scale);