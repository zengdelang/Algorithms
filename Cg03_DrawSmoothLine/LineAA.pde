public class LineAA
{
    /*
          使用直线加权距离反走样算法绘制直线
          缺点：不同斜率的直线颜色在视觉上会有一些偏差，原因是该反走样算法，填充像素点集的颜色是根据像素点距理想直线的多少，填充百分多少灰度
          以黑色为例，水平直线无须反走样是纯黑色
          如果是以下像素点阵,假设理想直线通过m1,m2的中点，则m1和m2都填充50%的灰度，即255的百分50，m1,m2都是灰色，如果这样一条斜线多这样的像素分布，则整体颜色会偏灰，而不太接近纯黑色
          o o o(m1)
          o o o(m2)
          o o o
          因此，直线加权距离反走样算法的总体颜色会根据不同的斜率表现而有所偏差(跟理想颜色相比)
     */
    public void drawSmoothLine(int x1, int y1, int x2, int y2, float r1, float g1, float b1)
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
        }
        
        float d = 0;
        int inc = (y1 < y2) ? 1 : -1;        //y坐标的每一次增长分量
        float k = (x2 - x1) == 0 ? 0 : abs(y2 - y1) / (float)(x2 - x1);  //斜率的绝对值
        
        float rDelta = 255 - r1;
        float gDelta = 255 - g1;
        float bDelta = 255 - b1;
        while (x1 <= x2)
        {  
            if (steep == 1)
            {
                stroke(r1 + rDelta * d, g1 + gDelta * d, b1 + bDelta * d);
                point(y1,x1);       //绘制像素
                
                stroke(r1 + rDelta * (1 - d), g1 + gDelta * (1 - d), b1 + bDelta * (1 - d));
                point(y1+inc,x1); 
            }
            else
            {
                stroke(r1 + rDelta * d, g1 + gDelta * d, b1 + bDelta * d);
                point(x1,y1);
                
                stroke(r1 + rDelta * (1 - d), g1 + gDelta * (1 - d), b1 + bDelta * (1 - d));
                point(x1,y1+inc);  
            }
            
            ++x1;
            
            d += k;
            if (d > 1)
            {
                --d;
                y1 += inc;
            }
        }
    }
}