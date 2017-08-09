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
    
    public int mode;
    
    private ArrayList<LineInfo> lineList = new ArrayList<LineInfo>();
    private CubicSplineCurve cubicSplineCurve = new CubicSplineCurve();
    
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
            endX = mouseX;
            endY = mouseY;
            lineList.add(new LineInfo(startX, startY, endX, endY));
            
            startX = mouseX;
            startY = mouseY;
        }
    }
  
    void render()
    {
        if(recording)
        {
            line(startX, startY, mouseX, mouseY);
        }
        
        stroke(0);
        for(int i = 0; i < lineList.size(); ++i)
        {
            LineInfo lf = lineList.get(i);
            line(lf.x1, lf.y1, lf.x2, lf.y2);
        }
        
        stroke(255,0,0);
        if(lineList.size() > 0)
            cubicSplineCurve.DrawCubicSplineCurve(GetLinePoints(), mode);
            
        stroke(0);
    }
    
    void clear()
    {
        lineList.clear();
        recording = false;
    }
    
    Point[] GetLinePoints()
    {
        Point[] points = new Point[lineList.size()+1];
        points[0] = new Point(lineList.get(0).x1, lineList.get(0).y1);
        
        for(int i = 0; i < lineList.size(); ++i)
        {
            points[i+1] = new Point(lineList.get(i).x2, lineList.get(i).y2);
        }
        return points;
    }
}