public class LineClipper
{
    public byte Left   = 1; // 0001
    public byte Right  = 2; // 0010
    public byte Bottom = 4; // 0100
    public byte Top    = 8; // 1000
    
    public LineInfo cohenClip(LineInfo line, float xMin, float yMin, float xMax, float yMax)
    {
        LineInfo lineInfo = new LineInfo(line); 
        byte regionCode1 = getRegionCode(lineInfo.x1, lineInfo.y1, xMin, yMin, xMax, yMax);
        byte regionCode2 = getRegionCode(lineInfo.x2, lineInfo.y2, xMin, yMin, xMax, yMax);

        while(true)
        {
            boolean change = false;                     
            if((regionCode1 | regionCode2) == 0)        //简取
            {
                return lineInfo;
            }
            else if((regionCode1 & regionCode2) != 0 )  //简弃
            {
                return null;
            }
            
            if(regionCode1 == 0)
            {
                //x1,y1点在区域内，交换两个端点和区域码
                float x = lineInfo.x1;
                float y = lineInfo.y1;
                
                lineInfo.x1= lineInfo.x2;
                lineInfo.y1= lineInfo.y2;
                lineInfo.x2= x;
                lineInfo.y2= y;
                    
                byte rc = regionCode1;
                regionCode1 = regionCode2;
                regionCode2 = rc;
           }
                
            if((regionCode1 & Left) > 0)
            {
                lineInfo.y1 = GetPointY(xMin, lineInfo.x1, lineInfo.y1, lineInfo.x2, lineInfo.y2);
                lineInfo.x1 = xMin;
                regionCode1 = getRegionCode(lineInfo.x1, lineInfo.y1, xMin, yMin, xMax, yMax);
                change = true;
            }
                
            if((regionCode1 & Right) > 0)
            {
                lineInfo.y1 = GetPointY(xMax, lineInfo.x1, lineInfo.y1, lineInfo.x2, lineInfo.y2);
                lineInfo.x1 = xMax;
                regionCode1 = getRegionCode(lineInfo.x1, lineInfo.y1, xMin, yMin, xMax, yMax);
                change = true;
            }
                
            if((regionCode1 & Bottom) > 0)
            {
                lineInfo.x1 = GetPointX(yMin, lineInfo.x1, lineInfo.y1, lineInfo.x2, lineInfo.y2);
                lineInfo.y1 = yMin;
                regionCode1 = getRegionCode(lineInfo.x1, lineInfo.y1, xMin, yMin, xMax, yMax);
                change = true;
            }
                
            if((regionCode1 & Top) > 0)
            {
                lineInfo.x1 = GetPointX(yMax, lineInfo.x1, lineInfo.y1, lineInfo.x2, lineInfo.y2);
                lineInfo.y1 = yMax;
                regionCode1 = getRegionCode(lineInfo.x1, lineInfo.y1, xMin, yMin, xMax, yMax);
                change = true;
            }
                
            if(!change)
                break;
        }
        
        return null;
    }
    
    public byte getRegionCode(float x, float y, float xMin, float yMin, float xMax, float yMax)
    {
        byte code = 0;
        
        if(x < xMin)
          code |= Left;
        
        if(x > xMax)
          code |= Right;
          
        if(y < yMin)
          code |= Bottom;
          
        if(y > yMax)
          code |= Top;
        
        return code;
    }
    
    private float GetPointY(float x, float x1, float y1, float x2, float y2)
    {
        float k = (y2 - y1) / (x2 - x1);
        return k*(x - x1) + y1;
    }
    
    private float GetPointX(float y, float x1, float y1, float x2, float y2)
    {
        if(x1 == x2)
        {
            return x1;
        }
        float k = (y2 - y1) / (x2 - x1);
        return (y - y1) / k + x1;
    }
}