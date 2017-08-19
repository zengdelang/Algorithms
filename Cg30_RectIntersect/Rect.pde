public class Rect
{
    public int topLeftX;        //左上角的坐标
    public int topLeftY;
    
    public int bottomRightX;    //右下角的坐标
    public int bottomRightY;
    
    public boolean trackMouse;
    
    public Rect(int _x1, int _y1, int _x2, int _y2, boolean _trackMouse)
    {
        topLeftX = _x1;
        topLeftY = _y1;
        bottomRightX = _x2;
        bottomRightY = _y2;
        trackMouse = _trackMouse;
    }
    
    public void Render()
    {
        if(trackMouse)
        {
            float halfWidth  = (bottomRightX - topLeftX) * 0.5;
            float halfHeight = (bottomRightY - topLeftY) * 0.5;
            topLeftX = mouseX - (int)halfWidth;
            bottomRightX = mouseX + (int)halfWidth;
            topLeftY = mouseY - (int)halfHeight;
            bottomRightY = mouseY + (int)halfHeight;
        }
        
        line(topLeftX, topLeftY, bottomRightX, topLeftY);
        line(bottomRightX, topLeftY, bottomRightX, bottomRightY);
        line(bottomRightX, bottomRightY, topLeftX, bottomRightY);
        line(topLeftX, bottomRightY,topLeftX, topLeftY);
    }
    
    public boolean Intersect(Rect r)
    {
        float halfWidth  = (bottomRightX - topLeftX + r.bottomRightX - r.topLeftX) * 0.5;   //两个矩形宽度和的一半
        float halfHeight = (bottomRightY - topLeftY + r.bottomRightY - r.topLeftY) * 0.5;   //两个矩形高度和的一半
        
        float x = (bottomRightX + topLeftX - r.bottomRightX - r.topLeftX) * 0.5; //两个矩形中心向量相减的x分量
        float y = (bottomRightY + topLeftY - r.bottomRightY - r.topLeftY) * 0.5; //两个矩形中心向量相减的y分量
        
        return abs(x) <= halfWidth && abs(y) <= halfHeight;
    }
}