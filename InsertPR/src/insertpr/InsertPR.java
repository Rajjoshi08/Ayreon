package insertpr;

import java.io.BufferedWriter;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

public class InsertPR {

    public static void main(String[] args) throws Exception {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/AyreonDB","APP"," ");
        System.out.println("Connection established!");
        Statement generateOrderId = c.createStatement();
        ResultSet rs = generateOrderId.executeQuery("select max(orderid) as maxid from orderdtls");
        int maxid = 0;
        int count = 0;
        while(rs.next()) {
            count++;
            maxid = rs.getInt("maxid") + 1;
        }
        System.out.println("Maximum Order ID : " + maxid);
        if(count == 0) {
            maxid = 1;
        } 
        PreparedStatement stmt;
        ServerSocket ss = new ServerSocket(9998);
        System.out.println("Server socket object established!");
        restart: while(true) {
            Socket soc = ss.accept();
            System.out.println("Socket established");
            ObjectInputStream ois = new ObjectInputStream(soc.getInputStream());
            ObjectOutputStream oos = new ObjectOutputStream(soc.getOutputStream());
            System.out.println("OIS created");
            System.out.println("Get PR Number");
            int prnumber = ois.readInt();
            System.out.println("Get Request Date");
            Date requestdate = (Date)ois.readObject();
            System.out.println("Get Contact Details");
            String contact = ois.readObject().toString();
            System.out.println("Get PR Description");
            String description = ois.readObject().toString();
            System.out.println("Get Material Category");
            String category = ois.readObject().toString();
            System.out.println("Get Estimated PR Value");
            int value = ois.readInt();
            System.out.println("Get entered Material Codes");
            Integer[] enteredCodes = (Integer[])ois.readObject();
            System.out.println("Get entered Quantity");
            Integer[] enteredQuantity = (Integer[])ois.readObject();
            int len = enteredCodes.length;
            System.out.println("----Details Received----");
            System.out.println("Order ID : " + maxid);
            System.out.println("PR Number : " + prnumber);
            System.out.println("Request Date : " + requestdate);
            System.out.println("Contact No : " + contact);
            System.out.println("Description : " + description);
            System.out.println("Material Category : " + category);
            System.out.println("Estimated Value : " + value);
            System.out.println("Entered Codes : ");
            for(int i = 0; i < enteredCodes.length; i++) {
                System.out.println(enteredCodes[i]);
                stmt = c.prepareStatement("select maxquantity, currentquantity from mara where materialnumber = ?");
                stmt.setInt(1, enteredCodes[i]);
                rs = stmt.executeQuery();
                while(rs.next()) {
                    int max = rs.getInt("maxquantity");
                    int current = rs.getInt("currentquantity");
                    if(enteredQuantity[i]+current > max) {
                        String message = "Fail";
                        oos.writeObject(message);
                        continue restart;
                    }
                }
            }
            String message = "Success";
            oos.writeObject(message);
            System.out.println("Entered Quantity : ");
            for(int i = 0; i < enteredCodes.length; i++) {
                System.out.println(enteredQuantity[i]);
            }
            stmt = c.prepareStatement("insert into requisitiondtls values(?,?,?,?,?,?,?,0)");
            stmt.setInt(1, prnumber);
            stmt.setString(2, contact);
            stmt.setString(3, description);
            java.sql.Date sqlrequestdate = new java.sql.Date(requestdate.getTime());
            stmt.setDate(4, sqlrequestdate);
            stmt.setString(5, category);
            stmt.setInt(6, prnumber);
            stmt.setInt(7, value);
            stmt.executeUpdate();
            switch(len) {
                case 1: stmt = c.prepareStatement("insert into orderdtls values(?,?,?,?)");
                        stmt.setInt(1, prnumber);
                        stmt.setInt(2, prnumber);
                        stmt.setInt(3, enteredCodes[0]);
                        stmt.setInt(4, enteredQuantity[0]);
                        stmt.executeUpdate();
                        break;
                case 2: stmt = c.prepareStatement("insert into orderdtls values(?,?,?,?)");
                        stmt.setInt(1, prnumber);
                        stmt.setInt(2, prnumber);
                        stmt.setInt(3, enteredCodes[0]);
                        stmt.setInt(4, enteredQuantity[0]);
                        stmt.executeUpdate();
                        stmt = c.prepareStatement("insert into orderdtls values(?,?,?,?)");
                        stmt.setInt(1, prnumber);
                        stmt.setInt(2, prnumber);
                        stmt.setInt(3, enteredCodes[1]);
                        stmt.setInt(4, enteredQuantity[1]);
                        stmt.executeUpdate();
                        break;
                case 3: stmt = c.prepareStatement("insert into orderdtls values(?,?,?,?)");
                        stmt.setInt(1, prnumber);
                        stmt.setInt(2, prnumber);
                        stmt.setInt(3, enteredCodes[0]);
                        stmt.setInt(4, enteredQuantity[0]);
                        stmt.executeUpdate();
                        stmt = c.prepareStatement("insert into orderdtls values(?,?,?,?)");
                        stmt.setInt(1, prnumber);
                        stmt.setInt(2, prnumber);
                        stmt.setInt(3, enteredCodes[1]);
                        stmt.setInt(4, enteredQuantity[1]);
                        stmt.executeUpdate();
                        stmt = c.prepareStatement("insert into orderdtls values(?,?,?,?)");
                        stmt.setInt(1, prnumber);
                        stmt.setInt(2, prnumber);
                        stmt.setInt(3, enteredCodes[2]);
                        stmt.setInt(4, enteredQuantity[2]);
                        stmt.executeUpdate();
                        break;
            }
            soc.close();
        }
    }
}