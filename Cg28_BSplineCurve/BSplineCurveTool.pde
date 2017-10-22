//B样条曲线的公式绘制算法
//还可以使用deboor算法生成任意
//次的B样条曲线
public class BSplineCurveTool
{
    //使用公式绘制二次B样条曲线
    public void DrawBSplineCurve(Point p1, Point p2, Point p3)
    {
        int   n = (int)abs(p3.x - p1.x);
        float delta = 1.0 / n;
        
        float x = p1.x;
        float y = p1.y;
        float _x, _y;
        boolean draw = false;
        
        float a, b, c;
        float t = 0;

        for(int i = 0; i <= n; ++i)
        {
            a = 0.5 * t * t - t + 0.5;
            b = - t * t + t + 0.5;
            c = 0.5 * t * t;
            
            t += delta;
            
            if(!draw)
            {
                draw = true;
                x = a * p1.x + b * p2.x + c * p3.x;
                y = a * p1.y + b * p2.y + c * p3.y;
                continue;
            }
            
            _x = a * p1.x + b * p2.x + c * p3.x;
            _y = a * p1.y + b * p2.y + c * p3.y;
            
            line(x, y, _x, _y);
            
            x = _x;
            y = _y;
        }
    }
    
     //使用公式绘制三次B样条曲线
    public void DrawBSplineCurve3(Point p1, Point p2, Point p3, Point p4)
    {
        int   n = (int)abs(p4.x - p1.x);
        float delta = 1.0 / n;
        
        float x = p1.x;
        float y = p1.y;
        float _x, _y;
        boolean draw = false;
        
        float a, b, c, d;
        float t = 0;

        for(int i = 0; i <= n; ++i)
        {
            a =(-t * t * t + 3 * t * t - 3 * t + 1) / 6;
            b =(3 * t * t * t - 6 * t * t + 4) / 6;
            c =(-3 * t * t * t + 3 * t * t + 3 * t + 1) / 6;
            d = t * t * t / 6;
            
            t += delta;
            
            if(!draw)
            {
                draw = true;
                x = a * p1.x + b * p2.x + c * p3.x + d * p4.x;
                y = a * p1.y + b * p2.y + c * p3.y + d * p4.y;
                continue;
            }
            
            _x = a * p1.x + b * p2.x + c * p3.x + d * p4.x;
            _y = a * p1.y + b * p2.y + c * p3.y + d * p4.y;
            
            line(x, y, _x, _y);
            
            x = _x;
            y = _y;
        }
    }
}
