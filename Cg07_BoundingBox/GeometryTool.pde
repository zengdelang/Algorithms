public class Rect
{
    public int topLeftX;
    public int topLeftY;
    public int bottomRightX;
    public int bottomRightY;
    
    public Rect(int _x1, int _y1, int _x2, int _y2)
    {
        topLeftX = _x1;
        topLeftY = _y1;
        bottomRightX = _x2;
        bottomRightY = _y2;
    }
    
    public void Render()
    {
        line(topLeftX, topLeftY, bottomRightX, topLeftY);
        line(bottomRightX, topLeftY, bottomRightX, bottomRightY);
        line(bottomRightX, bottomRightY, topLeftX, bottomRightY);
        line(topLeftX, bottomRightY, topLeftX, topLeftY);
    }
}

public class GeometryTool
{
    public Rect GetBoundingBox(Point[] points)
    {
        int _x1, _y1, _x2, _y2;
        _x1 = _x2 = points[0].x;
        _y1 = _y2 = points[0].y;
        
        for(int i = 1; i < points.length; ++i)
        {
            Point point = points[i];
 
            if(point.x < _x1)
            {
                _x1 = point.x;
            }
            
            if(point.x > _x2)
            {
                _x2 = point.x;
            }
            
            if(point.y > _y1)
            {
                _y1 = point.y;
            }
            
            if(point.y < _y2)
            {
                _y2 = point.y;
            }
        }
        
        return new Rect(_x1, _y1, _x2, _y2);
    }
}
