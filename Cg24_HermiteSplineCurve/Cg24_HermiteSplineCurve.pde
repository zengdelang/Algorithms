Point[] points;           //存储型值点
Point[] tangentVectors;   //存储型值点的切向量

void setup()
{
    size(1000,1000); 
    
    points = new Point[9];
    points[0] = new Point(410, 532);
    points[1] = new Point(210, 386);
    points[2] = new Point(410, 316);
    points[3] = new Point(310, 162);
    points[4] = new Point(510, 50);
    points[5] = new Point(710, 162);
    points[6] = new Point(610, 316);
    points[7] = new Point(810, 386);
    points[8] = new Point(610, 532);
    
    tangentVectors = new Point[9];
    tangentVectors[0] = new Point(100, -100);
    tangentVectors[1] = new Point(100, -100);
    tangentVectors[2] = new Point(100, -100);
    tangentVectors[3] = new Point(100, -100);
    tangentVectors[4] = new Point(-100, -100);
    tangentVectors[5] = new Point(-100, 100);
    tangentVectors[6] = new Point(-100, 100);
    tangentVectors[7] = new Point(-100, 100);
    tangentVectors[8] = new Point(-100, -100);
}

void draw()
{
    background(255); 
    
    for(int i = 0; i < points.length - 1; ++i)
    {
        Hermite(int(abs(points[i+1].x - points[i].x)), points[i], points[i+1], tangentVectors[i], tangentVectors[i+1]);
    }
    
    noLoop();
}

//hermite插值生成曲线
//hermite插值方法缺点需要指定两个端点的一阶导数值
void Hermite(int n, Point p1, Point p2, Point r1, Point r2)
{
    float a, b, c, d;
    float delta = 1.0 / n; 
    float t = 0, t2 = 0, t3 =0;
    
    boolean draw = false;
    float x = 0,y = 0, _x = 0, _y = 0;
    
    for (int i = 0; i <= n; i++) 
    {
        t2 = t * t;
        t3 = t * t * t;
        
        a = 2 * t3 - 3 * t2 + 1; 
        b = -2 * t3 + 3 * t2; 
        c = t3 - 2 * t2 + t; 
        d = t3 - t2; 
            
        if(!draw)
        {
            draw = true;
            x = a * p1.x + b * p2.x + c * r1.x + d * r2.x;
            y = a * p1.y + b * p2.y + c * r1.y + d * r2.y;
        }
        else
        {
            _x = a * p1.x + b * p2.x + c * r1.x + d * r2.x;
            _y = a * p1.y + b * p2.y + c * r1.y + d * r2.y;
            
            line(x, y, _x, _y);
            
            x = _x;
            y = _y;
        }
        
        t += delta;
    } 
}