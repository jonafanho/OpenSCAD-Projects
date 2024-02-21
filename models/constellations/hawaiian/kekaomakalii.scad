include <../constellations.scad>

points1 = [
    [ 1002, 95, 41 ],
    [ 1022, 419, 32 ],
    [ 1341, 738, 44 ],
    [ 1570, 511, 31 ],
    [ 1291, 0, 74 ],
    [ 195, 570, 46 ],
    [ 75, 711, 52 ],
];
points2 = [
    points1[6],
    [ 0, 1632, 69 ],
];
points3 = [
    points2[1],
    [ 518, 2548, 125 ],
];
points4 = [
    points3[1],
    [ 794, 2646, 42 ],
    [ 695, 4076, 99 ],
];
connections1 = [
    [ 0, 1, 2, 3, 4, 0, 5, 6 ],
];
connections2 = [
    [ 0, 1 ],
];
connections3 = [
    [ 0, 1 ],
];
connections4 = [
    [ 0, 1, 2 ],
];
scale = [ 407, 40 ];

constellation(points1, connections1, scale, [], [[points1 [5], points1 [6]]]);
constellation(points2, connections2, scale, [[points1 [5], points2 [0]]], [[points2 [0], points2 [1]]]);
constellation(points3, connections3, scale, [[points2 [0], points3 [0]]], [[points3 [0], points3 [1]]]);
constellation(points4, connections4, scale, [[points3 [0], points4 [0]]], []);