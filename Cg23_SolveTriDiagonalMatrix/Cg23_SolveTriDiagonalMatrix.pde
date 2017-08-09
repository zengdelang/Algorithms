void setup()
{
    float[] a = new float[]{-1, -2, -3};
    float[] b = new float[]{2, 3, 4, 5};
    float[] c = new float[]{-1, -2, -3};
    float[] d = new float[]{6, 1, -2, 1};
    
    float[] x = SolveTriDiagonalMatrix(a, b, c, d);
    println("SolveTriDiagonalMatrix = " +x[0]+" "+x[1]+" "+x[2]+" "+x[3]);
    
    SolveTriDiagonalMatrix2(a, b, c, d);
    println("SolveTriDiagonalMatrix2 = " +d[0]+" "+d[1]+" "+d[2]+" "+d[3]);
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
public float[] SolveTriDiagonalMatrix(float[] a, float[] b, float[] c, float[] d)
{
    int n = b.length;    
    //float[] L = new float[n];    //三对角矩阵的Crout分解的L矩阵存储主对角线上的元素，主对角线下的对角线的元素 = a
    float[] y = new float[n];    //Ly = d y保存中间解
    float[] U = new float[n-1];  //三对角矩阵的Crout分解的U矩阵主对角线上的对角线的元素, 主对角线上的元素都是1

    /*
    //'追'的过程 
    L[0] = b[0];
    y[0] = d[0] / L[0];
    U[0] = c[0] / L[0];
   
    for(int i = 1, size = b.length - 1; i < size; ++i)
    {
        L[i] = b[i] - a[i-1] * U[i-1];
        y[i] = (d[i] - y[i-1] * a[i-1]) / L[i];
        U[i] = c[i] / L[i];
    }
   
    L[n-1] = b[n-1] - a[n-2] * U[n-2];
    y[n-1] = (d[n-1] - y[n-2] * a[n-2]) / L[n-1];
    */

    //'追'的过程   去除L的存储
    y[0] = d[0] / b[0];
    U[0] = c[0] / b[0];
    
    for (int i = 1, size = n - 1; i < size; ++i)
    {
        float temp =  b[i] - a[i-1] * U[i-1];
        y[i] = (d[i] - y[i-1] * a[i-1]) / temp;
        U[i] = c[i] / temp;
    }

    y[n-1] = (d[n-1] - y[n-2] * a[n-2]) / (b[n-1] - a[n-2] * U[n-2]);

    /*
    //'赶'的过程
    float[] x = new float[n];
    x[n-1] = y[n-1];
    for(int i = n - 2; i >= 0; --i)
    {
       x[i] = y[i] - U[i] * x[i+1];
    }
    return x;
    */

    //'赶'的过程, 直接将y存储最终结果
    //y[n-1] = y[n-1];
    for (int i = n - 2; i >= 0; --i) 
    {
        y[i] = y[i] - U[i] * y[i+1];
    }
    return y;
}

//追赶法求三对角矩阵, 优化的算法减少内存使用
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
//将算法内部计算结果直接存储在参数的变量中,d代替y,c代替U
//算法执行完以后，参数中c和d的值和原来会不同
public void SolveTriDiagonalMatrix2(float[] a, float[] b, float[] c, float[] d)
{
    int n = b.length;    
    //'追'的过程
    d[0] = d[0] / b[0];
    c[0] = c[0] / b[0];

    for (int i = 1, size = n - 1; i < size; ++i)
    {
        float temp =  b[i] - a[i-1] * c[i-1];
        d[i] = (d[i] - d[i-1] * a[i-1]) / temp;
        c[i] = c[i] / temp;
    }

    d[n-1] = (d[n-1] - d[n-2] * a[n-2]) / (b[n-1] - a[n-2] * c[n-2]);

    //'赶'的过程
    for (int i = n - 2; i >= 0; --i)
    {
        d[i] = d[i] - c[i] * d[i+1];
    }
}