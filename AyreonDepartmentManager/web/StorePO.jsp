<%-- 
    Document   : StorePO
    Created on : 24 Feb, 2018, 11:07:19 AM
    Author     : Jimil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="ayreonstyle.css" type="text/css">
        <link rel="icon" 
              type="image/png" 
              href="logo.png">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ayreon - PO Details</title>
    </head>
    <body>
        <div class="container">

            <%
                String ponumber = request.getParameter("ponumberdropdown");
                Object ponumber1 = ponumber;
                application.setAttribute("PO Number",ponumber1);
            %>
            <header>
                <h1>AYREON</h1>
            </header>
  
            <nav>
                <ul>
                    <li><a href="ViewPR.jsp">View PR</a></li>
                    <li><a href="PODtls.jsp">View PO</a></li>
                </ul>
            </nav>

            <article>
                <jsp:forward page = "ViewPO.jsp"></jsp:forward>
            </article>
            
            <footer>Copyright &copy; Ayreon Dev Team</footer>

        </div>
    </body>
</html>

