int scale = 30;

Polygon polygon;
Polygon polygon1;

void setup()
{
    //窗口的尺寸不要修改，Polygon内部填充算法现在是使用写死的窗口大小来写的算法
    //如果改了这里，内部算法的参数也要修改
    size(1000, 1000);
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
    
    points = new Point[6];
    points[0] = new Point(15*scale,15*scale);
    points[1] = new Point(3*scale,25*scale);
    points[2] = new Point(20*scale,25*scale);
    points[3] = new Point(15*scale,15*scale);
    points[4] = new Point(30*scale,25*scale);
    points[5] = new Point(30*scale,15*scale);
    polygon1 = new Polygon(points);
}

void draw()
{
    stroke(0);
    polygon.FillPolygon();
    polygon.Render();
   
    stroke(0);
    polygon1.FillPolygon();
    polygon1.Render();
  
    noLoop();
}