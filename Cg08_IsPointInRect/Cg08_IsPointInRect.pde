int scale = 20;

Rect rect;
Rect rect1;
Rect rect2;

void setup()
{
    size(1000, 1000);
    background(255);
    
    rect = new Rect(10*scale, 30*scale,20*scale, 20*scale, 0);//-PI/6);
    rect1 = new Rect(25*scale, 30*scale,35*scale, 20*scale, 0);//-PI/6);
    rect2 = new Rect(10*scale, 30*scale,20*scale, 20*scale, -PI/4);
}

void draw()
{
    background(255);
    stroke(0);
    if(rect.IsPointInRect(mouseX, mouseY))
    {
        stroke(0,255,0);
    }
    rect.Render();
    
    stroke(0);
    if(rect1.IsPointInRect1(mouseX, mouseY))
    {
        stroke(0,0,255);
    }
    rect1.Render();
    
    stroke(0);
    if(rect2.IsPointInRect2(mouseX, mouseY))
    {
        stroke(0,255,255);
    }
    rect2.Render();
    rect2.ShowBoundingBox();
}