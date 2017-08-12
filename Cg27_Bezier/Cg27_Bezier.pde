LineWorker lineWorker;
BezierTool bezierTool;

ArrayList<Point> bezier2;
ArrayList<Point> bezier3;

void setup()
{
    size(1500,1000); 
 
    lineWorker = new LineWorker();
    bezierTool = new BezierTool();
    
    bezier2 = new ArrayList<Point>();
    bezier2.add(new Point(85, 215));
    bezier2.add(new Point(217, 52));
    bezier2.add(new Point(419,124));
    
    bezier3 = new ArrayList<Point>();
    bezier3.add(new Point(90, 392));
    bezier3.add(new Point(211,226));
    bezier3.add(new Point(346,295));
    bezier3.add(new Point(616,296));
}

void draw()
{
    background(255); 
    
    stroke(0);
    for(int i = 0; i< bezier2.size() -1; ++i)
    {
        line(bezier2.get(i).x, bezier2.get(i).y, bezier2.get(i+1).x, bezier2.get(i+1).y);
    }
    stroke(255,0,0);
    bezierTool.DrawBezier2(bezier2.get(0), bezier2.get(1), bezier2.get(2));

    stroke(0);
    for(int i = 0; i< bezier3.size() -1; ++i)
    {
        line(bezier3.get(i).x, bezier3.get(i).y, bezier3.get(i+1).x, bezier3.get(i+1).y);
    }    
    stroke(255,0,0);
    bezierTool.DrawBezier3(bezier3.get(0), bezier3.get(1), bezier3.get(2), bezier3.get(3));
    
    lineWorker.render();
}

void mousePressed()
{
    lineWorker.receiveMouseInput(); 
}