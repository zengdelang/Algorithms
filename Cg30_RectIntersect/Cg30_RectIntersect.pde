Rect rect;
Rect rect1;

void setup()
{
    size(1000, 1000);

    rect = new Rect(300,400,600,800, false);
    rect1 = new Rect(200, 200, 700, 800, true);
}

void draw()
{
    background(255);
    stroke(0);
    
    rect1.Render();
    
    stroke(0);
    if(rect.Intersect(rect1))
    {
        stroke(255, 0, 0);
    }
    rect.Render();
}