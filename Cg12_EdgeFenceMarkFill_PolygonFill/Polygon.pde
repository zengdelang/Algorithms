public class Point
{
    public int x;
    public int y;
    
    public Point(int _x, int _y)
    {
        x = _x;
        y = _y;
    }
}

public class Polygon
{
    private Point[] points;
    
    public Polygon(Point[] _points)
    {
        points = _points;
    }
    
    public void Render()
    {
        int lastPoint = points.length -1;
        stroke(255,0,0);
        for(int i = 0; i < points.length; ++i)
        {
            line(points[lastPoint].x, points[lastPoint].y ,points[i].x, points[i].y);
            lastPoint = i;
        }
    }
    
    //栅栏填充算法(边缘填充算法的改进)填充多边形，以第一个点的x坐标为栅栏
    //边和扫描线的交点如果在栅栏左边，则填充交点到栅栏之间的像素(包括栅栏)，如果在栅栏的右边，则则填充交点到栅栏之间的像素(不包括栅栏)
    //栅栏填充算法也会填充部分多边形的边,如果填充色和边缘色不一样，需要重新绘制边缘
    public void FillPolygon()
    {
        //选第一个点的x坐标为栅栏，旋转栅栏的算法不一
        //可根据情况选择，如随机选择等
        int fence = points[0].x;
        
        loadPixels(); //获取显示窗口的像素
        
        int lastPoint = points.length -1;
        for(int i = 0; i < points.length; ++i)
        {
            FillLineRight(points[lastPoint].x, points[lastPoint].y ,points[i].x, points[i].y, fence);
            lastPoint = i;
        }
        
        updatePixels();
    }
    
    private void FillLineRight(int x1, int y1, int x2, int y2, int fence)
    {
        //显示窗口的宽度，用于操纵显示窗口的像素值
        int displayWindowWidth = 1000;
        
        if(y1 > y2)
        {
            y1 ^= y2;
            y2 ^= y1;
            y1 ^= y2;
            
            x1 ^= x2;
            x2 ^= x1;
            x1 ^= x2;
        }
        
        double k = y1 == y2 ? 0 : (x1 - x2) / (double)(y1 - y2);    //斜率的倒数
        double x = x1;
        //需要采用下闭上开原则，这里不能y<=y2这样判断，如果y1y2 y2y3两条边，如果y1<y2<y3会导致y2右边像素被填充两次导致错误的结果
        for(int y = y1; y < y2; ++y)
        {
            //x四舍五入为j
            int j = (int)(x + 0.5);
            
            if(j <= fence)
            {
                //在栅栏左边，填充栅栏和交点之间的坐标，包括栅栏
                for(; j <= fence; ++j)
                {
                    //对背景色进行取反操作,如果背景是白色，则填充反色就是黑色
                    //如果想填充自定义颜色如红色，则先将背景色先填充为红色的反色
                    int index = displayWindowWidth * y + j;
                    if(index < pixels.length && index >= 0)
                    {
                        pixels[index] = color(255 - red(pixels[index]),255 - green(pixels[index]), 255 - blue(pixels[index]));
                    }
                }
            }
            else
            {
                //在栅栏右边，填充栅栏和交点之间的坐标，不包括栅栏
                for(; j > fence; --j)
                {
                    //对背景色进行取反操作,如果背景是白色，则填充反色就是黑色
                    //如果想填充自定义颜色如红色，则先将背景色先填充为红色的反色
                    int index = displayWindowWidth * y + j;
                    if(index < pixels.length && index >= 0)
                    {
                        pixels[index] = color(255 - red(pixels[index]),255 - green(pixels[index]), 255 - blue(pixels[index]));
                    }
                }
            }           
            
            x += k;
        }
    }
}
