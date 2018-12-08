package getallprnumbers;

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

public class GetAllPRNumbers {

    public static void main(String[] args) throws Exception {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/AyreonDB","APP"," ");
        System.out.println("Connection established!");
        ServerSocket ss = new ServerSocket(9977);
        System.out.println("Server socket object established!");
        while(true) {
            Socket soc = ss.accept();
            System.out.println("Socket established");
            ObjectInputStream ois = new ObjectInputStream(soc.getInputStream());
            System.out.println("OIS created");
            System.out.println("Reading query");
            String query = (String)ois.readObject();
            String requestedby = (String)ois.readObject();
            System.out.println("Query Read");
            System.out.println("creating Statement object");
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1, requestedby);
            System.out.println("PreparedStatement object created");
            System.out.println("Query received : " + query);
            ResultSet rs = stmt.executeQuery();
            System.out.println("ResultSet obtained");
            System.out.println("Creating ArrayList");
            ArrayList PRNumbers = new ArrayList();
            while(rs.next()) {
                PRNumbers.add(rs.getInt("prnumber"));
            }
            System.out.println("ArrayList created");
            ObjectOutputStream oos = new ObjectOutputStream(soc.getOutputStream());
            System.out.println("OOS created");
            oos.writeObject(PRNumbers);
            System.out.println("Result delivered");
        }
    }
}
