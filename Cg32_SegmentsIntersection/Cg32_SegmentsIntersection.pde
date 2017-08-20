LineWorker lineWorker;
Segment segment;
CircleAnimation circle;

void setup()
{
    size(1000,1000); 
    lineWorker = new LineWorker();
    segment = new Segment(100, 200, 450, 550);
    circle = new CircleAnimation();
    circle.x = 100000;
    circle.y = 100000;
}

void draw()
{
    background(255); 
    stroke(0);
    lineWorker.render();
    
    Point p = segment.IntersectPoint(lineWorker.GetSegment());
    circle.x = 100000;
    circle.y = 100000;
    if(p != null)
    {
        stroke(255,0,0);
        circle.x = p.x;
        circle.y = p.y;
    }
    circle.Render();
    segment.Render();    
}

void mousePressed()
{
    lineWorker.receiveMouseInput();
}