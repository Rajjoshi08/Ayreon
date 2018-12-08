<%-- 
    Document   : GetStatus
    Created on : 17 Feb, 2018, 10:26:05 AM
    Author     : Raj
--%>

<%@page import="java.util.Date"%>
<%@page import="java.io.ObjectInputStream"%>
<%@page import="java.io.ObjectOutputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.OutputStreamWriter"%>
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
        <title>Ayreon - Get PR</title>
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
                <%!
                   int prnumber; 
                   String str;
                   String query;
                   String prdescription;
                   String requestdate;
                   String materialcategory;
                   int value;
                   String status;
                   int[] materialcodes = new int[3];
                   int[] materialquantity = new int[3];
                %>
                <%
                    str = (String)request.getParameter("prnumberfield");
                    if(str != null) {
                        prnumber = Integer.parseInt(str);
                    }
                    Socket soc = new Socket("192.168.43.182",9978);
                    query = "select description,requestdate,materialcategory,orderid,estimatedvalue,status from requisitiondtls where prnumber = ?";
                    ObjectOutputStream oos = new ObjectOutputStream((soc.getOutputStream()));
                    oos.writeObject(query);
                    oos.writeObject(prnumber);
                    ObjectInputStream ois = new ObjectInputStream(soc.getInputStream());
                    prdescription = (String)ois.readObject();
                    requestdate = ois.readObject().toString();
                    materialcategory = ois.readObject().toString();
                    value = Integer.parseInt(ois.readObject().toString());
                    status = ois.readObject().toString();
                    materialcodes = (int[])ois.readObject();
                    materialquantity = (int[])ois.readObject();
                    soc.close();
                %>
                <form>
                    <center><h1>Purchase Requisition Details</h1><br/><br/>    
                        <table class="tableborder">
                            <tr>
                                <th>PR Number</th>
                                <td><%=prnumber%></td>
                            </tr>
                            <tr>
                                <th>Requested By</th>
                                <td><%=session.getAttribute("Requested By")%></td>
                            </tr>
                            <tr>
                                <th>Description</th>
                                <td><%=prdescription%></td>
                            </tr>
                            <tr>
                                <th>Request Date</th>
                                <td><%=requestdate%></td>
                            </tr>
                            <tr>
                                <th>Material Category</th>
                                <td><%=materialcategory%></td>
                            </tr>
                            <tr>
                                <th>Estimated Value</th>
                                <td><%=value%></td>
                            </tr>
                            <tr>
                                <th>Status</th>
                                <td><%=status%></td>
                            </tr>
                        </table>
                        <br/>
                        <b>Material Details: </b>
                        <table class="tableborder" style="width:150px;">
                            <tr>
                                <th>Code</th>
                                <th>Quantity</th>
                            </tr>
                            <%
                                for(int i = 0; i < materialcodes.length; i++) {
                                    if(materialcodes[i] != 0) {
                            %>
                            <tr>
                                <td><%=materialcodes[i]%></td>
                                <td><%=materialquantity[i]%></td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                        </table>
                        <br>
                    </center>
                    <input type="submit" value="Back" class = "buttonalign1" formaction="PRStatus.jsp"> 
                    <br/>
                    <br/>
                    <br/>
                    <br/>
                </form>
            </article>
            
            <footer>Copyright &copy; Ayreon Dev Team</footer>

        </div>
    </body>
</html>
