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

public class Polygon
{
    private Point[] points;
    
    public Polygon(Point[] _points)
    {
        points = _points;
    }
    
    public void render()
    {
        for(int i = 0; i < points.length; ++i)
        {
            Point nextPoints = points[(i + 1) % points.length];
            line(points[i].x, points[i].y, nextPoints.x, nextPoints.y);
        }
    }
    
    /*
        创造扫描线的桶
    */
    private ScanLineBucket[] CreateBuckets(int yMin, int yMax)
    {
        ScanLineBucket[] buckets = new ScanLineBucket[yMax - yMin+1];     
        for(int i = 0; i < buckets.length; ++i)
        {
            buckets[i] = new ScanLineBucket(i);
        }
        println(buckets.length);
        return buckets;
    }
    
    private void CreateScanLineEdgeTable(ScanLineBucket[] buckets, int yMin)
    {
        for(int i = 0; i < points.length; ++i)
        {
            Point nextPoints = points[(i + 1) % points.length];
            //水平边和扫描线有很多交点，故当作扫描线忽略不加入边表
            if(nextPoints.y == points[i].y)
            {
                continue;
            }
            
            Point highPoint = nextPoints.y > points[i].y ? nextPoints : points[i];  //y坐标更大的点
            Point lowPoint  = nextPoints.y > points[i].y ? points[i] : nextPoints;  //y坐标更小的点
          
            int scanLine = lowPoint.y - yMin;
            PolygonEdge edge = new PolygonEdge(lowPoint.x, highPoint.y, (highPoint.x - lowPoint.x)/(double)(highPoint.y - lowPoint.y));
            edge.nextEdge = buckets[scanLine].firstEdge;
            buckets[scanLine].firstEdge = edge;
        }
/*        
        PolygonEdge e = buckets[0].firstEdge;
        while(e != null)
        {
           println(e.x +" ====  "+e.k);
           e = e.nextEdge;
        }*/
    }
    
    //添加有效活动边到有效活动边表中
    private void AddActiveEdgeToET(PolygonEdge headNode, PolygonEdge newEdge)
    {      
        //使用插入排序，先按照边的x从小到大排序，如果x相同，再按照k的从小到大排序
        //headNode的有效边表已经是有序的
        while(newEdge != null)
        {
            PolygonEdge prevEdge = headNode;
            PolygonEdge curEdge  = headNode.nextEdge;
           // println(newEdge.x+"++++++"+newEdge.k+"------"+(curEdge != null));
            while(curEdge != null)
            {
                //println("====="+curEdge.k);
                //如果两条边的x相同
                if(newEdge.x == curEdge.x)
                {
                    //println(newEdge.x+"==="+newEdge.k);   
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
                
            PolygonEdge tempEdge = newEdge;
            newEdge = newEdge.nextEdge;
            tempEdge.nextEdge = prevEdge.nextEdge;
            prevEdge.nextEdge = tempEdge;
        }
        

    }
    
    //刷新有效活动边表，删除非活动边，递增x
    void RefreshAET(PolygonEdge headNode, int yMax)
    {
        PolygonEdge prevEdge = headNode;
        PolygonEdge curEdge  = headNode.nextEdge;
        
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
        
        if(yMax == 6)
        {
           PolygonEdge e = headNode.nextEdge;
            while(e != null)
            {
               println(e.x +" ===============================  "+e.k);
               e = e.nextEdge;
            }
        }
    }
    
    //使用有效边表填充算法填充多边形
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
        ScanLineBucket[] buckets = CreateBuckets(yMin, yMax);
        
        /*
            第三步 初始化所有边，生成每一个桶对应的边表
        */
        CreateScanLineEdgeTable(buckets, yMin);
        
        /*
            第四部 遍历整个桶，也就是从第一条扫描线到最后一条扫描遍历
        */
        PolygonEdge headNode = new PolygonEdge();  //生成有效边表的头结点
        for(int y = 0; y < buckets.length; ++y)
        {
            if(buckets[y].firstEdge != null)
            {
                AddActiveEdgeToET(headNode, buckets[y].firstEdge);
            }
            
            boolean fillNow = false; //是否立刻填充像素点
            double startX = 0, endX = 0;     //待填充的起点和终点
            PolygonEdge curEdge = headNode.nextEdge;
            if(y == 6)
            {
                {
                   PolygonEdge e = headNode.nextEdge;
                    while(e != null)
                    {
                       println(e.x +" ***************************************  "+e.k);
                       e = e.nextEdge;
                    }
                }
            }
            while(curEdge != null)
            {
                if(fillNow)
                {
                    endX = curEdge.x - 1; //左闭右开
                    stroke(255,0,0);
                   // println(startX +"  "+ endX+" ++++++++"+y);
                    for(double x = startX; x <= endX; ++x)
                    {
                        //四舍五入x
                        point((int)(x + 0.5), y + yMin);
                    }
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

/*
   多边形的有效边
*/
public class PolygonEdge
{
    public double x;         //活动边最小y坐标的顶点的x坐标
    public int    yMax;      //边的最大y坐标
    public double k;         //边的斜率的倒数
    
    public PolygonEdge nextEdge; //下一条边
    
    public PolygonEdge()
    {
       
    }
    
    public PolygonEdge(double _x, int _yMax, double _k)
    {
        x    = _x;
        yMax = _yMax;
        k    =_k;
    }
}

/*
   多边形的扫描线对应的桶，桶是一个链表包含边的最小y值与扫描线相同的边
*/
public class ScanLineBucket
{
    public int         scanLine;  //桶对应的扫描线，第yMin的扫描线对应0， 第yMin+1扫描线对应1， 以此类推
    public PolygonEdge firstEdge; //第一条有效边的引用
    
    public ScanLineBucket(int _scanLine)
    {
        scanLine = _scanLine;
    }
}