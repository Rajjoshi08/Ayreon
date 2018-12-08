<%-- 
    Document   : PRForm
    Created on : 15 Jan, 2018, 12:30:36 PM
    Author     : Project
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.OutputStreamWriter"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.ObjectOutputStream"%>
<%@page import="java.io.ObjectInputStream"%>
<%@page import="java.net.Socket"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="icon" 
              type="image/png" 
              href="logo.png">
        <link rel="stylesheet" type="text/css" href="ayreonstyle.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ayreon - Create PR</title>
        <script type ="text/javascript" language = "JavaScript">
            var rowcount = 1;
            function addrow() {
                if(rowcount !== 3) {
                    var table = document.getElementById("orderdtls");
                    var lastrow = table.rows.length;
                    var row = table.insertRow(lastrow);
                    var cell1 = row.insertCell(0);
                    var element1 = document.createElement('input');
                    element1.type = 'number';
                    element1.name = 'code';
                    cell1.appendChild(element1);
                    var cell2 = row.insertCell(1);
                    var element2 = document.createElement('input');
                    element2.type = 'number';
                    element2.name = 'quantity';
                    cell2.appendChild(element2);
                    var cell3 = row.insertCell(2);
                    var element3 = document.createElement('input');
                    element3.type = 'button';
                    element3.value = 'Add Row';
                    element3.onclick = 'addrow()';
                    cell3.appendChild(element3);
                    rowcount++;
                }
            }
        </script>
    </head>
    <body>
        <%!
            ArrayList list, selectedmaterialcodes;
            HashMap materialcodelist,userdtls;
            Iterator i, i1;
            ObjectOutputStream oos;
            ObjectInputStream ois;
            int prnumber;
            String category = "ABC";
            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");  
            Date currentdate = new Date();
            String requestdate = "";
            String username = "";
            String requestedby = "";
        %>
        <%
            requestedby = session.getAttribute("Requested By").toString();
            
            //retrieving pr number
            Socket s = new Socket("192.168.43.182",9999);
            oos = new ObjectOutputStream(s.getOutputStream());
            String getPRNumber = "select max(prnumber) as maxpr from requisitiondtls";
            oos.writeObject(getPRNumber);
            ois = new ObjectInputStream(s.getInputStream());
            prnumber = Integer.parseInt(ois.readObject().toString());
            session.setAttribute("PRNumber", prnumber);
            s.close();
            requestdate = formatter.format(currentdate);
            session.setAttribute("Request Date", requestdate);

            //retrieving category
            Socket soc = new Socket("192.168.43.182",9999);
            oos = new ObjectOutputStream(soc.getOutputStream());
            String getCategory = "select category from categorymaster";
            oos.writeObject(getCategory);
            ois = new ObjectInputStream(soc.getInputStream());
            list = (ArrayList)ois.readObject();
            i = list.iterator();
            soc.close();

            //creating hashmap
            Socket newsoc = new Socket("192.168.43.182",51412);
            oos = new ObjectOutputStream(newsoc.getOutputStream());
            String getMaterialCodes = "select materialnumber,materialcategory from mara";
            oos.writeObject(getMaterialCodes);
            ois = new ObjectInputStream(newsoc.getInputStream());
            materialcodelist = (HashMap)ois.readObject();
            session.setAttribute("MaterialCodeList", materialcodelist);
            newsoc.close();
        %>
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
                <form action = "SubmitPR.jsp" method = "POST">
                        <h1 class="pr">Purchase Requisition Form</h1><br/><br/>
                    <div class = "alignment">
                    PR Number : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type = "number" required id = "prnumberfield" name = "prnumberfield" value = "<%=prnumber%>" disabled = "yes"><br/><br/>
                    Date of Request : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type = "date" required id = "requestdate" name = "requestdate" value = "<%=requestdate%>" disabled = "yes"><br/><br/>
                    Purchase Head Contact: &nbsp;&nbsp;&nbsp;&nbsp;<input type = "email" required id = "contact" name = "contact" disabled="yes" value="<%=requestedby%>"><br/><br/>
                    PR Description : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <textarea rows = "4" cols = "50" id = "description" name = "description"></textarea><br/><br/>
                    Material Category : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    <select id = "materialdropdown" name = "materialdropdown">
                        <%
                            while(i.hasNext()) {
                        %>
                        <option><%= i.next() %></option>
                        <%
                            }
                        %>
                    </select><br/><br/>
                    Material Details : <br/><br/>
                    <table class = "tableborder" id = "orderdtls" name = "orderdtls">
                        <tr>
                            <th>Code</th>
                            <th>Quantity</th>
                            <th> </th>
                        </tr>
                        <tr>
                            <td><input type = "number" id = "code" name = "code" required></td>
                            <td><input type = "number" id = "quantity" name = "quantity" required></td>
                            <td><input type = "button" onclick = "addrow()" value = "Add Row"></td>
                        </tr>
                    </table>
                    <br/><br/>
                    Estimated Value : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type = "number" required id = "value" name = "value"><br/><br/>
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type ="Submit" value ="Submit" class="submit1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type ="reset" value ="Reset" class="reset1">
                    <br/><br/><br/>
                    </div>
                </form>
            </article>
            
            <footer>Copyright &copy; Ayreon Dev Team</footer>

        </div>
    </body>
</html>