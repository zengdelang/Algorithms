int scale = 30;

Polygon polygon;
Polygon polygon1;

void setup()
{
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
    polygon.Render();
    polygon.ShowBoundingBox();
   
    stroke(0);
    polygon1.Render();
    polygon1.ShowBoundingBox();
  
    noLoop();
}