public class CatmullRomIntInterpolation
{ 
    public void AddSplineCurvePoint(ArrayList<Point> points, ArrayList<Point> pointList)
    {
        if(pointList.size() == 0)
        {
            pointList.add(points.get(0));
        }
        
        //Cardinal曲线需要四个点才能绘制一段曲线, 如P0, P1, P2, P3这样只能绘制P1P2之间的曲线段
        //当开头第一个点没有上一个点时，即想绘制P0P1,则把2P0 - P1当作前一个控制点
        int i = points.size() - 2;
        Point p0 = i <= 0 ? new Point(2*points.get(i).x - points.get(i).x, 2*points.get(i).y - points.get(i).y) : points.get(i-1);
        //当想绘制P2P3时，把2P3 - P2当作最后一个控制点
        Point p3 = (i+2 >= points.size()) ? new Point(2*points.get(i+1).x - points.get(i).x, 2*points.get(i+1).y - points.get(i).y) : points.get(i+2);
        CatmullRom(pointList, int(abs(points.get(i+1).x - points.get(i).x)), p0, points.get(i), points.get(i+1), p3);
    }
    
    private void CatmullRom(ArrayList<Point> pointList,int n, Point p1, Point p2, Point p3, Point p4)
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
            
            a = -0.5 * t3 + t2 - 0.5 * t; 
            b = 1.5 * t3 - 2.5 * t2 + 1; 
            c = -1.5 * t3 + 2 * t2 + 0.5 * t; 
            d = 0.5 * (t3 - t2); 
                
            x = a * p1.x + b * p2.x + c * p3.x + d * p4.x;
            y = a * p1.y + b * p2.y + c * p3.y + d * p4.y;
            pointList.add(new Point(x, y));
        } 
    }
}