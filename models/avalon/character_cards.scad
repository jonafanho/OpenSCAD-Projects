include <avalon.scad>

layer = 0;
character = 2;

characters = [
    [ "", true ],
    [ "Merlin", true ],
    [ "Percival", true ],
    [ "", false ],
    [ "Morgana", false ],
    [ "Oberon", false ],
    [ "Mordred", false ],
];

module character_card()
{
    module card_base()
    {
        linear_extrude(1) hexagon(ir = 25, rounding = 1);
    }

    module card()
    {
        role = characters[character][0];
        has_role = role != "";

        up(2)
        {
            difference()
            {
                card_base();
                down(0.5) linear_extrude(2)
                {
                    if (has_role)
                    {
                        rect([ 40, 12 ], rounding = 6);
                    }
                    back(has_role ? 14.5 : 0) scale(has_role ? 0.6 : 2) zrot(90)
                    {
                        if (characters[character][1])
                        {
                            blue_shape();
                        }
                        else
                        {
                            red_shape();
                        }
                    }
                }
            }

            linear_extrude(1) draw_text(role, 0, 3, 6);
        }
    }

    module card_middle()
    {
        up(1) card_base();
    }

    module color_layer(height)
    {
        up(2.6) linear_extrude(height) hexagon(ir = 22, rounding = 1);
    }

    if (layer == 0)
    {
        card_base();
    }
    else if (layer == 1)
    {
        card_middle();
    }
    else if (layer == 2)
    {
        difference()
        {
            card();
            color_layer(1);
        }
    }
    else if (layer == 3)
    {
        intersection()
        {
            card();
            color_layer(0.2);
        }
    }
}

character_card();