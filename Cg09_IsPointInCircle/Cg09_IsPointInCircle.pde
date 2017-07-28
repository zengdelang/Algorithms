Circle circle;

void setup()
{
    size(1000, 1000);
    background(255);
    
    circle = new Circle(width/2, height/2, 250);
}

void draw()
{
    background(255);
    stroke(0);
    
    if(circle.IsPointInCircle(mouseX, mouseY))
    {
       stroke(255, 0, 0);  
    }
    circle.Render();
}