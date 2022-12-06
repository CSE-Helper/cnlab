public class CalculatorImpl extends java.rmi.server.UnicastRemoteObject
        implements Calculator {
    public CalculatorImpl()
            throws java.rmi.RemoteException {
        super();
    }

    public long sub(int m1)
            throws java.rmi.RemoteException {
        System.out.println("Converting integar to string");
        double m11 = m1 * 1.8;
        m11 = m11 + 32;
        return (long) m11;
    }
}
