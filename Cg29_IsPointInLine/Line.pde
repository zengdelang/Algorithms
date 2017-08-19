public class Line
{
    public float sx;
    public float sy;
    public float ex;
    public float ey;

    public Line(float _sx, float _sy, float _ex, float _ey)
    {
        sx = _sx;
        sy = _sy;
        ex = _ex;
        ey = _ey;
    }
    
    public void Render()
    {
        line(sx, sy, ex, ey);
    }
    
    //判断点是否在线段内
    public boolean IsPointInLine(float px, float py)
    {
        float x1 = px - sx;    //向量(px,py) - 向量(sx, sy)       
        float y1 = py - sy;
        
        float x2 = px - ex;    //向量(px,py) - 向量(sx, sy)  
        float y2 = py - ey;
        
        //使用叉积判断是不是共线，如果叉积为0，说明共线，点在线段所在直线上
        if(abs(CrossProduct(x1, y1, x2, y2)) < 1e-6)  //浮点数小于1e-6则近似等于0
        {
            //点是否在以线段为对角线的矩形内，如果是，则点在线内
            return IsPointInRect(px, py);
        }
        return false;
    }
       
    private float CrossProduct(float x1, float y1, float x2, float y2)
    {
        return x1 * y2 - y1 * x2;
    }
   
    public boolean IsPointInRect(float px, float py)
    {
        return ((px <= sx && px >= ex) || (px >= sx && px <= ex)) && ((py <= sy && py >= ey) || (py >= sy && py <= ey));
    }
}
