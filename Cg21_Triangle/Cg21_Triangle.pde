Triangle triangle;
LineWorker lineWorker;

void setup()
{
    size(1000,1000); 
    triangle = new Triangle(random(width/4, width*3/4), random(height/4, height*3/4), random(width/4, width*3/4), random(height/4, height*3/4), random(width/4, width*3/4), random(height/4, height*3/4));
    lineWorker = new LineWorker();
}

void draw()
{
    background(255); 
    triangle.Render();
    lineWorker.render();
}

void mousePressed()
{
    if(triangle.mode == 4)
    {
        lineWorker.receiveMouseInput();   
    }
}

void keyPressed()
{
    if (keyPressed) 
    {
        if (key == 'C' || key == 'c')
        {
            lineWorker.clear();
        }
        
        if(key == 'M' || key == 'm')
        {
            triangle.mode = (++triangle.mode) % 5;        
        }
    } 
}
