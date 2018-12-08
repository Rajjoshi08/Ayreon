<%-- 
    Document   : RejectMail
    Created on : 27 Mar, 2018, 9:45:48 PM
    Author     : Jimil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ayreon - Reject PR</title>
        <link rel="icon" 
              type="image/png" 
              href="logo.png">
        <link rel="stylesheet" type="text/css" href="ayreonstyle.css">
    </head>
    <body>
        <% 
            String toAdd = session.getAttribute("Contact").toString();
            int prnumber = Integer.parseInt(session.getAttribute("PR Number").toString());
            String remark = request.getParameter("remarks");
            String message = 
                    "Sir," + System.lineSeparator() + 
                    "Your PR, numbered " + prnumber + " is rejected with the following remarks : " + System.lineSeparator() + System.lineSeparator() +
                    remark;
            
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
            InternetAddress[] toAddresses = { new InternetAddress(toAdd) };
            msg.setRecipients(Message.RecipientType.TO, toAddresses);
            msg.setSubject("PR Rejected");
            msg.setSentDate(new Date());
            msg.setText(message);

            // sends the e-mail
            Transport.send(msg);

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
                        <b>PR Status was changed successfully.</b><br><br>
                        <button type="submit" class="submit1" formaction="index.jsp">Home</button>
                        <br>
                        <br>
                    </center>
                </form>
            </article>
            
            <footer>Copyright &copy; Ayreon Dev Team</footer>

        </div>
    </body>
</html>
