EllipseWorker ellipseWorker;

void setup()
{
    size(600,600); 
    ellipseWorker = new EllipseWorker();
    ellipseWorker.a = 100;
    ellipseWorker.b = 56;
}

void draw()
{
    background(255); 
    ellipseWorker.render();
}