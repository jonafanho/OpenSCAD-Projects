include <avalon.scad>

layer = 0;

module quest_token_base(padding)
{
    pentagon(ir = 12 + padding, rounding = 1 + padding);
}

module quest_token()
{
    module token_blue()
    {
        difference()
        {
            up(2) linear_extrude(1) quest_token_base(0);
            up(1.5) linear_extrude(2) blue_shape();
        }
    }

    module token_middle(add_padding)
    {
        up(1) linear_extrude(1) quest_token_base(0);
    }

    module token_red()
    {
        difference()
        {
            linear_extrude(1) quest_token_base(0);
            down(0.5) linear_extrude(2) red_shape();
        }
    }

    if (layer == 10)
    {
        token_red();
    }
    else if (layer == 11)
    {
        token_middle(false);
    }
    else if (layer == 12)
    {
        token_blue();
    }
}

quest_token();