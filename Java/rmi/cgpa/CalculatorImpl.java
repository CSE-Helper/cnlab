public class CalculatorImpl extends java.rmi.server.UnicastRemoteObject 
implements Calculator { 
public CalculatorImpl() 
throws java.rmi.RemoteException { 
super(); 
} 
public long sub(int m1,int m2,int m3,int m4,int m5) 
throws java.rmi.RemoteException { 
System.out.println ("Calculating CGPA");
int m11=m1/10;
int m22=m2/10;
int m33=m3/10;
int m44=m4/10;
int m55=m5/10;
int sum=m11+m22+m33+m44+m55;
sum=sum/5;
return (long)sum;
} 
}
