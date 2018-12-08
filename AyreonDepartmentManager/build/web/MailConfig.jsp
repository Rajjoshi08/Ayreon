<%-- 
    Document   : MailConfig
    Created on : 6 Mar, 2018, 3:55:19 PM
    Author     : Jimil
--%>

<%@page import="java.util.Properties"%>
<%@page import="javax.mail.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inbox Configuration</title>
    </head>
    <body>
        <%!
            String materialcategory="";
        %>
        <%
            ServletContext context = pageContext.getServletContext();
            final String user = context.getInitParameter("user");
            final String password = context.getInitParameter("pass");
            
            //1) get the session object  
            Properties properties = new Properties();  
            properties.put("mail.store.protocol", "imaps");  
            //Session emailSession = Session.getDefaultInstance(properties);  
            Session emailSession = Session.getInstance(properties,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(user,password);
                    }
                });

            //2) create the POP3 store object and connect with the pop server  
            Store emailStore = emailSession.getStore("imaps");
            emailStore.connect("imap.gmail.com",user, password);

            //3) create the folder object and open it  
            Folder emailFolder = emailStore.getFolder("INBOX");  
            emailFolder.open(Folder.READ_ONLY);  

            //4) retrieve the messages from the folder in an array and print it  
            Message[] messages = emailFolder.getMessages();  
            application.setAttribute("Old Inbox Size", messages.length);
            materialcategory = application.getAttribute("Material Category").toString();
            application.setAttribute("Material Category", materialcategory);

            //5) close the store and folder objects  
            emailFolder.close(false);  
            emailStore.close();
        %>
        <jsp:forward page="SendMail.jsp"></jsp:forward>
    </body>
</html>
