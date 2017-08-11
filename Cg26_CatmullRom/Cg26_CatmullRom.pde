LineWorker lineWorker;

void setup()
{
    size(1000,1000); 
    lineWorker = new LineWorker();
    //frameRate(4);
}

void draw()
{
    background(255); 
    lineWorker.receiveMouseInput(); 
    lineWorker.render();
    
 
}

void keyPressed()
{
    if (keyPressed) 
    {
        if(key == 'M' || key == 'm')
        {
            lineWorker.mode = (++lineWorker.mode) % 3; 
        }
    } 
}