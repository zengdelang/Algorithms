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
    
    //扫描线种子填充算法填充多边形
    public void FillPolygon(int seedX, int seedY, color boundaryColor, color newColor)
    {   
        //Processing中不能直接使用栈，这里用ArrayList代替
        ArrayList<Point> stack = new ArrayList<Point>();
        
        loadPixels(); //获取显示窗口的像素
        
        if(CanReplaceColor(seedX, seedY, boundaryColor, newColor))
        {
             stack.add(new Point(seedX, seedY));  
        }
        
        while(stack.size() > 0)
        {
            Point p = stack.get(stack.size() -1);
            stack.remove(stack.size() -1);
            
            int count = FillLineRight(p.x, p.y, boundaryColor, newColor);
            int xRight = p.x + count - 1;
            
            count = FillLineLeft(p.x - 1, p.y, boundaryColor, newColor);
            int xLeft = p.x - count;
            
            FindNewSeed(stack, xLeft, xRight, p.y - 1, boundaryColor, newColor);
            FindNewSeed(stack, xLeft, xRight, p.y + 1, boundaryColor, newColor);
        }
             
        updatePixels();
    }
    
    private boolean CanReplaceColor(int x, int y, color boundaryColor, color newColor)
    {
        //显示窗口的宽度，用于操纵显示窗口的像素值
        int displayWindowWidth = 1000;
        
        int index = displayWindowWidth * y + x;
        if(index < pixels.length && index >= 0)
        {
            if(boundaryColor != pixels[index] && pixels[index] != newColor)
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
    
    private int FillLineRight(int x, int y, color boundaryColor, color newColor)
    {
        int count = 0;
        while(true)
        {
            if(!CanReplaceColor(x, y, boundaryColor, newColor))
            {
                break;           
            }
            SetNewColor(x, y, newColor);
            ++count;
            ++x;
        }        
        return count;
    }
    
    private int FillLineLeft(int x, int y, color boundaryColor, color newColor)
    {
        int count = 0;
        while(true)
        {
            if(!CanReplaceColor(x, y, boundaryColor, newColor))
            {
                break;           
            }
            SetNewColor(x, y, newColor);
            ++count;
            --x;
        }        
        return count;
    }
    
    private void FindNewSeed(ArrayList<Point> stack, int xLeft, int xRight, int scanLine, color boundaryColor, color newColor)
    {     
        while(xLeft <= xRight)
        {
            boolean findNewSeed = false;
            while(CanReplaceColor(xLeft, scanLine, boundaryColor, newColor) && (xLeft < xRight))
            {
                findNewSeed = true;
                ++xLeft;
            }
            
            if(findNewSeed)
            {
                if(CanReplaceColor(xLeft, scanLine, boundaryColor, newColor) && (xLeft == xRight))
                {
                    stack.add(new Point(xLeft, scanLine));
                }
                else
                {
                    stack.add(new Point(xLeft - 1, scanLine));
                }
            }
            
            int xspan = SkipInvaildInLine(xLeft, xRight, scanLine, boundaryColor, newColor);
            xLeft += (xspan == 0) ? 1 : xspan;
        }
    }
    
    private int SkipInvaildInLine(int xLeft, int xRight, int y, color boundaryColor, color newColor)
    {
        int count = 0;
        for(int x = xLeft; x <= xRight; ++x)
        {
            if(!CanReplaceColor(x, y, boundaryColor, newColor))
            {
                ++count;
            }
        }
        
        return count;
    }
}