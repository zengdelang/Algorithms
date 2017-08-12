public class BezierTool
{
    //使用公式绘制二次贝塞尔曲线
    public void DrawBezier2(Point p1, Point p2, Point p3)
    {
        int   n = (int)(p3.x - p1.x);
        float delta = 1.0 / n;
        
        float x = p1.x;
        float y = p1.y;
        float _x, _y;
        
        float a, b, c;
        float t = 0;

        for(int i = 1; i <= n; ++i)
        {
            t += delta;
           
            a = (1- t) * (1 - t);
            b = 2 * t * (1 - t);
            c = t * t;
            
            _x = a * p1.x + b * p2.x + c * p3.x;
            _y = a * p1.y + b * p2.y + c * p3.y;
            
            line(x, y, _x, _y);
            
            x = _x;
            y = _y;
        }
    }
    
    //使用公式绘制三次贝塞尔曲线
    public void DrawBezier3(Point p1, Point p2, Point p3, Point p4)
    {
        int   n = (int)(p4.x - p1.x);
        float delta = 1.0 / n;
        
        float x = p1.x;
        float y = p1.y;
        float _x, _y;
        
        float a, b, c, d;
        float t = 0;

        for(int i = 1; i <= n; ++i)
        {
            t += delta;
           
            a = (1- t) * (1 - t) * (1 - t);
            b = 3 * t * (1 - t) * (1 - t);
            c = 3 * t * t *(1 - t);
            d = t * t * t;
            
            _x = a * p1.x + b * p2.x + c * p3.x + d * p4.x;
            _y = a * p1.y + b * p2.y + c * p3.y + d * p4.y;
            
            line(x, y, _x, _y);
            
            x = _x;
            y = _y;
        }
    }
    
    //使用de Casteliau算法绘制任意次次贝塞尔曲线
    public void DrawBezier(ArrayList<Point> points)
    {
        int n = points.size();
        if(n < 2)  
            return;
  
        float[] xArray = new float[n - 1];
        float[] yArray = new float[n - 1];

        float x = points.get(0).x;
        float y = points.get(0).y;
        float _x, _y;
        
        int   len = (int)(points.get(points.size()-1).x - x);
        float delta = 1.0 / len;
        float t = 0;
        
        for(int k = 1; k <= len; ++k)
        {
            t += delta;
            for(int i = 1; i < n; ++i)  
            {  
                for(int j = 0; j < n - i; ++j)  
                {  
                    if(i == 1) // i==1时,第一次迭代,由已知控制点计算  
                    {  
                        xArray[j] = points.get(j).x * (1 - t) + points.get(j + 1).x * t;  
                        yArray[j] = points.get(j).y * (1 - t) + points.get(j + 1).y * t;
                        continue;  
                    }  
  
                    // i != 1时,通过上一次迭代的结果计算  
                    xArray[j] = xArray[j] * (1 - t) + xArray[j + 1] * t;  
                    yArray[j] = yArray[j] * (1 - t) + yArray[j + 1] * t;  
                }  
            }  
            
            _x = xArray[0];  
            _y = yArray[0];  
            
            line(x, y, _x, _y);
            
            x = _x;
            y = _y;
        }
    }
}