public class CircleAnimation
{
    public float x;
    public float y;
    
    public float w = 1;
    public float maxWidth = 10;
    
    public void Render()
    {  
        w += 0.2;
        if(w > maxWidth)
            w = 1;
        ellipse(x, y, w, w);
        fill(255,0,0);
        textSize(22);
        text("("+x+" , "+y+")",x + 6,y + 6);
    }
}