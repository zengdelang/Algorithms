public class LineWorker
{
    private boolean recording;
    private int     startX;
    private int     startY;
    private int     endX;
    private int     endY;
    
    private BresenhamLine bresenhamLine;
    
    LineWorker()
    {
        bresenhamLine = new BresenhamLine();
    }
  
    void receiveMouseInput()
    {
        if(!recording)
        {
            recording = true;
            startX = mouseX;
            startY = mouseY;
        }
        else
        {
            recording = false;
            endX = mouseX;
            endY = mouseY;
        }
    }
  
    void render()
    {
        if(recording)
        {
            bresenhamLine.drawLine(startX, startY, mouseX, mouseY);
        }
        else
        {
            bresenhamLine.drawLine(startX, startY, endX, endY);
        }
    }
}