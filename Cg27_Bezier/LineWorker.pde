public class LineWorker
{
    private ArrayList<Point> pointList = new ArrayList<Point>();
    
    void receiveMouseInput()
    {
        pointList.add(new Point(mouseX, mouseY));
    }

    void render()
    {
        stroke(0);
        for(int i = 0; i< pointList.size() -1; ++i)
        {
            line(pointList.get(i).x, pointList.get(i).y, pointList.get(i+1).x, pointList.get(i+1).y);
        }
        
        stroke(255, 0, 0);
        bezierTool.DrawBezier(pointList);
    }
}