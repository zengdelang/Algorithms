LineWorker lineWorker;

void setup()
{
    size(600,600); 
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