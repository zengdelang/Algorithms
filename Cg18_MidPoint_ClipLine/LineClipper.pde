public class LineClipper
{
    public byte Left   = 1; // 0001
    public byte Right  = 2; // 0010
    public byte Bottom = 4; // 0100
    public byte Top    = 8; // 1000
    
    public LineInfo midClip(LineInfo line, float xMin, float yMin, float xMax, float yMax)
    {
        LineInfo lineInfo = new LineInfo(line); 
        byte regionCode1 = getRegionCode(lineInfo.x1, lineInfo.y1, xMin, yMin, xMax, yMax);
        byte regionCode2 = getRegionCode(lineInfo.x2, lineInfo.y2, xMin, yMin, xMax, yMax);
      
        if((regionCode1 | regionCode2) == 0)        //简取
        {
            return lineInfo;
        }
        else if((regionCode1 & regionCode2) != 0 )  //简弃
        {
            return null;
        }
        
        if(regionCode1 == 0)        //如果x1,y1在中间区域
        {
            MidPoint(lineInfo, lineInfo.x1, lineInfo.y1, lineInfo.x2, lineInfo.y2, xMin, yMin, xMax, yMax, true);
        }
        else if(regionCode2 == 0)   //如果x2,y2在中间区域
        {
            MidPoint(lineInfo, lineInfo.x2, lineInfo.y2, lineInfo.x1, lineInfo.y1, xMin, yMin, xMax, yMax, false);
        }
        else                       //两个点都不在中间区域
        {
            float midX = (lineInfo.x1 + lineInfo.x2) * 0.5;
            float midY = (lineInfo.y1 + lineInfo.y2) * 0.5;
            byte regionCode = getRegionCode(midX, midY, xMin, yMin, xMax, yMax);
            while(regionCode != 0)
            {
                if((regionCode1 & regionCode) == 0)
                {
                    lineInfo.x2 = midX;
                    lineInfo.y2 = midY;
                    regionCode2 = regionCode;
                }
                else
                {
                    lineInfo.x1 = midX;
                    lineInfo.y1 = midY;
                    regionCode1 = regionCode;
                }
                
                if((regionCode1 & regionCode2) != 0 )  //简弃
                {
                    return null;
                }
                
                midX = (lineInfo.x1 + lineInfo.x2) * 0.5;
                midY = (lineInfo.y1 + lineInfo.y2) * 0.5;
                regionCode = getRegionCode(midX, midY, xMin, yMin, xMax, yMax);
            }
            
            MidPoint(lineInfo,midX, midY, lineInfo.x1, lineInfo.y1, xMin, yMin, xMax, yMax, false);
            MidPoint(lineInfo,midX, midY, lineInfo.x2, lineInfo.y2, xMin, yMin, xMax, yMax, true);
        }
        return lineInfo;
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
    
    private void MidPoint(LineInfo line, float x1, float y1, float x2, float y2,float xMin, float yMin, float xMax, float yMax, boolean isX2)
    {
        //传入的x1,y1点是在裁剪区域中
        float midX = (x1 + x2) * 0.5;
        float midY = (y1 + y2) * 0.5;
        while(abs(midX - x1) > 1e-6 || abs(midY - y1) > 1e-6)
        {
            byte regionCode = getRegionCode(midX, midY, xMin, yMin, xMax, yMax);
            if(regionCode == 0)
            {
                x1 = midX;
                y1 = midY;
            }
            else
            {
                x2 = midX;
                y2 = midY;
            }
            midX = (x1 + x2) * 0.5;
            midY = (y1 + y2) * 0.5;
        }
        
        if(isX2)
        {
            line.x2 = midX;
            line.y2 = midY;
        }
        else
        {
            line.x1 = midX;
            line.y1 = midY;
        }
    }
}
