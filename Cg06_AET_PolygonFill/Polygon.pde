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
    public double k;         //边的斜率的倒数
    
    public Edge nextEdge; //下一条边
    
    public Edge()
    {
       
    }
    
    public Edge(double _x, int _yMax, double _k)
    {
        x    = _x;
        yMax = _yMax;
        k    =_k;
    }
}

/*
   扫描线对应的桶
*/
public class Bucket
{
    public int    scanLine;  //对应的扫描线
    public Edge   firstEdge;
    public Bucket nextBucket;
    
    public Bucket(int _scanLine, Edge edge)
    {
        scanLine = _scanLine;
        firstEdge = edge;
    }
    
    public Bucket()
    {
      
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
    
    private Bucket CreateBuckets()
    {
        //创建扫描线的桶链表的头结点
        Bucket buckets = new Bucket();  
        
        //遍历所有多边形的点
        int lastPointIndex = points.length -1;
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
          
            Edge edge = new Edge(lowPoint.x, highPoint.y, (highPoint.x - lowPoint.x)/(double)(highPoint.y - lowPoint.y));
            AddEdgeToBucket(buckets, edge, lowPoint.y);
        }
        return buckets;
    }
    
    //使用插入排序创建桶
    private void AddEdgeToBucket(Bucket buckets, Edge edge, int scanLine)
    {
        Bucket prevBucket = buckets;
        Bucket curBucket  = buckets.nextBucket;
        while(curBucket != null)
        {
            //扫描线和桶的扫描线相同
            if(curBucket.scanLine == scanLine)
            {
                edge.nextEdge = curBucket.firstEdge;
                curBucket.firstEdge = edge;
                return;
            }
            else if(scanLine < curBucket.scanLine)  //如果新边的x比当前边小，插入到当前边之前
            {
                break;
            }

            prevBucket = curBucket;
            curBucket  = curBucket.nextBucket;
       }
                
       Bucket tempBucket = new Bucket(scanLine,edge);
       tempBucket.nextBucket = prevBucket.nextBucket;
       prevBucket.nextBucket = tempBucket;
    }
    
    //添加有效活动边到有效活动边表中
    private void AddActiveEdgeToET(Edge headNode, Edge newEdge)
    {   
        //使用插入排序，先按照边的x从小到大排序，如果x相同，再按照k的从小到大排序
        //headNode的有效边表已经是有序的
        while(newEdge != null)
        {
            Edge prevEdge = headNode;
            Edge curEdge  = headNode.nextEdge;
            while(curEdge != null)
            {
                //如果两条边的x相同
                if(newEdge.x == curEdge.x)
                {
                    if(newEdge.k <= curEdge.k)
                    {
                        break;
                    }
                }
                else if(newEdge.x < curEdge.x)  //如果新边的x比当前边小，插入到当前边之前
                {
                    break;
                }

                prevEdge = curEdge;
                curEdge = curEdge.nextEdge;
            }
                
            Edge tempEdge = newEdge;
            newEdge = newEdge.nextEdge;
            tempEdge.nextEdge = prevEdge.nextEdge;
            prevEdge.nextEdge = tempEdge;
        }
    }
    
    //刷新有效活动边表，删除非活动边，递增x
    private void RefreshAET(Edge headNode, int yMax)
    {
        Edge prevEdge = headNode;
        Edge curEdge  = headNode.nextEdge;
      
        while(curEdge != null)
        {
            if(curEdge.yMax == yMax)
            {
                prevEdge.nextEdge = curEdge.nextEdge;
            }
            else
            {
                curEdge.x += curEdge.k;    
                prevEdge = curEdge;
            }
            curEdge = curEdge.nextEdge;
        }
    }
    
    //使用有效边表填充算法填充多边形
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
            第二步 根据扫描线来创建扫描线的边表桶
        */
        Bucket buckets = CreateBuckets();
        
        /*
            第三步 从下到上遍历所有扫描线
        */
        Edge headNode = new Edge();       //生成有效边表的头结点
        buckets = buckets.nextBucket;     //获取边表桶的首元结点
        stroke(255,0,0);                  //设置填充颜色
        for(int y = yMin; y <= yMax; ++y)
        {
            if(buckets != null && buckets.scanLine == y)
            {
                AddActiveEdgeToET(headNode, buckets.firstEdge);
                buckets = buckets.nextBucket;
            }
            
            boolean fillNow = false;         //是否立刻填充像素点
            double startX = 0, endX = 0;     //待填充的起点和终点
            Edge curEdge = headNode.nextEdge;
            while(curEdge != null)
            {
                if(fillNow)
                {
                    endX = curEdge.x - 1; //左闭右开
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
                    startX = curEdge.x;
                }
                
                fillNow = !fillNow;
                curEdge = curEdge.nextEdge;
            }
            
            //根据下闭上开原则，将yMax == y + 1的边去除
            RefreshAET(headNode, y + 1);
        }
    }
}
