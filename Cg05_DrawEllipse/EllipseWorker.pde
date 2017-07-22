public class EllipseWorker
{
    public int a;
    public int b;
    BresenhamEllipse bresenhamEllipse;
    
    EllipseWorker()
    {
        bresenhamEllipse = new BresenhamEllipse();
    }
  
    void render()
    {
        bresenhamEllipse.drawEllipse(mouseX, mouseY, a, b);
    }
}