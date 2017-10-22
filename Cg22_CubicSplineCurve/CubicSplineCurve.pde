//三次样条曲线
public class CubicSplineCurve
{
    //绘制三次样条曲线
    //points相邻的点不要重合且至少有2个点，当前没有处理相邻点重合的问题，如果有重合的点会导致曲线绘制不出
    public void DrawCubicSplineCurve(Point[] points, int mode)
    {
        if(mode == 0)       //夹持端
        {
            int n = points.length;
            float dy1 = 1;  //指定y1和yn的一阶导数都为1
            float dyn = 1;
        
            Point p1 = points[0];
            Point p2 = points[1];
            float d0 = 6*((p2.y - p1.y) / (p2.x - p1.x) - dy1) / (p2.x - p1.x);
        
            Point pn1 = points[n-2];
            Point pn  = points[n-1];
            float dn = 6*(dyn - (pn.y - pn1.y) / (pn.x - pn1.x)) / (pn.x - pn1.x);
            
            DrawCubicSplineCurve(points, 1, 1, d0, dn);
        }
        else if(mode == 1)  //自由端
        {
            DrawCubicSplineCurve(points, 0, 0, 0, 0);
        }
        else if(mode == 2)  //抛物线端
        {
            DrawCubicSplineCurve(points, -2, -2, 0, 0);
        }
    }
   
    private void DrawCubicSplineCurve(Point[] points, float an, float c0, float d0, float dn)
    {
        //构建三对角矩阵
        int n = points.length;
        float[] a = new float[n - 1];
        float[] c = new float[n - 1];
        float[] d = new float[n];

        a[n - 2] = an;
        c[0] = c0;
        
        d[0]   = d0;
        d[n-1] = dn;

        for(int i = 1; i < n - 1; ++i)
        {
            float curH  = points[i+1].x - points[i].x;
            float lastH = points[i].x - points[i-1].x;
            c[i] = curH / (curH + lastH);
            a[i-1] = 1 - c[i]; 
            
            d[i] = 6/(lastH +curH) *((points[i+1].y - points[i].y) / curH - (points[i].y - points[i-1].y)/lastH);
        }
        
        //解三对角矩阵
        SolveTriDiagonalMatrix3(a, c, d);
        
        //绘制曲线
        float _x = points[0].x;
        float _y = points[0].y; 
        for(int i = 0; i < n -1; ++i)
        {
            //求解两个点之间的3次曲线方程的系数a1,b1,c1,d1
            float h  = points[i+1].x - points[i].x;
            float a1 = points[i].y;
            float b1 = (points[i+1].y - points[i].y) / h - h *(d[i] / 3 + d[i+1] / 6);
            float c1 = d[i]/2;
            float d1 = (d[i+1] - d[i])/(6 * h);

            //绘制曲线
            float sx = points[i].x;
            if(sx < points[i+1].x)
            {
                for(float j = sx; j <= points[i+1].x; ++j)
                {
                    float h1 = j - sx;
                    float y = a1 + b1 * h1 + c1 * h1 * h1 + d1 * h1 * h1 * h1;
                    line(_x, _y, j, y);
                    _x = j;
                    _y = y;
                }
            }
            else
            {
                for(float j = sx; j >= points[i+1].x; --j)
                {
                    float h1 = j - sx;
                    float y = a1 + b1 * h1 + c1 * h1 * h1 + d1 * h1 * h1 * h1;
                    line(_x, _y, j, y);
                    _x = j;
                    _y = y;
                }
            }
        }
    }
    
    //追赶法求三对角矩阵
    //b为三对角矩阵的主对角元素
    //a为主对角线下的对角线元素
    //c为主对角线上的对角线元素
    //d为三对角矩阵的方程组等式右边的常数项
    //A=[
    //      2  -1   0   0
    //     -1   3  -2   0
    //      0  -2   4  -3
    //      0   0  -3   5
    //  ]
    //a=[-1 -2 -3];b=[2 3 4 5];c=[-1 -2 -3];d=[6 1 -2 1];
    //由于三次样条曲线的b元素都是2，所以算法内部把b相关的元素都用2代替
    //减少内存的使用
    private void SolveTriDiagonalMatrix3(float[] a, float[] c, float[] d)
    {
        int n = d.length;    
        //'追'的过程
        d[0] = d[0] * 0.5;
        c[0] = c[0] * 0.5;
        
        for(int i = 1, size = n - 1; i < size; ++i)
        {
            float temp =  2 - a[i-1] * c[i-1];
            d[i] = (d[i] - d[i-1] * a[i-1]) / temp;
            c[i] = c[i] / temp;
        }
        
        d[n-1] = (d[n-1] - d[n-2] * a[n-2]) / (2 - a[n-2] * c[n-2]);
        
        //'赶'的过程
        for(int i = n - 2; i >= 0; --i)
        {
            d[i] = d[i] - c[i] * d[i+1];
        }
    }  
}
