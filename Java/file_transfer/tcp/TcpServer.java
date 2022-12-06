import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.FileWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Scanner;

public class TcpServer {
    public static void main(String[] args) throws Exception {
        // TODO Auto-generated method stub
        ServerSocket server = new ServerSocket(5000);
        System.out.println("Server started");
        System.out.println("Waiting for a client ...");
        Socket socket = server.accept();
        System.out.println("Client has joined sharing ");
        DataInputStream readInput = new DataInputStream(socket.getInputStream());
        DataOutputStream writeOutput = new DataOutputStream(socket.getOutputStream());
        Scanner ip = new Scanner(System.in);
        // get Stream socket input
        String lines = readInput.readUTF();
        // write to files
        FileWriter myWriter = new FileWriter("C:/Users/Tharun/Downloads/sd lab.txt");
        myWriter.write(lines);
        myWriter.close();
        server.close();
        socket.close();
        writeOutput.close();
        readInput.close();
        ip.close();
    }
}
