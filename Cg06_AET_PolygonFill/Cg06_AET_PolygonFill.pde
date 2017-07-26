//有效边表多边形填充算法填充多边形
Polygon polygon;
int scale = 1;

void setup()
{
    size(600, 600);
    background(255);
    
    Point[] points = new Point[7];
    points[0] = new Point(7*scale,8*scale);
    points[1] = new Point(3*scale,12*scale);
    points[2] = new Point(1*scale,7*scale);
    points[3] = new Point(3*scale,1*scale);
    points[4] = new Point(6*scale,5*scale);
    points[5] = new Point(8*scale,1*scale);
    points[6] = new Point(12*scale,9*scale);
    
    polygon = new Polygon(points);
}

void draw()
{
    polygon.render();
    polygon.FillPolygon();
    noLoop();
}