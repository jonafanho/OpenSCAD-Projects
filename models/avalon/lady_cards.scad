include <avalon.scad>

layer = 0;
good = true;

module lady_card()
{
    module card_base()
    {
        linear_extrude(1) regular_ngon(3, ir = 15, rounding = 1);
    }

    module card()
    {
        card_base();
        up(2) difference()
        {
            card_base();
            linear_extrude(2) if (good)
            {
                blue_shape();
            }
            else
            {
                red_shape();
            }
        }
    }

    module card_middle()
    {
        up(1) card_base();
    }

    module color_layer(height)
    {
        up(2.6) linear_extrude(height) regular_ngon(3, ir = 12, rounding = 1);
    }

    if (layer == 0)
    {
        difference()
        {
            card();
            color_layer(1);
        }
    }
    else if (layer == 1)
    {
        card_middle();
    }
    else if (layer == 2)
    {
        intersection()
        {
            card();
            color_layer(0.2);
        }
    }
}

lady_card();