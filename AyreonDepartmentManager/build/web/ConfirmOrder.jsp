<%-- 
    Document   : ConfirmOrder
    Created on : 17 Mar, 2018, 9:36:10 AM
    Author     : Jimil
--%>

<%@page import="java.sql.*" %>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@page import="java.util.Date" %>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.AddressException"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="ayreonstyle.css" type="text/css">
        <link rel="icon" 
              type="image/png" 
              href="logo.png">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ayreon - Vendor Details</title>
    </head>
    <body> 
        <%!
            String[] materialnames;
            int[] orderedquantity;
            int[] materialnumber;
            String[] materialdes;
        %>
        <%!
                public String formMessage(int count, int cost, int dtime, int warranty, int ponumber) {
                    String emailMessage = "";
                    switch(count) {
                        case 1: 
                            emailMessage = 
                                "Dear Sir," + System.lineSeparator() +
                                "This message is sent to inform you that your tender for the materials listed below has been accepted." 
                                + System.lineSeparator() + System.lineSeparator() +
                                "PO Number : " + ponumber + System.lineSeparator() +
                                "Goods : " + System.lineSeparator() +  
                                "Material Number + " + materialnumber[0] + System.lineSeparator() +
                                "Material Name - " + materialnames[0] + System.lineSeparator() + 
                                "Material Description - " + materialdes[0] + System.lineSeparator() +
                                "Ordered Quantity - " + orderedquantity[0] + System.lineSeparator() +
                                System.lineSeparator() +
                                "The tender that was received and is accepted is as follows : " + System.lineSeparator() +
                                "TOTAL COST : " + cost + " Rs." + System.lineSeparator() +
                                "DELIVERY TIME : " + dtime + " days" +System.lineSeparator() +
                                "WARRANTY : " + warranty + " months" + System.lineSeparator() + System.lineSeparator() +
                                "Please start the delivery process as per convenience.";
                            break;
                        case 2:
                            emailMessage = 
                                "Dear Sir," + System.lineSeparator() +
                                "This message is sent to inform you that your tender for the materials listed below has been accepted." 
                                + System.lineSeparator() + System.lineSeparator() +
                                "PO Number : " + ponumber + System.lineSeparator() +
                                "Goods : " + System.lineSeparator() +  
                                "Material Number + " + materialnumber[0] + System.lineSeparator() +
                                "Material Name - " + materialnames[0] + System.lineSeparator() + 
                                "Material Description - " + materialdes[0] + System.lineSeparator() +
                                "Ordered Quantity - " + orderedquantity[0] + System.lineSeparator() +
                                System.lineSeparator() +
                                "Material Number + " + materialnumber[1] + System.lineSeparator() +
                                "Material Name - " + materialnames[1] + System.lineSeparator() + 
                                "Material Description - " + materialdes[1] + System.lineSeparator() +
                                "Ordered Quantity - " + orderedquantity[1] + System.lineSeparator() +
                                System.lineSeparator() +
                                "The tender that was received and is accepted is as follows : " + System.lineSeparator() +
                                "TOTAL COST : " + cost + " Rs." + System.lineSeparator() +
                                "DELIVERY TIME : " + dtime + " days" +System.lineSeparator() +
                                "WARRANTY : " + warranty + " months" + System.lineSeparator() + System.lineSeparator() +
                                "Please start the delivery process as per convenience.";
                            break;
                        case 3:
                            emailMessage = 
                                "Dear Sir," + System.lineSeparator() +
                                "This message is sent to inform you that your tender for the materials listed below has been accepted." 
                                + System.lineSeparator() + System.lineSeparator() +
                                "PO Number : " + ponumber + System.lineSeparator() +
                                "Goods : " + System.lineSeparator() +  
                                "Material Number + " + materialnumber[0] + System.lineSeparator() +
                                "Material Name - " + materialnames[0] + System.lineSeparator() + 
                                "Material Description - " + materialdes[0] + System.lineSeparator() +
                                "Ordered Quantity - " + orderedquantity[0] + System.lineSeparator() +
                                System.lineSeparator() +
                                "Material Number + " + materialnumber[1] + System.lineSeparator() +
                                "Material Name - " + materialnames[1] + System.lineSeparator() + 
                                "Material Description - " + materialdes[1] + System.lineSeparator() +
                                "Ordered Quantity - " + orderedquantity[1] + System.lineSeparator() +
                                System.lineSeparator() +
                                "Material Number + " + materialnumber[2] + System.lineSeparator() +
                                "Material Name - " + materialnames[2] + System.lineSeparator() + 
                                "Material Description - " + materialdes[2] + System.lineSeparator() +
                                "Ordered Quantity - " + orderedquantity[2] + System.lineSeparator() +
                                System.lineSeparator() +
                                "The tender that was received and is accepted is as follows : " + System.lineSeparator() +
                                "TOTAL COST : " + cost + " Rs." + System.lineSeparator() +
                                "DELIVERY TIME : " + dtime + " days" +System.lineSeparator() +
                                "WARRANTY : " + warranty + " months" + System.lineSeparator() + System.lineSeparator() +
                                "Please start the delivery process as per convenience.";
                            break;
                    }
                    return emailMessage;
                }
            %>
        <%
            int prnumber = Integer.parseInt(session.getAttribute("PR Number").toString());
            int ponumber = Integer.parseInt(session.getAttribute("PO Number").toString());
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/AyreonDB","APP"," ");
            PreparedStatement stmt = c.prepareStatement("update requisitiondtls set status = 3 where prnumber = ?");
            stmt.setInt(1, prnumber);
            stmt.executeUpdate();
            c.commit();
            stmt = c.prepareStatement("update podtls set status = 3 where ponumber = ?");
            stmt.setInt(1, ponumber);
            stmt.executeUpdate();
            c.commit();
            stmt = c.prepareStatement("select requestedby from requisitiondtls where prnumber = ?");
            stmt.setInt(1, prnumber);
            ResultSet rs = stmt.executeQuery();
            String requestedby = " ";
            while(rs.next()) {
                requestedby = rs.getString("requestedby");
            }
            stmt.close();
            c.close();
            int cost = Integer.parseInt(session.getAttribute("Optimum Cost").toString());
            int dtime = Integer.parseInt(session.getAttribute("Optimum Dtime").toString());
            int warranty = Integer.parseInt(session.getAttribute("Optimum Warranty").toString());
            String email = session.getAttribute("Optimum Vendor Email").toString();
            materialnames = (String[])session.getAttribute("Material Names");
            orderedquantity = (int[])session.getAttribute("Ordered Quantity");
            materialnumber = (int[])session.getAttribute("Material Number");
            materialdes = (String[])session.getAttribute("Material Description");
            int count = Integer.parseInt(session.getAttribute("Material Count").toString());
            String message = formMessage(count,cost,dtime,warranty,ponumber);
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
            InternetAddress[] toAddresses = { new InternetAddress(email) };
            msg.setRecipients(Message.RecipientType.TO, toAddresses);
            msg.setSubject("Confirmation For Tender Approval");
            msg.setSentDate(new Date());
            msg.setText(message);

            // sends the e-mail
            Transport.send(msg);
            
            message = "Sir, " + System.lineSeparator() +
            "Vendor for your PR, numbered " + prnumber + " has been approved by the department manager";
            
            Message msg1 = new MimeMessage(mailSession);

            msg1.setFrom(new InternetAddress(userName));
            InternetAddress[] toAddress = { new InternetAddress(requestedby) };
            msg1.setRecipients(Message.RecipientType.TO, toAddress);
            msg1.setSubject("PR Status Update");
            msg1.setSentDate(new Date());
            msg1.setText(message);

            // sends the e-mail
            Transport.send(msg1);
        %>
        
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
                <form>
                    <center>
                        <br><br>
                        <b>Confirmation was sent successfully.</b><br><br>
                        <button type="submit" class="submit1" formaction="index.jsp">Home</button><br><br>
                    </center>
                </form>
            </article>
                
            <footer>Copyright &copy; Ayreon Dev Team</footer>

        </div>
    </body>
</html>
