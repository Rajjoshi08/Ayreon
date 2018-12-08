package getmaterialcode;

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

public class GetMaterialCode{
    
    public static void main(String[] args) throws Exception {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/AyreonDB","APP"," ");
        System.out.println("Connection established!");
        ServerSocket ss = new ServerSocket(51412);
        System.out.println("Server socket object established!");
        while(true) {
            Socket soc = ss.accept();
            System.out.println("Socket established");
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
            System.out.println("Creating HashMap");
            HashMap materialcodelist=new HashMap();
            while(rs.next()) {
                materialcodelist.put(rs.getString("materialnumber"), rs.getString("materialcategory"));
            }
            System.out.println("HsshMap created");
            ObjectOutputStream oos = new ObjectOutputStream(soc.getOutputStream());
            System.out.println("OOS created");
            oos.writeObject(materialcodelist);
            System.out.println("Result delivered");
        }
    }
}