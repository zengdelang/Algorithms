public class Segment
{  
    private int x1;
    private int y1;
    private int x2;
    private int y2;
    
    public Segment(int _x1, int _y1, int _x2, int _y2)
    {
        x1 = _x1;
        y1 = _y1;
        x2 = _x2;
        y2 = _y2;
    }
    
    public void Render()
    {
        line(x1, y1, x2, y2);
    }
    
    public Point IntersectPoint(Segment other)
    {
        //叉积判断是否共线,这里使用的整数坐标，如果是float需要修改
        if(CrossProduct(x1 - x2, y1 - y2, other.x1 - other.x2, other.y1 - other.y2) == 0)
        {
            return null;
        }
        
        //线段相交才有交点
        if(SegmentsIntersect(other))
        {
            //(x1,y1),(x2,y2),(other.x1, other.y1)三点构成的三角形的面积
            float s1 = abs(CrossProduct(x1, y1, x2, y2, other.x1, other.y1));
            float s2 = abs(CrossProduct(x1, y1, x2, y2, other.x2, other.y2));     
            return new Point((s1 * other.x2 + s2 * other.x1) / (s1 + s2), (s1 * other.y2 + s2 * other.y1) / (s1 + s2));
        }
        
        return null;
    }
    
    //判断两个线段是否相交
    public boolean SegmentsIntersect(Segment other)
    {
        int d1 = CrossProduct(x1, y1, x2, y2, other.x1, other.y1);
        //如果是float来表示点的坐标，d1需要和1e-6进行近似比较来判断是否近似等于0
        if(d1 == 0 && OnSegments(x1, y1, x2, y2, other.x1, other.y1))
        {
            return true;
        }
        
        int d2 = CrossProduct(x1, y1, x2, y2, other.x2, other.y2);
        if(d2 == 0 && OnSegments(x1, y1, x2, y2, other.x2, other.y2))
        {
            return true;
        }
        
        if((d1 > 0 && d2 < 0) || (d1 < 0 && d2 > 0))
        {
            int d3 = CrossProduct(other.x1, other.y1, other.x2, other.y2, x1, y1);
            //如果是float来表示点的坐标，d1需要和1e-6进行近似比较来判断是否近似等于0
            if(d3 == 0 && OnSegments(other.x1, other.y1, other.x2, other.y2, x1, y1))
            {
                return true;
            }
            
            int d4 = CrossProduct(other.x1, other.y1, other.x2, other.y2, x2, y2);
            if(d4 == 0 && OnSegments(other.x1, other.y1, other.x2, other.y2, x2, y2))
            {
                return true;
            }
            
            if((d3 > 0 && d4 < 0) || (d3 < 0 && d4 > 0))
            {
                return true;
            }
        }
        return false;
    }
    
    //判断点(px3, py3)是否在(px1, py1)和(px2, py2)的线段上，首先需要判断三者的叉积为0
    private boolean OnSegments(int px1, int py1, int px2, int py2, int px3, int py3)
    {
        return ((px3 >= px1 && px3 <= px2) || (px3 <= px1 && px3 >= px2)) && ((py3 >= py1 && py3 <= py2) || (py3 <= py1 && py3 >= py2));
    }
    
    //求(px2 - px1, py2 - py1)和(px3 - px1, py3 - py1)的叉积
    public int CrossProduct(int px1, int py1, int px2, int py2, int px3, int py3)
    {
        return (px2 - px1) * (py3 - py1) - (px3 - px1) * (py2 - py1);
    }
    
    //求(px1, py1)和(px2, py2)的叉积
    public int CrossProduct(int px1, int py1, int px2, int py2)
    {
        return px1 * py2 - px2 * py1;
    }
}