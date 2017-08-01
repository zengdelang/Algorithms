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
        for(int i = 0; i < points.length; ++i)
        {
            line(points[lastPoint].x, points[lastPoint].y ,points[i].x, points[i].y);
            lastPoint = i;
        }
    }
    
    //注入填充算法填充多边形
    public void FillPolygon(int seedX, int seedY, color oldColor, color newColor, boolean isDir8)
    {
        Point[] dir_8 = new Point[8];
        dir_8[0] = new Point(0,-1);
        dir_8[1] = new Point(1,0);
        dir_8[2] = new Point(0,1);
        dir_8[3] = new Point(-1,0);
        dir_8[4] = new Point(-1,-1);
        dir_8[5] = new Point(1,-1);
        dir_8[6] = new Point(1,1);
        dir_8[7] = new Point(-1,1);
        
        //Processing中不能直接使用栈，这里用ArrayList代替
        ArrayList<Point> stack = new ArrayList<Point>();
        
        loadPixels(); //获取显示窗口的像素
        
        if(IsOldColor(seedX, seedY, oldColor))
        {
             stack.add(new Point(seedX, seedY));  
        }
        
        int dirLength = isDir8 ? 8 : 4;
        while(stack.size() > 0)
        {
            Point p = stack.get(stack.size() -1);
            stack.remove(stack.size() -1);
            SetNewColor(p.x, p.y, newColor);
            
            for(int i = 0; i < dirLength; ++i)
            {
               if(IsOldColor(p.x + dir_8[i].x, p.y + dir_8[i].y, oldColor))
               {
                   stack.add(new Point(p.x + dir_8[i].x, p.y + dir_8[i].y));
               }
            }
        }
             
        updatePixels();
    }
    
    private boolean IsOldColor(int x, int y, color oldColor)
    {
        //显示窗口的宽度，用于操纵显示窗口的像素值
        int displayWindowWidth = 1000;
        
        int index = displayWindowWidth * y + x;
        if(index < pixels.length && index >= 0)
        {
            if(pixels[index] == oldColor)
            {
               return true; 
            }
        }
        return false;
    }
    
    private void SetNewColor(int x, int y, color newColor)
    {
        //显示窗口的宽度，用于操纵显示窗口的像素值
        int displayWindowWidth = 1000;
        
        int index = displayWindowWidth * y + x;
        if(index < pixels.length && index >= 0)
        {
            pixels[index] = newColor;
        }
    }
}
