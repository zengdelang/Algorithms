public class LineWorker
{
    private boolean recording;
    private int     startX;
    private int     startY;
    private int     endX;
    private int     endY;
    
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
            line(startX, startY, mouseX, mouseY);
        }
        else
        {
            line(startX, startY, endX, endY);
        }
    }
    
    public Segment GetSegment()
    {
        if(recording)
        {
            return new Segment(startX, startY, mouseX, mouseY);
        }
        else
        {
            return new Segment(startX, startY, endX, endY);
        }
    }
}