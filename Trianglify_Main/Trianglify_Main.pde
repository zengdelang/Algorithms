
ArrayList<PVector> Points = new ArrayList<PVector>();
float rectWidth = 200;
float rectHeight = 200;

void setup()
{
    size(600,600); 
    
    GridPointGenerator pointsGenerator = new GridPointGenerator();
    pointsGenerator.GenerateGridPoints(Points, rectWidth, rectHeight, 75, 0);
}

void draw()
{
    background(200); 
    
    float xOffset = (width - rectWidth) * 0.5;
    float yOffset = (height - rectHeight) * 0.5;
    
    //noStroke();
    
    rect(xOffset, yOffset, rectWidth, rectHeight);
    
    //stroke(204, 102, 0);
    for (int i = 0; i < Points.size(); i++) 
    {
        PVector pointVector = Points.get(i);
        point(xOffset + pointVector.x, yOffset + pointVector.y);
    }
}
