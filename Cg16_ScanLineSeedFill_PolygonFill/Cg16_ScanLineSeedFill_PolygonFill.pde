int scale = 60;
Polygon polygon;

void setup()
{
    //窗口的尺寸不要修改，Polygon内部填充算法现在是使用写死的窗口大小来写的算法
    //如果改了这里，内部算法的参数也要修改
    size(1000, 1000);
    background(255);
    smooth(0);  //不要平滑，不然线的颜色达不到纯黑色
    
    
    //改造图形显示
    
    Point[] points = new Point[16];
    points[0] = new Point(2*scale,2*scale);
    points[1] = new Point(2*scale,421);
    points[2] = new Point(420,421);
    points[3] = new Point(420,11*scale);
    points[4] = new Point(11*scale,11*scale);
    points[5] = new Point(11*scale,7*scale);
    points[6] = new Point(8*scale,7*scale);
    points[7] = new Point(8*scale,2*scale);
    points[8] = new Point(7*scale,2*scale);
    points[9] = new Point(7*scale,3*scale);
    points[10] = new Point(6*scale,3*scale);
    points[11] = new Point(6*scale,2*scale);
    points[12] = new Point(4*scale,2*scale);
    points[13] = new Point(4*scale,3*scale);
    points[14] = new Point(3*scale,3*scale);
    points[15] = new Point(3*scale,2*scale);
    polygon = new Polygon(points);
}

void draw()
{
    background(255);
    
    stroke(0);
    polygon.Render();
    
    polygon.FillPolygon(181,265, color(0, 0, 0), color(122, 222, 255));
    
    noLoop();
}