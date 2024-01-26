include <avalon.scad>

layer = 0;
success = true;

module success_fail_card()
{
    module card_base()
    {
        linear_extrude(1) rect(size = 40, rounding = 1);
    }

    module card_success()
    {
        card_base();
        up(2)
        {
            difference()
            {
                card_base();
                back(5) cyl(r = 10, h = 3);
                linear_extrude(2) draw_text("Success", 0, 15, 6, FWD);
            }

            linear_extrude(1) draw_text("\u2714", 0, 0, 10, BOTTOM, font = "Segoe UI Symbol");
        }
    }

    module card_fail()
    {
        card_base();

        up(2)
        {
            difference()
            {
                card_base();
                back(2) down(1) zrot(90) linear_extrude(3) regular_ngon(3, ir = 7, rounding = 1);
                linear_extrude(2) draw_text("Fail", 0, 15, 6, FWD);
            }

            linear_extrude(1) draw_text("!", 0, 1, 10, BOTTOM);
        }
    }

    module card_middle_success()
    {
        up(1) card_base();
    }

    module card_middle_fail_inner()
    {
        up(2) cube([ 32, 32, 0.2 ], anchor = TOP);
    }

    module card_middle_fail_outer()
    {
        difference()
        {
            card_middle_success();
            card_middle_fail_inner();
        }
    }

    if (layer == 0)
    {
        if (success)
        {
            card_success();
        }
        else
        {
            card_fail();
        }
    }
    else if (layer == 1)
    {
        if (success)
        {
            card_middle_success();
        }
        else
        {
            card_middle_fail_outer();
        }
    }
    else if (layer == 2)
    {
        if (!success)
        {
            card_middle_fail_inner();
        }
    }
}

success_fail_card();