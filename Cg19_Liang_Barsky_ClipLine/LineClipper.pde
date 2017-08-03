public class LineClipper
{
    public LineInfo LiangBarskyClip(LineInfo line, float xMin, float yMin, float xMax, float yMax)
    {
        LineInfo lineInfo = new LineInfo(line); 
        float t1 = 0;
        float t2 = 1;
        float t  = 0;
        
        int[] p = new int[4];
        p[0] = (int)(lineInfo.x1 - lineInfo.x2);
        p[1] = (int)(lineInfo.x2 - lineInfo.x1);
        p[2] = (int)(lineInfo.y1 - lineInfo.y2);
        p[3] = (int)(lineInfo.y2 - lineInfo.y1);
            
        int[] q = new int[4];
        q[0] = (int)(lineInfo.x1 - xMin);
        q[1] = (int)(xMax - lineInfo.x1);
        q[2] = (int)(lineInfo.y1 - yMin);
        q[3] = (int)(yMax - lineInfo.y1);
        
        for(int i = 0; i < 4; ++i)
        {
            if(p[i] == 0 && p[i] < 0)
            {
                return null;
            }
            
            if(p[i] < 0)
            {
                t = (float)q[i] / p[i];
                t1 = max(t1, t);
                if(t1 > t2)
                {
                    return null;
                }
            }
            
            if(p[i] > 0)
            {
                t = (float)q[i] / p[i];
                t2 = min(t2, t);
                if(t1 > t2)
                {
                    return null;
                }
            }
        }

        lineInfo.x1 = line.x1 - t1 * p[0];
        lineInfo.y1 = line.y1 - t1 * p[2];
        lineInfo.x2 = line.x1 - t2 * p[0];
        lineInfo.y2 = line.y1 - t2 * p[2];
        return lineInfo;
    }    
}