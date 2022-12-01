import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.InetAddress;
import java.net.Socket;

public class TcpClient {
	public static void main(String[] args) throws Exception{
	Socket socket = new Socket(InetAddress.getByName("localhost"), 5000);
	byte[] contents = new byte[10000];
	FileOutputStream fos = new FileOutputStream("C:/Users/student.DCLABSERVER/Desktop/TN20SDA866223/TcpClient.java");
	BufferedOutputStream bos = new BufferedOutputStream(fos);
	InputStream is = socket.getInputStream();
	int bytesRead = 0;
	while((bytesRead=is.read(contents))!=-1)
	bos.write(contents, 0, bytesRead);
	bos.flush();
	socket.close();
	System.out.println("File saved successfully!");
	}	
}