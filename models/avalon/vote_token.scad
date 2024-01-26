include <avalon.scad>

layer = 0;

module vote_token_base(padding)
{
    circle(r = 8 + padding);
}

module vote_token()
{
    module token()
    {
        tube(or = 8, ir = 4, h = 1, anchor = BOTTOM);
    }

    module token_middle()
    {
        up(1) linear_extrude(1) vote_token_base(0);
    }

    if (layer == 10)
    {
        token();
        up(2) token();
    }
    else if (layer == 11)
    {
        token_middle();
    }
}

vote_token();