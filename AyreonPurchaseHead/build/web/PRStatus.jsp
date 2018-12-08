<%-- 
    Document   : PRStatus
    Created on : 29 Jan, 2018, 2:06:14 PM
    Author     : Raj
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.ObjectInputStream"%>
<%@page import="java.io.ObjectOutputStream"%>
<%@page import="java.net.Socket"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="icon" 
              type="image/png" 
              href="logo.png">
        <link rel="stylesheet" type="text/css" href="ayreonstyle.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ayreon - PR Status</title>
    </head>
    <body>
        <div class="container">

            <header>
                <h1>AYREON</h1>
            </header>
  
            <nav>
                <ul>
                    <li><a href="PRForm.jsp">Create PR</a></li>
                    <li><a href="PRStatus.jsp">View PR</a></li>
                    <li><a href="Logout.jsp">Logout</a></li>
                </ul>
            </nav>

            <article>
                <%
                    Socket soc = new Socket("192.168.43.182",9977);
                    String query = "select prnumber from requisitiondtls where requestedby = ?";
                    ObjectOutputStream oos = new ObjectOutputStream(soc.getOutputStream());
                    oos.writeObject(query);
                    oos.writeObject(session.getAttribute("Requested By").toString());
                    ObjectInputStream ois = new ObjectInputStream(soc.getInputStream());
                    ArrayList PRNumbers = (ArrayList)ois.readObject();
                    Iterator i = PRNumbers.iterator();
                    soc.close();
                %>
                <form action = "GetStatus.jsp" method = "POST">
                    <center><h1>Purchase Requisition Details</h1></center><br/><br/>
                    <div class = "alignment">    
                            <br/>
                            <br/>
                            <center>
                                PR Number : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                                <select id = "prnumberfield" name = "prnumberfield" required style = "width:150px">
                                <%
                                    while(i.hasNext()) {
                                %>
                                <option><%= i.next() %></option>
                                <%
                                    }
                                %>
                                </select>
                                <br/>
                                <br/>
                            </center>
                            <input type ="Submit" value ="Get Status" class="buttonalign" >
                            <br/>
                            <br/>            
                    </div>
                </form>
            </article>
            
            <footer>Copyright &copy; Ayreon Dev Team</footer>

        </div>
    </body>
</html>
