public class CircleWorker
{
    public  int radius = 10;
    BresenhamCircle bresenhamCircle;
    
    CircleWorker()
    {
        bresenhamCircle = new BresenhamCircle();
    }
  
    void render()
    {
        bresenhamCircle.drawCircle(mouseX, mouseY, radius);
        //ellipse(mouseX, mouseY, radius * 2, radius * 2);
    }
}