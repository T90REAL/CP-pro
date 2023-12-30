import java.io.*;
import java.util.Scanner;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.StringTokenizer;
public class sol {
    public static BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
    public static BufferedWriter out = new BufferedWriter(new OutputStreamWriter(System.out));
    public static StreamTokenizer cin = new StreamTokenizer(new BufferedReader(new InputStreamReader(System.in)));
    public static PrintWriter cout = new PrintWriter(new OutputStreamWriter(System.out));
	public static void main(String[] args) throws Exception {
		closeAll();
	}

    public static int nextInt() throws Exception{
        cin.nextToken();
        return (int) cin.nval;
    }
    public static long nextLong() throws Exception{
        cin.nextToken();
        return (long) cin.nval;
    }
    public static double nextDouble() throws Exception{
        cin.nextToken();
        return cin.nval;
    }
    public static String nextString() throws Exception{
        cin.nextToken();
        return cin.sval;
    }
    public static void closeAll() throws Exception {
        cout.close();
        in.close();
        out.close();
    }
}
