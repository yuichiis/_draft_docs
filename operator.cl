__kernel void operator(
    __global long * y,
    const long a,
    const long b
    )
{
    y[0] = a / b;
    y[1] = a % b;
    y[2] = (long)((float)a/(float)b);
    y[3] = (long)remainder((float)a,(float)b);
    y[4] = a * b;
    y[5] = a / 5;
    y[6] = a % 5;
    y[7] = a + b;
}
