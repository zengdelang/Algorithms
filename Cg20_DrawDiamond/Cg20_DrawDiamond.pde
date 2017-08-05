int radius = 300; //圆的半径
int n =  30;      //圆周被分成的等分点的数目
Point[] points;

void setup()
{
    size(1000,1000); 
    points = new Point[n];
    
    float deltaAngle = 2 * PI / n;
    for(int i = 0; i < n; ++i)
    {
        points[i] = new Point(radius * cos(deltaAngle * i), radius * sin(deltaAngle * i));
    }
}

void draw()
{
    background(255); 
    
    translate(width/2, height/2);
    for(int i = 0; i < n -1; ++i) //最后一个点不需要处理，别的点都会连接最后一个点
    {
        for(int j = i + 1; j < n; ++j)
        {
            line(points[i].x, points[i].y, points[j].x, points[j].y);
        }
    }
}