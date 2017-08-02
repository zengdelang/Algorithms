public class LineInfo
{
    public float x1;
    public float y1;
    public float x2;
    public float y2;
    
    public LineInfo(LineInfo lineInfo)
    {
        x1 = lineInfo.x1;
        y1 = lineInfo.y1;
        x2 = lineInfo.x2;
        y2 = lineInfo.y2;
    }
    
    public LineInfo(float _x1, float _y1, float _x2, float _y2)
    {
        x1 = _x1;
        y1 = _y1;
        x2 = _x2;
        y2 = _y2;
    }
}

public class LineWorker
{
    private boolean recording;
    private int     startX;
    private int     startY;
    private int     endX;
    private int     endY;
    
    private ArrayList<LineInfo> lineList = new ArrayList<LineInfo>();
    private LineClipper lineClipper = new LineClipper();
     
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
            
            lineList.add(new LineInfo(startX, startY, endX, endY));
        }
    }
  
    void render(boolean clip, int xMin, int yMin, int xMax, int yMax)
    {
        if(recording)
        {
            line(startX, startY, mouseX, mouseY);
        }
        
        for(int i = 0; i < lineList.size(); ++i)
        {
            LineInfo lf = lineList.get(i);
            
            if(clip)
            {
                lf = lineClipper.midClip(lf, xMin, yMin, xMax, yMax);
            }
            
            if(lf != null)
              line(lf.x1, lf.y1, lf.x2, lf.y2);
        }
    }
    
    void clear()
    {
        lineList.clear();
    }
}