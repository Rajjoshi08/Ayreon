package getprstatus;

import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;
import java.util.HashMap;

public class GetPRStatus {

    public static void main(String[] args) throws Exception {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/AyreonDB","APP"," ");
        System.out.println("Connection established!");
        ServerSocket ss = new ServerSocket(9978);
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
            ResultSet rs = stmt.executeQuery();
            System.out.println("ResultSet obtained");
            String prdescription = "";
            Date requestdate = null;
            String materialcategory = "";
            int orderid = 0;
            int value = 0;
            int status = -1;
            while(rs.next()) {
                prdescription = rs.getString("description");
                requestdate = rs.getDate("requestdate");
                materialcategory = rs.getString("materialcategory");
                orderid = rs.getInt("orderid");
                value = rs.getInt("estimatedvalue");
                status = rs.getInt("status");
            }
            rs.beforeFirst();
            query = "select materialnumber, materialquantity from orderdtls where orderid = ?";
            stmt = c.prepareStatement(query);
            stmt.setInt(1, orderid);
            rs = stmt.executeQuery();
            int[] materialcodes = new int[3];
            int[] materialquantity = new int[3];
            int top = 0;
            while(rs.next()) {
                materialcodes[top] = rs.getInt("materialnumber");
                materialquantity[top] = rs.getInt("materialquantity");
                top++;
            }
            query = "select description from statusmaster where status = ?";
            stmt = c.prepareStatement(query);
            stmt.setInt(1, status);
            rs = stmt.executeQuery();
            String statusdes = "";
            while(rs.next()) {
                statusdes = rs.getString("description");
            }
            System.out.println(statusdes);
            ObjectOutputStream oos = new ObjectOutputStream(soc.getOutputStream());
            System.out.println("OOS created");
            oos.writeObject(prdescription);
            oos.writeObject(requestdate);
            oos.writeObject(materialcategory);
            oos.writeObject(value);
            oos.writeObject(statusdes);
            oos.writeObject(materialcodes);
            oos.writeObject(materialquantity);
            System.out.println("Result delivered");
            soc.close();
        }
    }
}
