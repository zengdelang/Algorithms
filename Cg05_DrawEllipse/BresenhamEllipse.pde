public class BresenhamEllipse
{
    /*
          Bresenham四分画椭圆算法
     */
    public void drawEllipse(int cx, int cy, int a, int b)
    {
        int A2 = a * a;
        int B2 = b * b;
        int twoA2 = A2 + A2;   //2*A2;
        int twoB2 = B2 + B2;   //2*B2;
        
        int x = 0;
        int y = b;
        int px = 0;
        int py = twoA2 * y;
        
        ellipsePlotPoints(cx, cy, x, y);
        
        //区域1
        int d = round(B2 - A2 * (0.25 + b));  //中点判别式
        while(px < py)
        {
            ++x;
            px += twoB2;
            if(d < 0)
                d += B2 + px;
            else
            {
                --y;
                py -= twoA2;
                d += B2 + px - py;
            }
            ellipsePlotPoints(cx, cy, x, y);
        }
         
        //区域2
        d = round(B2 * (x + 0.5) * (x + 0.5) + A2 * ((y - 1) * (y - 1) - B2));
        while(y > 0)
        {
            --y;
            py -= twoA2;
            if(d > 0)
                d += A2 - py;
            else
            {
                ++x;
                px += twoB2;
                d += A2 - py + px;
            }
            ellipsePlotPoints(cx, cy, x, y);
        }
    }
    
    private void ellipsePlotPoints(int cx, int cy, int x, int y)
    {
        point(cx + x, cy + y);
        point(cx - x, cy + y);
        point(cx + x, cy - y);
        point(cx - x, cy - y);
    }
}