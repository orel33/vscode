class Fibo{
    public static int fib(int n)
        {
            if (n <= 1)
                return 1;
            else
                return fib(n - 1) + fib(n - 2);
        }
    public static void main(String args[])
    {
        int n = 10;
        System.out.print( fib(n) );
    }
}