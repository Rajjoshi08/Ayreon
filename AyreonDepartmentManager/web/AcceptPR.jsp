<%-- 
    Document   : AcceptPR
    Created on : 24 Feb, 2018, 9:28:11 AM
    Author     : Jimil
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.sql.*"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.AddressException"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="ayreonstyle.css" type="text/css">
        <link rel="icon" 
              type="image/png" 
              href="logo.png">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ayreon - Accept PR</title>
    </head>
    <body>
        <div class="container">
            
            <%!
                int prnumber = 0;
                int ponumber = 0;
                String requestedby = "";
                String description = "";
                int[] materialnumber = new int[3];
                int[] orderedquantity = new int[3];
                Date requestdate;
                java.sql.Date sqlDate;
                String materialcategory = "";
                int orderid = 0;
                int value = 0;
                int status = 0;
            %>
            <%
                prnumber = Integer.parseInt(application.getAttribute("PR Number").toString());
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/AyreonDB","APP"," ");
                PreparedStatement stmt = c.prepareStatement("update requisitiondtls set status = 1 where prnumber = ?");
                stmt.setInt(1, prnumber);
                stmt.executeUpdate();
                stmt = c.prepareStatement("select * from requisitiondtls where prnumber = ?");
                stmt.setInt(1,prnumber);
                ResultSet prdtls = stmt.executeQuery();
                while(prdtls.next()) {
                    ponumber = prdtls.getInt("prnumber");
                    requestedby = prdtls.getString("requestedby");
                    description = prdtls.getString("description");
                    sqlDate = prdtls.getDate("requestdate");
                    materialcategory = prdtls.getString("materialcategory");
                    orderid = prdtls.getInt("orderid");
                    value = prdtls.getInt("estimatedvalue");
                    status = prdtls.getInt("status");
                }
                java.time.LocalDate date = java.time.LocalDate.now();
                String month = (date.getMonthValue())<10 ? "0"+String.valueOf(date.getMonthValue()) : String.valueOf(date.getMonthValue());
                ponumber = Integer.valueOf(String.valueOf(date.getYear()) + month + String.valueOf(ponumber));
                application.setAttribute("PO Number", ponumber);
                application.setAttribute("Material Category",materialcategory);
                stmt = c.prepareStatement("insert into podtls values(?,?,?,?,?,?,?,?,0)");
                stmt.setInt(1, ponumber);
                stmt.setString(2, requestedby);
                stmt.setString(3, description);
                stmt.setDate(4, sqlDate);
                stmt.setString(5, materialcategory);
                stmt.setInt(6, orderid);
                stmt.setInt(7, value);
                stmt.setInt(8, status);
                stmt.execute();
                stmt = c.prepareStatement("select orderid from podtls where ponumber = ?");
                stmt.setInt(1,ponumber);
                ResultSet rs = stmt.executeQuery();
                int orderid = 0;
                while(rs.next()) {
                    orderid = rs.getInt("orderid");
                }
                stmt = c.prepareStatement("select materialnumber,materialquantity from orderdtls where orderid = ?",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
                stmt.setInt(1, orderid);
                ResultSet orderdtls = stmt.executeQuery();
                int top = 0;
                while(orderdtls.next()) {
                    materialnumber[top] = orderdtls.getInt("materialnumber");
                    orderedquantity[top] = orderdtls.getInt("materialquantity");
                    top++;
                }
                for(int i = 0; i < materialnumber.length; i++) {
                    stmt = c.prepareStatement("select currentquantity from mara where materialnumber = ?");
                    stmt.setInt(1, materialnumber[i]);
                    ResultSet rs1 = stmt.executeQuery();
                    int current = 0;
                    while(rs1.next()) {
                        current = rs1.getInt("currentquantity");
                    }
                    stmt = c.prepareStatement("update mara set currentquantity = ? where materialnumber = ?");
                    stmt.setInt(1,current+orderedquantity[i]);
                    stmt.setInt(2, materialnumber[i]);
                    stmt.executeUpdate();
                }
                c.close();
                String message = 
                    "Sir," + System.lineSeparator() + 
                    "Your PR, numbered " + prnumber + " has been accepted and corressponding PO has been created.";

                    ServletContext context = getServletContext();
                    final String host = context.getInitParameter("host");
                    final String port = context.getInitParameter("port");
                    final String userName = context.getInitParameter("user");
                    final String password = context.getInitParameter("pass");

                    // sets SMTP server properties
                    Properties properties = new Properties();
                    properties.put("mail.smtp.host", host);
                    properties.put("mail.smtp.port", port);
                    properties.put("mail.smtp.auth", "true");
                    properties.put("mail.smtp.starttls.enable", "true");

                    // creates a new session with an authenticator
                    Session mailSession = Session.getInstance(properties,
                                    new javax.mail.Authenticator() {
                                        protected PasswordAuthentication getPasswordAuthentication() {
                                            return new PasswordAuthentication(userName,password);
                                        }
                                    });

                    // creates a new e-mail message
                    Message msg = new MimeMessage(mailSession);

                    msg.setFrom(new InternetAddress(userName));
                    InternetAddress[] toAddresses = { new InternetAddress(requestedby) };
                    msg.setRecipients(Message.RecipientType.TO, toAddresses);
                    msg.setSubject("PR Status Update");
                    msg.setSentDate(new Date());
                    msg.setText(message);

                    // sends the e-mail
                    Transport.send(msg);
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
                <form>
                    <center>
                        <b>PR was accepted. Click below button to view the generated PO.</b>
                        <br>
                        <br>
                        <button type="submit" class="submit1" formaction="ViewPO.jsp">View PO</button>
                        <br>
                        <br>
                    </center>
                </form>
            </article>
            
            <footer>Copyright &copy; Ayreon Dev Team</footer>

        </div>
    </body>
</html>