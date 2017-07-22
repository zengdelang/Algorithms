public class LineWorker
{
    private boolean recording;
    private int     startX;
    private int     startY;
    private int     endX;
    private int     endY;
    
    private LineAA lineAA;
    
    LineWorker()
    {
        lineAA = new LineAA();
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
            lineAA.drawSmoothLine(startX, startY, mouseX, mouseY, 255, 0, 0); 
            //line(startX, startY, mouseX, mouseY);
        }
        else
        {
            lineAA.drawSmoothLine(startX, startY, endX, endY, 255, 0, 0);
            //line(startX, startY, endX, endY);
        }
    }
}