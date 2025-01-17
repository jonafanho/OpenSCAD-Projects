include <../../libraries/std.scad>
include <constants.scad>
use <flags.scad>
use <front_sign.scad>
use <ground.scad>
use <panels.scad>
use <poles.scad>
use <roof.scad>

$fn = $preview ? 16 : 32;
$slop = 0.2;

module shelter()
{
    recolor("whitesmoke")
    {
        xflip_copy()
        {
            ground();
            back_poles();
            front_poles();
            top_poles_1();
            top_poles_2();
            back_panel(false);
            back_panel(true);
            side_panels();
            back_frames();
            side_frames();
            drain(false);
            drain(true);
            roof_cut(false);
            roof_cut(true);
            flag_poles();
            back_sign_panels();
            back_sign_support();
            handrail();
            front_sign(false);
            front_sign(true);
        }
        front_sign_text();
        flags();
        flag_logos();
    }
}

shelter();
// test_connectors(pole_size);