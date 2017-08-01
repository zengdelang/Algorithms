int scale = 60;
boolean fillDir4 = false;
boolean fillDir8 = false;
Polygon polygon;

void setup()
{
    //窗口的尺寸不要修改，Polygon内部填充算法现在是使用写死的窗口大小来写的算法
    //如果改了这里，内部算法的参数也要修改
    size(1000, 1000);
    background(255);
    smooth(0);  //不要平滑，不然线的颜色达不到纯黑色
    
    Point[] points = new Point[8];
    points[0] = new Point(2*scale,2*scale);
    points[1] = new Point(2*scale,421);
    points[2] = new Point(479,421);
    points[3] = new Point(479,11*scale);
    points[4] = new Point(11*scale,11*scale);
    points[5] = new Point(11*scale,7*scale);
    points[6] = new Point(8*scale,7*scale);
    points[7] = new Point(8*scale,2*scale);
    polygon = new Polygon(points);
}

void draw()
{
    background(255);

    fill(0, 102, 153, 204);
    textSize(32);
    text("Press R to reset", 0, 32);
    text("Press F to fill Polygon with 4 direction", 0, 64);
    text("Press G to fill Polygon with 8 direction", 0, 96);
    
    stroke(0);
    polygon.Render();
    
    stroke(255,0,0);
    for(int i =4*scale; i<6*scale; ++i)
    {
        for(int j= 4*scale; j<6*scale; ++j)
        {
            point(i,j);
        }
    }
    
    if(fillDir4)
    {
        polygon.FillPolygon(181,265, color(0, 0, 0), color(122, 222, 255), false);
    }
    
    if(fillDir8)
    {
        polygon.FillPolygon(181,265, color(0, 0, 0), color(122, 222, 255), true);
    }
}

void keyPressed()
{
    if (keyPressed) 
    {
        if (key == 'R' || key == 'r') 
        {
            fillDir4 = false;
            fillDir8 = false;
        }
        
        if (key == 'F' || key == 'f') 
        {
            fillDir4 = true;
            fillDir8 = false;
        }
        
        if (key == 'G' || key == 'g') 
        {
            fillDir4 = false;
            fillDir8 = true;
        }
    } 
}