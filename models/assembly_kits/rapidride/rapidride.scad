include <../../libraries/std.scad>
include <constants.scad>
use <flags.scad>
use <front_sign.scad>
use <ground.scad>
use <panels.scad>
use <poles.scad>
use <roof.scad>

module shelter()
{
    recolor("whitesmoke")
    {
        xflip_copy()
        {
            ground();
            back_poles();
            front_poles();
            top_poles();
            back_panel();
            side_panels();
            back_frames();
            side_frames();
            drain();
            roof_1();
            roof_2();
            flag_poles();
            back_sign_panels();
            back_sign_support();
            handrail();
            front_sign_top();
        }
        front_sign_main();
        flags();
        flag_logos();
    }
}

shelter();