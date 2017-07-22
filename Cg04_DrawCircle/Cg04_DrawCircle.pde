CircleWorker circleWorker;

void setup()
{
    size(600,600); 
    circleWorker = new CircleWorker();
    circleWorker.radius = 100;
}

void draw()
{
    background(255); 
    circleWorker.render();
}