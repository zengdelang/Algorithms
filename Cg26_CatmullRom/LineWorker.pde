public class LineWorker
{
    public int mode = 2;
    private CatmullRomIntInterpolation catmullRomIntInterpolation = new CatmullRomIntInterpolation();
    
    private ArrayList<Point> pointList = new ArrayList<Point>();
    private ArrayList<Point> curvePointList = new ArrayList<Point>();
    
    void receiveMouseInput()
    {
        pointList.add(new Point(mouseX, mouseY));
        if(pointList.size() > 1)
            catmullRomIntInterpolation.AddSplineCurvePoint(pointList, curvePointList);
    }
  
    void render()
    {
        stroke(0);
        if((mode == 0 || mode == 2))
        {
            for(int i = 0; i< pointList.size() -1; ++i)
            {
                line(pointList.get(i).x, pointList.get(i).y, pointList.get(i+1).x, pointList.get(i+1).y);
            }
        }
        
        stroke(0,255,0);
        if(curvePointList.size() > 0 && (mode == 1 || mode == 2))
        {
            for(int i = 0; i < curvePointList.size() - 1; ++i)
            {
                line(curvePointList.get(i).x, curvePointList.get(i).y, curvePointList.get(i+1).x, curvePointList.get(i+1).y);
            }
        }        
            
        stroke(0);
    }
}