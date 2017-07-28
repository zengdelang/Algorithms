public class Circle
{
    public int x;
    public int y;
    public int r;
    
    public Circle(int _x, int _y, int _r)
    {
        x = _x;
        y = _y;
        r = _r;
    }
    
    public void Render()
    {
        ellipse(x, y, 2* r, 2*r);
    }
    
    public boolean IsPointInCircle(int _x, int _y)
    {
        //代入圆方程， （x - x1）^2 + (y - y1)^2 = r^2
        //如果点在圆上或者圆内，方程的值小于等于0
        int xDelta = _x - x;
        int yDelta = _y - y;
        return (xDelta * xDelta + yDelta * yDelta) <= r*r;
    }
    
    public boolean IsPointInCircle1(int _x, int _y)
    {
        //点到圆心的距离是否小于等于半径,推荐使用下面的方法，开平方的效率低
        int xDelta = _x - x;
        int yDelta = _y - y;
        return sqrt(xDelta * xDelta + yDelta * yDelta) <= r;
    }
}