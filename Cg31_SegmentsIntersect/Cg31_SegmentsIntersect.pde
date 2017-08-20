LineWorker lineWorker;
Segment segment;

void setup()
{
    size(1000,1000); 
    lineWorker = new LineWorker();
    segment = new Segment(100, 200, 450, 550);
}

void draw()
{
    background(255); 
    stroke(0);
    lineWorker.render();
    
    if(segment.SegmentsIntersect(lineWorker.GetSegment()))
    {
        stroke(255,0,0);
    }
    segment.Render();
}

void mousePressed()
{
    lineWorker.receiveMouseInput();
}