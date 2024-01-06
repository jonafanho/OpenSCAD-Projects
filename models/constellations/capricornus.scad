include <constellations.scad>

points = [
    [ 1142, 0, 33 ],
    [ 1094, 113, 37 ],
    [ 768, 657, 27 ],
    [ 698, 742, 28 ],
    [ 518, 643, 25 ],
    [ 276, 510, 30 ],
    [ 253, 482, 25 ],
    [ 144, 364, 25 ],
    [ 0, 189, 40 ],
    [ 94, 215, 32 ],
    [ 322, 217, 26 ],
    [ 527, 233, 27 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 1 ],
];
scale = [ 526, 52 ];

constellation(points, connections, scale, false, false);