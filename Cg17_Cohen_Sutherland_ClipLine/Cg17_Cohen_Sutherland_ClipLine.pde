LineWorker lineWorker;
boolean clip = false;

void setup()
{
    size(1000,1000); 
    lineWorker = new LineWorker();
}

void draw()
{
    background(255); 
        
    fill(0, 102, 153, 204);
    textSize(32);
    text("Press P to clip", 0, 32);
    text("Press C to clear", 0, 64);
    
    noFill();
    rect(200,300,600,300);
    lineWorker.render(clip, 200, 300, 800, 600);
}

void mousePressed()
{
    lineWorker.receiveMouseInput();
}

void keyPressed()
{
    if (keyPressed) 
    {
        if (key == 'P' || key == 'p') 
        {
            clip = !clip;
        }       
        
        if (key == 'C' || key == 'c')
        {
            lineWorker.clear();
        }
    } 
}