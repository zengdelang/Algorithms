public class Point
{
    public int x;
    public int y;
    
    public Point(int _x, int _y)
    {
        x = _x;
        y = _y;
    }
}
 
/*
   多边形的有效边
*/
public class Edge
{
    public double x;         //活动边最小y坐标的顶点的x坐标
    public int    yMax;      //边的最大y坐标
    public int    yMin;      //边的最小y坐标
    public double k;         //边的斜率的倒数
    
    public Edge(double _x, int _yMax, int _yMin, double _k)
    {
        x    = _x;
        yMax = _yMax;
        yMin = _yMin;
        k    = _k;
    }
}

/*
    多边形的边表，有效边表使用指针包含在边表中
*/
public class EdgeTable
{
    public Edge[] edges;  //边表的边集合
    public int    first;  //有效边表的起始指针
    public int    last;   //有效边表的结束指针
    
    public EdgeTable(int edgeNum)
    {
        edges = new Edge[edgeNum];
    }
    
    //添加新边到边表中
    public void AddNewEdge(int curEdgeNum, Edge edge)
    {
        //添加新边到边表中，使用插入排序按yMin从小到大排序
        int index = curEdgeNum;
        for(int i = 0; i < curEdgeNum; ++i)
        {
            if(edge.yMin < edges[i].yMin)
            {
                index = i;
                for(int j = curEdgeNum; j > i; --j)
                {  
                    edges[j] = edges[j - 1];
                }
                break;
            }
        }
        edges[index] = edge;
    }
    
    //更新last指针
    public void UpdateLastPtr(int curScanLine)
    {
        boolean isChange = false;
        for(int i = last + 1; i < edges.length; ++i)
        {
            //边可能是空的，因为水平边会被剔除
            //如果yMin小于等于当前的扫描线，将该边加入到有效边表中(即修改last指针)
            if((edges[i] == null) || (edges[i].yMin > curScanLine))
            {
                break;
            }
            ++last;
            isChange = true;
        }
        
        if(isChange)
        {
            //排序有效边表区域
            SortActiveEdges();
        }
    }
    
    private void SortActiveEdges()
    {
        //使用插入排序先按照边的x从小到大排序，相同x的再按照k从小到大排序
        for(int i = first + 1; i <= last; ++i)
        {
            int index = first;
            for(int j = i - 1; j >= first; --j)
            {
                if((edges[i].x > edges[j].x) || ((edges[i].x == edges[j].x) && (edges[i].k > edges[j].k)))
                {
                    index = j + 1;
                    break;
                }
            }
            
            Edge edge = edges[i];
            for(int k = i; k > index; --k)
            {
                edges[k] = edges[k-1];
            }
            edges[index] = edge;      
        }
    }
    
    //刷新有效边表
    public void RefreshAET(int nextScanLine)
    {
        boolean isChange = false;
        for(int i = first; i <= last; ++i)
        {
            //根据下闭上开原则剔除无效边，交换到first指针处，然后first加1
            if(edges[i].yMax == nextScanLine)
            {
                Edge edge = edges[i];
                edges[i] = edges[first];
                edges[first] = edge;
                isChange = true;
                ++first;
            }
            else
            {
                //修改边和下一条扫描线的x交点坐标
                edges[i].x += edges[i].k;    
            }
        }
        
        if(isChange)
        {
            //排序有效边表区域
            SortActiveEdges();
        }
    }
}

public class Polygon
{
    private Point[] points;
    
    public Polygon(Point[] _points)
    {
        points = _points;
    }
    
    public void Render()
    {
        int lastPoint = points.length -1;
        for(int i = 0; i < points.length; ++i)
        {
            line(points[lastPoint].x, points[lastPoint].y ,points[i].x, points[i].y);
            lastPoint = i;
        }
    }
    
    //创建边表
    private EdgeTable CreateEdgeTables()
    {
        EdgeTable edgeTable = new EdgeTable(points.length);
        
        //遍历所有多边形的点
        int lastPointIndex = points.length -1;
        int curEdgeNum = 0;
        for(int i = 0; i < points.length; ++i)
        {
            Point lastPoint = points[lastPointIndex];
            lastPointIndex = i;
            //水平边和扫描线有很多交点，故当作扫描线忽略不加入边表
            if(lastPoint.y == points[i].y)
            {
                continue;
            }
            
            Point highPoint = lastPoint.y > points[i].y ? lastPoint : points[i];  //y坐标更大的点
            Point lowPoint  = lastPoint.y > points[i].y ? points[i] : lastPoint;  //y坐标更小的点
          
            Edge edge = new Edge(lowPoint.x, highPoint.y, lowPoint.y, (highPoint.x - lowPoint.x)/(double)(highPoint.y - lowPoint.y));
            edgeTable.AddNewEdge(curEdgeNum, edge);
            ++curEdgeNum;
        }
        
        return edgeTable;
    }
    
    //使用有效边表填充算法的改进算法填充多边形
    //如果多边形有边缘线且边缘线颜色和填充色不同，则应该在填充后重新绘制边缘，因为填充过程会有部分边缘也被填充的可能
    public void FillPolygon()
    {
        /*
            第一步 获取多边形所有顶点的最小y值和最大y值
        */
        int yMin, yMax;
        yMin = yMax = points[0].y;
        for(int i = 1; i < points.length; ++i)
        {
            int y = points[i].y;
            if(y < yMin)
            {
                yMin = y;
            }
            if(y > yMax)
            {
                yMax = y;
            }
        }
        
        /*
            第二步 创建边表
        */
        EdgeTable edgeTable = CreateEdgeTables();
        
        /*
            第三步 从下到上遍历所有扫描线
        */
        stroke(255,0,0);                  //设置填充颜色
        for(int y = yMin; y <= yMax; ++y)
        {
            edgeTable.UpdateLastPtr(y);
            
            boolean fillNow = false;         //是否立刻填充像素点
            double startX = 0, endX = 0;     //待填充的起点和终点
            for(int i = edgeTable.first; i <= edgeTable.last; ++i)
            {
                if(fillNow)
                {
                    endX = edgeTable.edges[i].x - 1; //左闭右开
                    if(startX < endX)
                        line((float)startX, (float)(y),(float)endX,(float)(y));
                    /*//使用point一个一个设置像素，效率较低
                    for(double x = startX; x <= endX; ++x)
                    {
                        //四舍五入x
                        point((int)(x + 0.5), y);
                    }*/
                }
                else
                {
                    startX = edgeTable.edges[i].x;
                }
                
                fillNow = !fillNow;
            }
            
            //根据下闭上开原则，将yMax == y + 1的边去除
            edgeTable.RefreshAET(y + 1);
        }
    }
}