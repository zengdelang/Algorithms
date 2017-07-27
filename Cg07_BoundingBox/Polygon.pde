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
        for(int i = 0; i < points.length; ++i)
        {
            Point nextPoints = points[(i + 1) % points.length];
            line(points[i].x, points[i].y, nextPoints.x, nextPoints.y);
        }
    }
    
    public void ShowBoundingBox()
    {
        //不知道Processing的语法为什么用静态类会编译不过
        Rect box = (new GeometryTool()).GetBoundingBox(points);
        box.Render();
    }
}