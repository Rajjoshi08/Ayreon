<%-- 
    Document   : SubmitPR
    Created on : 2 Feb, 2018, 4:24:39 PM
    Author     : Raj
--%>

<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.ObjectOutputStream"%>
<%@page import="java.net.Socket"%>
<%@page import="com.google.common.collect.ArrayListMultimap"%>
<%@page import="com.google.common.collect.Multimap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.common.collect.BiMap"%>
<%@page import="com.google.common.collect.ImmutableBiMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="icon" 
              type="image/png" 
              href="logo.png">
        <link rel="stylesheet" type="text/css" href="ayreonstyle.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ayreon - Submit PR</title>
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
                    Date requestdate;
                    String contact;
                    String description;
                    String category;
                    int value;
                    int correct;
                    String str;
                    HashMap MaterialCodeMap;
                    ArrayList materialcodes;
                    String requestedby = "";
                %>
                <%
                    prnumber = Integer.parseInt(session.getAttribute("PRNumber").toString());
                    requestedby = session.getAttribute("Requested By").toString();
                    requestdate = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").parse(session.getAttribute("Request Date").toString());
                    contact = session.getAttribute("Requested By").toString();
                    description = request.getParameter("description").toString();
                    category = request.getParameter("materialdropdown");
                    str = (String)request.getParameter("value");
                    if(str != null) {
                        value = Integer.parseInt(str);
                    }
                    MaterialCodeMap = (HashMap)session.getAttribute("MaterialCodeList");
                    List correctcodes = new ArrayList();
                    correctcodes.clear();
                    for (Object o : MaterialCodeMap.keySet()) {
                        if (MaterialCodeMap.get(o).equals(category)) {
                            correctcodes.add(o);
                        }
                    }
                    String[] c = request.getParameterValues("code");
                    Integer[] enteredCodes = new Integer[c.length];
                    int i = 0;
                    for(String a : c) {
                        enteredCodes[i] = Integer.parseInt(a);
                        i++;
                    }
                    String[] b = request.getParameterValues("quantity");
                    Integer[] enteredQuantity = new Integer[b.length];
                    i = 0;
                    for(String a : b) {
                        enteredQuantity[i] = Integer.parseInt(a);
                        i++;
                    }
                    i = 0;
                    correct = 0;
                    int code;
                    for(int k = 0; k < correctcodes.size(); k++) {
                        code = Integer.parseInt(correctcodes.get(k).toString());
                        for(int l = 0; l < enteredCodes.length; l++) {
                            if(enteredCodes[l] == code) {
                                correct++;
                                break;
                            }
                        }
                    }
                    if(correct == c.length) {
                        Socket soc = new Socket("192.168.43.182",9998);
                        ObjectOutputStream oos = new ObjectOutputStream(soc.getOutputStream());
                        oos.writeInt(prnumber);
                        oos.writeObject((Object)requestdate);
                        oos.writeObject(contact);
                        oos.writeObject(description);
                        oos.writeObject(category);
                        oos.writeInt(value);
                        oos.writeObject(enteredCodes);
                        oos.writeObject(enteredQuantity);
                        soc.close();
                %>
                <p><b>PR Form was submitted successfully</b></p>
                <%
                    }
                    else {
                %>
                <p><b>Some information entered was wrong. Please retry.</b></p>
                <%
                    } 
                %>
                <script type ="text/javascript">
                    function display() {
                        alert("PR Number = " + <%=prnumber%>);
                        alert("Request date = " + <%=requestdate%>);
                        alert("Contact Info = " + <%=contact%>);
                        alert("PR Description = " + <%=description%>);
                        alert("PR Category = " + <%=category%>);
                        alert("PR Value = " + <%=value%>);
                        <%
                            for(int j = 0; j < enteredCodes.length; j++) {
                        %>    
                            alert(<%=enteredCodes[j]%> + "       " + <%=enteredQuantity[j]%> + "<br>");
                        <%
                            }
                        %>
                        alert("Correct : " + <%=correct%>)
                    }
                </script>
            </article>
            
            <footer>Copyright &copy; Ayreon Dev Team</footer>

        </div>
    </body>
</html>