<%-- 
    Document   : ReceiveMail
    Created on : 6 Mar, 2018, 4:04:06 PM
    Author     : Jimil
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="ayreonstyle.css" type="text/css">
        <link rel="icon" 
              type="image/png" 
              href="logo.png">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ayreon - Receive Tenders</title>
        <script type="text/javascript">
            var requestObj = false;
            
            if (window.XMLHttpRequest) {
                requestObj = new XMLHttpRequest();
            } else if (window.ActiveXObject) {
                requestObj = new ActiveXObject("Microsoft.XMLHTTP");
            }

            function getUpdates()
            {
                if (requestObj) {
                    requestObj.open("GET", "http://localhost:8084/AyreonDepartmentManager/EmailRecServlet/*");
                    requestObj.onreadystatechange = function ()
                    {
                        if (requestObj.readyState == 4 && requestObj.status == 200) {
                               document.getElementById("progressbar").value = requestObj.responseText;
                               if(document.getElementById("progressbar").value == 3) {
                                   window.location.href = "VendorSelection.jsp";
                               }
                        }
                    }
                    requestObj.send(null);
                }
            }
        </script>
    </head>
    <body> 
        <div class="container">

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
                <center>
                    <h1>E-mails Received : </h1>
                    <br>
                    <br>
                    <progress max="3" value ="0" class="progressbar" id="progressbar" name="progressbar"></progress>
                    <br>
                    <br>
                    <button onclick="getUpdates()" class="submit1" id="refreshbutton">Refresh</button>
                    <br>
                </center>
            </article>
            
            <footer>Copyright &copy; Ayreon Dev Team</footer>

        </div>
    </body>
</html>
