include <constellations.scad>

points = [
    [ 259, 0, 59 ],
    [ 154, 218, 30 ],
    [ 67, 482, 30 ],
    [ 140, 771, 30 ],
    [ 303, 986, 58 ],
    [ 174, 1128, 43 ],
    [ 0, 860, 25 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 5, 6, 3 ],
];
scale = [ 595, 59 ];

constellation(points, connections, scale, false, false);