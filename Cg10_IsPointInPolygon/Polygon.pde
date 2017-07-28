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
    
    /*
        使用射线法判断点是否在多边形内
        如果点在多边形内部返回true,否则返回false
        如果点在多边形的边上，可能返回true也可能返回false,如果需要明确该状况，需要添加点是否在多边形的边上的处理
        如果多边形比较复杂并且数量较多，需要频繁检查是否点在多边形内部，可以先求出多边形的外接矩阵，先判断点是否在外接矩形
        中以此过滤点
    */
    public boolean IsPointInPolygon(int x, int y)
    {
        int     lastPointIndex = points.length -1;
        boolean oddNodes  = false;             //射线与多边形的边相交是否是奇数个交点
        
        for(int i = 0; i < points.length; ++i)
        {
            Point lastPoint = points[lastPointIndex];
            Point curPoint = points[i];
            
            //只有当边的两个顶点，一个在当前点所在直线的下方，另一个在当前点所在直线上或上方
            //才进行检测，如果当前点的x坐标在边的最大x的右边也过滤(此时从当前点向右发射射线不会有交点)
            if((curPoint.y < y && lastPoint.y >= y || lastPoint.y < y && curPoint.y >= y)
                && (curPoint.x <= x || lastPoint.x <= x))
            {
                //if(curPoint.x + (float)(y - curPoint.y) / (lastPoint.y - curPoint.y) * (lastPoint.x - curPoint.x) < x)
                //{
                //    oddNodes = !oddNodes;
                //}
                //使用异或消除上面的条件判断
                oddNodes ^= curPoint.x + (float)(y - curPoint.y) / (lastPoint.y - curPoint.y) * (lastPoint.x - curPoint.x) < x;
            }
            
            lastPointIndex = i;
        }
        
        return oddNodes;
    }
}