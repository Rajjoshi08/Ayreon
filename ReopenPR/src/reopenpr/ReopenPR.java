package reopenpr;

import java.io.ObjectInputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ReopenPR {
    
    public static void main(String[] args) throws Exception {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/AyreonDB","APP"," ");
        System.out.println("Connection established!");
        ServerSocket ss = new ServerSocket(9921);
        System.out.println("Server socket object established!");
        while(true) {
            Socket soc = ss.accept();
            System.out.println("Socket established");
            ObjectInputStream ois = new ObjectInputStream(soc.getInputStream());
            System.out.println("OIS created");
            System.out.println("Reading query");
            String query = ois.readObject().toString();
            System.out.println("Receiving PR Number");
            int prnumber = Integer.parseInt(ois.readObject().toString());
            System.out.println("Query Read");
            System.out.println("creating Statement object");
            PreparedStatement stmt = c.prepareStatement(query,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
            stmt.setInt(1, prnumber);
            System.out.println("Statement object created");
            System.out.println("Query received : " + query);
            stmt.executeUpdate();
            soc.close();
        }
    }
}
