package ayreondatabaseapi;

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.io.*;

public class GetPRNumber {
    
    private Connection c;
    private ServerSocket ss;
    
    GetPRNumber(Connection c, ServerSocket ss) throws Exception{
        this.c = c;
        this.ss = ss;
    }
    
    public void executequery() throws Exception {
        System.out.println("Server socket object established!");
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
        int prnumber = 0;
        int count = 0;
        while(rs.next()) {
            count++;
            prnumber = rs.getInt("maxpr") + 1;
        }
        if(count == 0) {
            prnumber = 0 + 1;
        }
        System.out.println("Value of pr number = " + prnumber);
        System.out.println("Value obtaned");
        ObjectOutputStream oos = new ObjectOutputStream(soc.getOutputStream());
        System.out.println("OOS created");
        oos.writeObject(prnumber);
        System.out.println("Result delivered");
        soc.close();
        System.out.println("Socket closed");
    }
}