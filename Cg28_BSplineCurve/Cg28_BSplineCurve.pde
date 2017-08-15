BSplineCurveTool bSplineCurveTool;
ArrayList<Point> bSpline2;
ArrayList<Point> bSpline3;

void setup()
{
    size(1500,1000); 
 
    bSplineCurveTool = new BSplineCurveTool();
    
    bSpline2 = new ArrayList<Point>();
    bSpline2.add(new Point(85, 215));
    bSpline2.add(new Point(217, 52));
    bSpline2.add(new Point(419,124));
    
    bSpline3 = new ArrayList<Point>();
    bSpline3.add(new Point(90, 392));
    bSpline3.add(new Point(211,226));
    bSpline3.add(new Point(346,295));
    bSpline3.add(new Point(616,296));
}

void draw()
{
    background(255); 
    
    stroke(0);
    for(int i = 0; i< bSpline2.size() -1; ++i)
    {
        line(bSpline2.get(i).x, bSpline2.get(i).y, bSpline2.get(i+1).x, bSpline2.get(i+1).y);
    }
    stroke(255,0,0);
    bSplineCurveTool.DrawBSplineCurve(bSpline2.get(0), bSpline2.get(1), bSpline2.get(2));

    stroke(0);
    for(int i = 0; i< bSpline3.size() -1; ++i)
    {
        line(bSpline3.get(i).x, bSpline3.get(i).y, bSpline3.get(i+1).x, bSpline3.get(i+1).y);
    }    
    stroke(255,0,0);
    bSplineCurveTool.DrawBSplineCurve3(bSpline3.get(0), bSpline3.get(1), bSpline3.get(2), bSpline3.get(3));
}