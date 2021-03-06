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
    
    //边缘填充算法填充多边形，先找到多边形的外接矩形的最大x坐标
    //然后填充多边形每一条边到外接矩形的最右边之间的所有像素，使用颜色取反操作填充像素
    //边缘填充算法会多次填充同一个像素多次以及可能多次填充多边形外的像素，所以效率不高
    //边缘填充算法也会填充部分多边形的边,如果填充色和边缘色不一样，需要重新绘制边缘
    public void FillPolygon()
    {
        int xMax = points[0].x;
        for(int i = 1; i < points.length; ++i)
        {
            Point point = points[i];
            if(point.x > xMax)
            {
                xMax = point.x;
            }            
        }
        
        loadPixels(); //获取显示窗口的像素
        
        int lastPoint = points.length -1;
        for(int i = 0; i < points.length; ++i)
        {
            FillLineRight(points[lastPoint].x, points[lastPoint].y ,points[i].x, points[i].y, xMax);
            lastPoint = i;
        }
        
        updatePixels();
    }
    
    private void FillLineRight(int x1, int y1, int x2, int y2, int xMax)
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
            for(int j = (int)(x + 0.5); j <= xMax; ++j)
            {
                //对背景色进行取反操作,如果背景是白色，则填充反色就是黑色
                //如果想填充自定义颜色如红色，则先将背景色先填充为红色的反色
                int index = displayWindowWidth * y + j;
                if(index < pixels.length && index >= 0)
                {
                    pixels[index] = color(255 - red(pixels[index]),255 - green(pixels[index]), 255 - blue(pixels[index]));
                }
            }
            x += k;
        }
    }
}