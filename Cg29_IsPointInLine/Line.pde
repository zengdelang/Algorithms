public class Line
{
    public float x1;
    public float y1;
    public float x2;
    public float y2;

    public Line(float _x1, float _y1, float _x2, float _y2)
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
    
    public boolean IsPointInLine(float px, float py)
    {
        
    }
   
    public boolean IsPointInRect(int x, int y)
    {
        return x >= topLeftX && x <= bottomRightX && y >= bottomRightY && y <= topLeftY;
    }
    
    //判定点是否在矩形内
    //检查点是否在边界内，只适合矩形的边平行于x和y轴的矩形，不适合旋转的矩形
    public boolean IsPointInRect1(int x, int y)
    {              
        return (x - topLeftX) * (x - bottomRightX) <= 0 && (y - topLeftY) * (y - bottomRightY) <= 0;
    }
}