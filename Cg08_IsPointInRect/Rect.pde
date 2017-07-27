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

public class Rect
{
    public int topLeftX;
    public int topLeftY;
    public int bottomRightX;
    public int bottomRightY;
    
    public float angle;   //旋转角度
    
    public Rect(int _x1, int _y1, int _x2, int _y2, float _angle)
    {
        topLeftX = _x1;
        topLeftY = _y1;
        bottomRightX = _x2;
        bottomRightY = _y2;
        
        angle = _angle;
    }
    
    public Rect GetBoundingBox()
    {
        int _x1, _y1, _x2, _y2;
        Point[] points = new Point[4];
        points[0] = RotatePoint(topLeftX, topLeftY);
        points[1] = RotatePoint(bottomRightX, topLeftY);
        points[2] = RotatePoint(bottomRightX, bottomRightY);
        points[3] = RotatePoint(topLeftX, bottomRightY);
        
        _x1 = _x2 = points[0].x;
        _y1 = _y2 = points[0].y;
        
        for(int i = 0; i < points.length; ++i)
        {
            Point point = points[i];
 
            if(point.x < _x1)
            {
                _x1 = point.x;
            }
            
            if(point.x > _x2)
            {
                _x2 = point.x;
            }
            
            if(point.y > _y1)
            {
                _y1 = point.y;
            }
            
            if(point.y < _y2)
            {
                _y2 = point.y;
            }
        }
        
        return new Rect(_x1, _y1, _x2, _y2, 0);
    }
    
    private Point RotatePoint(int x, int y)
    {
        //旋转矩阵
        // x1  x2      cosX  -sinX
        // y1  y2      sinX  cosX
        float x1 = cos(angle);
        float x2 = -sin(angle);
        float y1 = -x2;
        float y2 = x1;
        
        return new Point((int)(x1 * x + x2 * y + 0.5), (int)(y1*x+y2*y+0.5)); //0.5四舍五入为整数
    }
    
    public void Render()
    {
        Point point1 = RotatePoint(topLeftX, topLeftY);
        Point point2 = RotatePoint(bottomRightX, topLeftY);
        Point point3 = RotatePoint(bottomRightX, bottomRightY);
        Point point4 = RotatePoint(topLeftX, bottomRightY);
        
        line(point1.x, point1.y, point2.x, point2.y);
        line(point2.x, point2.y, point3.x, point3.y);
        line(point3.x, point3.y, point4.x, point4.y);
        line(point4.x, point4.y, point1.x, point1.y);
    }
    
    public void ShowBoundingBox()
    {
        Rect box = GetBoundingBox();
        stroke(255,0,0);
        line(box.topLeftX, box.topLeftY, box.bottomRightX, box.topLeftY);
        line(box.bottomRightX, box.topLeftY, box.bottomRightX, box.bottomRightY);
        line(box.bottomRightX, box.bottomRightY, box.topLeftX, box.bottomRightY);
        line(box.topLeftX, box.bottomRightY, box.topLeftX, box.topLeftY);
    }
    
    //判定点是否在矩形内
    //检查点是否在边界内，只适合矩形的边平行于x和y轴的矩形，不适合旋转的矩形
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
    
    //判定点是否在矩形内
    //使用向量叉积来判断，可用于判断旋转的矩形
    //如果矩形旋转还可以使用，判断点在多边形内方法来判断,把旋转后的矩形当作多边形对待
    //如果矩形旋转还可以使用的方法是建立一个新的坐标系，可以以矩形中心为中点，x轴和y
    //轴平行于矩形的边建立坐标系，利用矩阵把点转化道该坐标系中，然后就可以使用
    //IsPointInRect和IsPointInRect1中的方法
    public boolean IsPointInRect2(int x, int y)
    {   
        /*
        Point point1 = RotatePoint(topLeftX, topLeftY);
        Point point2 = RotatePoint(bottomRightX, topLeftY);
        Point point3 = RotatePoint(bottomRightX, bottomRightY);
        Point point4 = RotatePoint(topLeftX, bottomRightY);
        
        //Vector1 代表 topLeftPoint - p
        int x1 = point1.x - x;
        int y1 = point1.y - y;
        
        //Vector2 代表 bottomLeftPoint - p
        int x2 = point4.x - x;
        int y2 = point4.y - y;
        
        //Vector3 代表 topRightPoint - p
        int x3 = point2.x - x;
        int y3 = point2.y - y;
        
        //Vector4 代表 bottomRightPoint - p
        int x4 = point3.x - x;
        int y4 = point3.y - y;
        
        //计算叉积
        boolean cp1 = (x1 * y2 - x2 * y1) >= 0 && (x4 * y3 - x3 * y4) >=0;
             
        //Vector5 代表 topRightPoint - p
        int x5 = point2.x - x;
        int y5 = point2.y - y;
        
        //Vector6 代表 topLeftPoint - p
        int x6 = point1.x - x;
        int y6 = point1.y - y;
        
        //Vector7 代表 bottomLeftPoint - p
        int x7 = point4.x - x;
        int y7 = point4.y - y;
        
        //Vector8 代表 bottomRightPoint - p
        int x8 = point3.x - x;
        int y8 = point3.y - y;
        
        //计算叉积
        boolean cp2 = (x5 * y6 - x6 * y5) >= 0 && (x7 * y8 - x8 * y7) >=0;
        
        return cp1 && cp2;*/
        
        //上述方法的优化
        //先判断点p是否在P1P4叉积大于等于0的那一侧，叉积可用于判断位于直线的哪一侧
        //然后再判断位于另一条边的叉积大于等于0的那一侧
        //以此类推判断完4条边
        Point point1 = RotatePoint(topLeftX, topLeftY);
        Point point2 = RotatePoint(bottomRightX, topLeftY);
        Point point3 = RotatePoint(bottomRightX, bottomRightY);
        Point point4 = RotatePoint(topLeftX, bottomRightY);
        
        //Vector1 代表 topLeftPoint - p
        int x1 = point1.x - x;
        int y1 = point1.y - y;
        
        //Vector2 代表 bottomLeftPoint - p
        int x2 = point4.x - x;
        int y2 = point4.y - y;
        
        if((x1 * y2 - x2 * y1) >= 0)
        {
             //Vector3 代表 topRightPoint - p
            int x3 = point2.x - x;
            int y3 = point2.y - y;
        
            //Vector4 代表 bottomRightPoint - p
            int x4 = point3.x - x;
            int y4 = point3.y - y;
            
            if((x4 * y3 - x3 * y4) >=0)
            {
                //Vector5 代表 topRightPoint - p
                int x5 = point2.x - x;
                int y5 = point2.y - y;
                
                //Vector6 代表 topLeftPoint - p
                int x6 = point1.x - x;
                int y6 = point1.y - y;
                
                if((x5 * y6 - x6 * y5) >= 0)
                {
                    //Vector7 代表 bottomLeftPoint - p
                    int x7 = point4.x - x;
                    int y7 = point4.y - y;
        
                    //Vector8 代表 bottomRightPoint - p
                    int x8 = point3.x - x;
                    int y8 = point3.y - y;
                    
                    if((x7 * y8 - x8 * y7) >=0)
                    {
                        return true;
                    }
                }
            }
        }
        return false;
    }
}