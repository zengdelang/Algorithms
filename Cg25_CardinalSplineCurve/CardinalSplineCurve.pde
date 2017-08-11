//Cardianl样条曲线（Hermite样条曲线的改进）
public class CardinalSplineCurve
{
    //绘制Cardinal样条曲线
    public void DrawCardinalSplineCurve(Point[] points)
    {
        for(int i = 0; i < points.length - 1; ++i)
        {
            //Cardinal曲线需要四个点才能绘制一段曲线, 如P0, P1, P2, P3这样只能绘制P1P2之间的曲线段
            //当开头第一个点没有上一个点时，即想绘制P0P1,则把2P0 - P1当作前一个控制点
            Point p0 = i <= 0 ? new Point(2*points[i].x - points[i].x, 2*points[i].y - points[i].y) : points[i-1];
            //当想绘制P2P3时，把2P3 - P2当作最后一个控制点
            Point p3 = (i+2 >= points.length) ? new Point(2*points[i+1].x - points[i].x, 2*points[i+1].y - points[i].y) : points[i+2];
            Cardinal(int(abs(points[i+1].x - points[i].x)), p0, points[i], points[i+1], p3, 0.5);
        }
    }
    
    public void AddCardinalSplineCurve(Point[] points, ArrayList<Point> pointList)
    {
        if(pointList.size() == 0)
        {
            pointList.add(points[0]);
        }
        
        //Cardinal曲线需要四个点才能绘制一段曲线, 如P0, P1, P2, P3这样只能绘制P1P2之间的曲线段
        //当开头第一个点没有上一个点时，即想绘制P0P1,则把2P0 - P1当作前一个控制点
        int i = points.length - 2;
        Point p0 = i <= 0 ? new Point(2*points[i].x - points[i].x, 2*points[i].y - points[i].y) : points[i-1];
        //当想绘制P2P3时，把2P3 - P2当作最后一个控制点
        Point p3 = (i+2 >= points.length) ? new Point(2*points[i+1].x - points[i].x, 2*points[i+1].y - points[i].y) : points[i+2];
        Cardinal2(pointList, int(abs(points[i+1].x - points[i].x)), p0, points[i], points[i+1], p3, 0.5);
    }
    
    //根据四个点生成一段Cardinal曲线，u是张力参数，当u = 0.5就是Catmull-Rom样条插值
    private void Cardinal(int n, Point p1, Point p2, Point p3, Point p4, float u)
    {
        float a, b, c, d;
        float delta = 1.0 / n; 
        float t = 0, t2 = 0, t3 =0;
        
        boolean draw = false;
        float x = 0,y = 0, _x = 0, _y = 0;
        
        for (int i = 0; i <= n; i++) 
        {
            t2 = t * t;
            t3 = t * t * t;
            
            a = -u * t3 + 2 * u * t2 - u * t; 
            b = (2 - u) * t3 + (u - 3) * t2 + 1; 
            c = (u - 2) * t3 + (3 - 2 * u) * t2 + u * t; 
            d = u * t3 - u * t2; 
                
            if(!draw)
            {
                draw = true;
                x = a * p1.x + b * p2.x + c * p3.x + d * p4.x;
                y = a * p1.y + b * p2.y + c * p3.y + d * p4.y;
            }
            else
            {
                _x = a * p1.x + b * p2.x + c * p3.x + d * p4.x;
                _y = a * p1.y + b * p2.y + c * p3.y + d * p4.y;
                
                line(x, y, _x, _y);
                
                x = _x;
                y = _y;
            }
            
            t += delta;
        } 
    }
    
    //根据四个点生成一段Cardinal曲线，u是张力参数，当u = 0.5就是Catmull-Rom样条插值
    private void Cardinal2(ArrayList<Point> pointList,int n, Point p1, Point p2, Point p3, Point p4, float u)
    {
        float a, b, c, d;
        float delta = 1.0 / n; 
        float t = 0, t2 = 0, t3 =0;
        
        float x, y;
        
        //从1开始不添加第一个点
        for (int i = 1; i <= n; i++) 
        {
            t += delta;
           
            t2 = t * t;
            t3 = t * t * t;
            
            a = -u * t3 + 2 * u * t2 - u * t; 
            b = (2 - u) * t3 + (u - 3) * t2 + 1; 
            c = (u - 2) * t3 + (3 - 2 * u) * t2 + u * t; 
            d = u * t3 - u * t2; 
                
            x = a * p1.x + b * p2.x + c * p3.x + d * p4.x;
            y = a * p1.y + b * p2.y + c * p3.y + d * p4.y;
            pointList.add(new Point(x, y));
        } 
    }
}