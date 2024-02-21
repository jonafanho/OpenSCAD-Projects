include <../constellations.scad>

layer = 0;

points1 = [
    [ 672, 1680, 35 ],
    [ 1177, 1765, 31 ],
    [ 1148, 2221, 28 ],
    [ 567, 2166, 26 ],
];
points2 = [
    points1[0],
    [ 875, 626, 33 ],
    [ 707, 674, 33 ],
    [ 692, 509, 31 ],
    [ 571, 469, 29 ],
    [ 540, 304, 24 ],
];
points3 = [
    points1[1],
    [ 1423, 661, 24 ],
    [ 1585, 436, 31 ],
    [ 1441, 194, 25 ],
    [ 1084, 0, 25 ],
    [ 1220, 407, 23 ],
];
points4 = [
    points1[2],
    [ 1017, 3653, 44 ],
];
points5 = [
    points4[1],
    [ 944, 4247, 33 ],
    [ 1125, 4321, 37 ],
];
points6 = [
    points1[3],
    [ 254, 3215, 32 ],
];
points7 = [
    [ 355, 3992, 30 ],
    points6[1],
    [ 0, 4517, 55 ],
];
connections1 = [
    [ 0, 1, 2, 3, 0 ],
];
connections2 = [
    [ 0, 1, 2, 3, 4, 5 ],
];
connections3 = [
    [ 0, 1, 2, 3, 4, 5, 1 ],
];
connections4 = [
    [ 0, 1 ],
];
connections5 = [
    [ 0, 1, 2 ],
];
connections6 = [
    [ 0, 1 ],
];
connections7 = [
    [ 0, 1, 2 ],
];
scale = [ 354, 35 ];

if (layer == 0)
{
    female_joint = [[points2 [1], points2 [0]], [points3 [1], points3 [0]], [points4 [1], points4 [0]],
                    [points6 [1], points6 [0]]];
    constellation(points1, connections1, scale, female_joint, []);
}
else if (layer == 1)
{
    constellation(points2, connections2, scale, [], [[points2 [1], points2 [0]]]);
}
else if (layer == 2)
{
    constellation(points3, connections3, scale, [], [[points3 [1], points3 [0]]]);
}
else if (layer == 3)
{
    constellation(points4, connections4, scale, [], [[points4 [1], points4 [0]], [points4 [0], points4 [1]]]);
}
else if (layer == 4)
{
    constellation(points5, connections5, scale, [[points4 [0], points4 [1]]], []);
}
else if (layer == 5)
{
    constellation(points6, connections6, scale, [], [[points6 [1], points6 [0]], [points6 [0], points6 [1]]]);
}
else if (layer == 6)
{
    constellation(points7, connections7, scale, [[points6 [0], points6 [1]]], []);
}