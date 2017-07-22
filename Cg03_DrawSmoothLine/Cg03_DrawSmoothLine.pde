LineWorker lineWorker;

void setup()
{
    size(1000,1000); 
    lineWorker = new LineWorker();
}

void draw()
{
    background(255); 
    lineWorker.render();
}

void mousePressed()
{
    lineWorker.receiveMouseInput();
}