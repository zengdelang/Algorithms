public class Triangle
{
    public float x1;
    public float y1;
    
    public float x2;
    public float y2;
    
    public float x3;
    public float y3;
    
    public int mode = 4;  //1 画重心   2 画外心  3 画内心 4 画垂心
    CircleAnimation circleAnimation;
    
    public Triangle(float _x1, float _y1, float _x2, float _y2, float _x3, float _y3)
    {
        x1 = _x1;
        y1 = _y1;
        x2 = _x2;
        y2 = _y2;
        x3 = _x3;
        y3 = _y3;
        
        circleAnimation = new CircleAnimation();
    }

    public void Render()
    {
        line(x1, y1, x2, y2);
        line(x2, y2, x3, y3);
        line(x3, y3, x1, y1);
        
        if(mode == 1)   //重心,三条边中线的交点
        {
            circleAnimation.x = (x1 + x2 + x3) / 3;
            circleAnimation.y = (y1 + y2 + y3) / 3;
            circleAnimation.Render();
            
            line(x1, y1, (x2 + x3) / 2, (y2 + y3) / 2);
            line(x2, y2, (x1 + x3) / 2, (y1 + y3) / 2);
            line(x3, y3, (x2 + x1) / 2, (y2 + y1) / 2);
        }
        
        if(mode == 2)  //外心 
        {
            Point p = GetCircumcenter(x1, y1, x2, y2, x3, y3);
            
            circleAnimation.x = p.x;
            circleAnimation.y = p.y;
            circleAnimation.Render();
            
            float len = sqrt((p.x - x1) * (p.x - x1) + (p.y - y1) * (p.y - y1));
            noFill();
            ellipse(p.x, p.y, 2*len, 2*len);
        }
        
        if(mode == 3)  //内心 
        {
            Point p = GetIncenter(x1, y1, x2, y2, x3, y3);
            
            circleAnimation.x = p.x;
            circleAnimation.y = p.y;
            circleAnimation.Render();
            
            float len = GetIncircleRadius(x1, y1, x2, y2, x3, y3);
            noFill();
            ellipse(p.x, p.y, 2*len, 2*len);
        }
        
        if(mode == 4)  //垂心 
        {
            Point p = GetOrthocenter(x1, y1, x2, y2, x3, y3);
            
            circleAnimation.x = p.x;
            circleAnimation.y = p.y;
            circleAnimation.Render();
            
            //float len = GetIncircleRadius(x1, y1, x2, y2, x3, y3);
            //noFill();
            //ellipse(p.x, p.y, 2*len, 2*len);
        }
    }
    
    //得到外心的坐标
    private Point GetCircumcenter(float x1, float y1, float x2, float y2, float x3, float y3)
    {
        //这里没做三点共线检查，可以用叉积做三点共线检查
        float a1 = 2 * (x2 - x1);
        float b1 = 2 * (y2 - y1);
        float c1 = x2 * x2 + y2 * y2 - x1 * x1 - y1 * y1;
        float a2 = 2 * (x3 - x2);
        float b2 = 2 * (y3 - y2);
        float c2 = x3*x3 + y3*y3 - x2*x2 - y2*y2;
        
        float x = (c1*b2 - c2*b1) / (a1*b2 - a2*b1);
        float y = (a1*c2 - a2*c1) / (a1*b2 - a2*b1);
        Point p = new Point(x, y);
        return p;
    }
    
    //得到内心的坐标
    private Point GetIncenter(float x1, float y1, float x2, float y2, float x3, float y3)
    {
        //这里没做三点共线检查，可以用叉积做三点共线检查
        float a = sqrt((x3 - x2) * (x3 - x2) + (y3 - y2) * (y3 - y2));   //(x2, y2) (x3, y3)的边长
        float b = sqrt((x3 - x1) * (x3 - x1) + (y3 - y1) * (y3 - y1));   //(x1, y1) (x3, y3)的边长
        float c = sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));   //(x2, y2) (x1, y1)的边长
        
        float x = (a * x1 + b * x2 + c * x3) / (a + b + c);
        float y = (a * y1 + b * y2 + c * y3) / (a + b + c);
        Point p = new Point(x, y);
        return p;
    }
    
    //得到内心的半径
    private float GetIncircleRadius(float x1, float y1, float x2, float y2, float x3, float y3)
    {
        //这里没做三点共线检查，可以用叉积做三点共线检查
        float a = sqrt((x3 - x2) * (x3 - x2) + (y3 - y2) * (y3 - y2));   //(x2, y2) (x3, y3)的边长
        float b = sqrt((x3 - x1) * (x3 - x1) + (y3 - y1) * (y3 - y1));   //(x1, y1) (x3, y3)的边长
        float c = sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));   //(x2, y2) (x1, y1)的边长
        
        float px1 = x1 - x2;
        float py1 = y1 - y2;
        float px2 = x3 - x2;
        float py2 = y3 - y2;
        
        float s = abs(px1 * py2 - py1 * px2); //叉积求平行四边形的面积   
        return s / (a + b + c);
    }
    
    //得到垂心的坐标
    private Point GetOrthocenter(float x1, float y1, float x2, float y2, float x3, float y3)
    {
        //这里没做三点共线检查，可以用叉积做三点共线检查
        float pAx = x3 - x2;   //向量BC
        float pAy = y3 - y2;
        
        float pBx = x1 - x3;  //向量CA
        float pBy = y1 - y3;
        
        float pCx = x2 - x1;  //向量AB
        float pCy = y2 - y1;
        
        float a = (pAx * pBx + pAy * pBy) * (pAx * pCx + pAy * pCy); // dotProduct(BC,CA) * dotProduct(BC,AB)
        float b = (pBx * pCx + pBy * pCy) * (pBx * pAx + pBy * pAy); // dotProduct(CA,AB) * dotProduct(CA,BC)
        float c = (pCx * pAx + pCy * pAy) * (pCx * pBx + pCy * pBy); // dotProduct(AB,BC) * dotProduct(AB,CA)
        
        float x = (a * x1 + b * x2 + c * x3) / (a + b + c);
        float y = (a * y1 + b * y2 + c * y3) / (a + b + c);
        Point p = new Point(x, y);
        return p;
    }
}