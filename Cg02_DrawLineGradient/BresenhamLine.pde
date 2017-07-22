public class BresenhamLine
{
    /*
          使用直线中点Bresenham算法来画线
     */
    public void drawLine(int x1, int y1, int x2, int y2, float r1, float g1, float b1, float r2, float g2, float b2)
    {
        //如果斜率的绝对值大于1，求直线函数的反函数的直线
        int steep = (abs(y2 - y1) > abs(x2 - x1)) ? 1 : 0;
        if (steep == 1)
        {
            //交换x1，y1坐标，得到反函数的起点坐标
            x1 ^= y1;
            y1 ^= x1;
            x1 ^= y1;
            
            //交换x2, y2坐标，得到反函数的终点坐标
            x2 ^= y2;
            y2 ^= x2;
            x2 ^= y2;
        }
        
        //如果起点坐标的x坐标在终点坐标的右边，则交换起点和终点坐标
        if (x1 > x2)
        {
            x1 ^= x2;
            x2 ^= x1;
            x1 ^= x2;
            
            y1 ^= y2;
            y2 ^= y1;
            y1 ^= y2;
            
            //交换颜色
            float c = r1;
            r1 = r2;
            r2 = c;
            
            c = g1;
            g1 = g2;
            g2 = c;
            
            c = b1;
            b1 = b2;
            b2 = c;
        }
        
        int dx = abs(x2 - x1);        //x的微分
        int dy = abs(y2 - y1);        //y的微分
        
        int p = (dy << 1) - dx;       //中点判别式 p = 2 * dy - dx  
        
        int delta1 = dy << 1;         //p<0时的判别式的递推增量   delta1 = 2 * dy
        int delta2 = (dy - dx) << 1;  //p>=0时的判别式的递推增量  delta2 = 2 * (dy - dx)
  
        int inc = (y1 < y2) ? 1 : -1; //y坐标的每一次增长分量
        
        float rDelta = (r2 - r1) / dx;
        float gDelta = (g2 - g1) / dx;
        float bDelta = (b2 - b1) / dx;
        while (x1 <= x2)
        {  
            stroke(r1, g1, b1);
            if (steep == 1)
            {
                point(y1,x1);  //绘制像素
            }
            else
            {
                point(x1,y1);  
            }
            
            ++x1;  
          
            if (p<0)  
            {
                p += delta1;  
            }
            else
            {  
                p += delta2;  
                y1 += inc;
            }
            
            r1 += rDelta;
            g1 += gDelta;
            b1 += bDelta;
        }
    }
}
