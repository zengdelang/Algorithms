Line line;

void setup()
{
    size(1000, 1000);
    line = new Line(100,100, 800,800);
}

void draw()
{
    background(255);
    
    stroke(0);
    if(line.IsPointInLine(mouseX, mouseY))
    {
        stroke(255,0,0);
    }
    line.Render();
}
