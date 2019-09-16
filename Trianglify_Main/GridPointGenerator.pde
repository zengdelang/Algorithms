public class GridPointGenerator
{

    // variance = [0, 1]
    void GenerateGridPoints(ArrayList<PVector> Points,float ViewportWidth, float ViewportHeight, float CellSize, float Variance)
    {
        // if cellSize <= 0 
        
        // variance = [0, 1]
        
        // 计算x轴方向需要的格子数,在外围再填充4个格子,用于弥补网格点随机带来的空缺
        float Cells_X = floor(ViewportWidth / CellSize) + 4;
        float Cells_Y = floor(ViewportHeight / CellSize) + 4;
        
        float Bleed_X = (Cells_X * CellSize - ViewportWidth) * 0.5;
        float Bleed_Y = (Cells_Y * CellSize - ViewportHeight) * 0.5;
        
        Variance = CellSize * Variance * 0.5;
        
        float FinalWidth = ViewportWidth + Bleed_X;
        float FinalHeight = ViewportHeight + Bleed_Y;
        float HalfCellSize = CellSize * 0.5;
        //float DoubleV = Variance * 0.5;
        //float NegativeV = - Variance;
        
        Points.clear();
        
        for (float i = -Bleed_X; i < FinalWidth; i += CellSize)
        {
            for (float j = -Bleed_Y; j < FinalHeight; j += CellSize)
            {
                float X = i + HalfCellSize;
                float Y = j + HalfCellSize;
                Points.add(new PVector(X, Y));
            }
        }
    }
}
