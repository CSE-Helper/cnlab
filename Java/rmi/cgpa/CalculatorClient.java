import java.rmi.Naming; 
import java.rmi.RemoteException; 
import java.net.MalformedURLException; 
import java.rmi.NotBoundException; 
import java.util.*;
public class CalculatorClient { 
public static void main(String[] args) { 
try 
{ 
Calculator c = (Calculator)Naming.lookup(
"rmi://localhost/CalculatorService"); 
Scanner in=new Scanner (System.in);
System.out.println("enter the five subject mark");
int m1=in.nextInt();
int m2=in.nextInt();
int m3=in.nextInt();
int m4=in.nextInt();
int m5=in.nextInt();
System.out.println("CGPA is :");
System.out.println( c.sub(m1,m2,m3,m4,m5) ); 
} 
catch (MalformedURLException murle) { 
System.out.println(); 
System.out.println("MalformedURLException"); 
System.out.println(murle); 
} 
catch (RemoteException re) { 
System.out.println(); 
System.out.println("RemoteException"); 
System.out.println(re); 
} 
catch (NotBoundException nbe) { 
System.out.println(); 
System.out.println("NotBoundException"); 
System.out.println(nbe); 
} 
} 
}
