package ayreondatabaseapi;

import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.sql.*;
import java.util.*;

public class AyreonDatabaseAPI {

    public static void main(String[] args) throws Exception {

        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/AyreonDB","APP"," ");
        System.out.println("Connection established!");
        ServerSocket ss = new ServerSocket(9999);
        System.out.println("Server socket object established!");
        while(true) {
            GetPRNumber probj = new GetPRNumber(c,ss);
            probj.executequery();
            Socket soc = ss.accept();
            System.out.println("Socket established");
            System.out.println("Trying database connection");
            ObjectInputStream ois = new ObjectInputStream(soc.getInputStream());
            System.out.println("OIS created");
            System.out.println("Reading query");
            String query = (String)ois.readObject();
            System.out.println("Query Read");
            System.out.println("creating Statement object");
            Statement stmt = c.createStatement();
            System.out.println("Statement object created");
            System.out.println("Query received : " + query);
            ResultSet rs = stmt.executeQuery(query);
            System.out.println("ResultSet obtained");
            System.out.println("Creating Arraylist");
            ArrayList list=new ArrayList();
            while(rs.next()) {
                list.add(rs.getString("category"));
            }
            System.out.println("ArrayList created");
            ObjectOutputStream oos = new ObjectOutputStream(soc.getOutputStream());
            System.out.println("OOS created");
            oos.writeObject(list);
            System.out.println("Results delivered");
            soc.close();
            System.out.println("Socket closed");
        }
    }
}