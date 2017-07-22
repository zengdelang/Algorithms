public class BresenhamCircle
{
    /*
          Bresenham八分画圆算法
     */
    public void drawCircle(int cx, int cy, int r)
    {
        int d = 1 - r; //中点判别式
        int x = 0;
        int y = r;
        circlePlotPoints(cx, cy, x ,y);
        while(x < y)
        {
            ++x;
            if(d < 0)
            {
                d += (x << 1) + 1;      //d += 2*x + 1
            }
            else
            {
                --y;
                d += ((x - y) << 1)+ 1; //d += 2*(x-y) + 1
            }
            circlePlotPoints(cx, cy, x ,y);
        }
    }
    
    private void circlePlotPoints(int cx, int cy, int x, int y)
    {
        point(cx + x, cy + y);
        point(cx - x, cy + y);
        point(cx + x, cy - y);
        point(cx - x, cy - y);
        point(cx + y, cy + x);
        point(cx - y, cy + x);
        point(cx + y, cy - x);
        point(cx - y, cy - x);
    }
}