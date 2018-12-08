<%-- 
    Document   : SendMail
    Created on : 26 Feb, 2018, 1:57:00 PM
    Author     : Jimil
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
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

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="ayreonstyle.css" type="text/css">
        <link rel="icon" 
              type="image/png" 
              href="logo.png">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ayreon - Send Mail</title>
    </head>
    <body> 
        <div class="container">

            <%!
                String[] vendoremail = new String[3];
                String message = "";
                String[] materialnames = new String[]{" "," "," "};
                int[] orderedquantity = new int[]{0,0,0};
                int[] materialnumber = new int[]{0,0,0};
                String[] materialdes = new String[]{" "," "," "};
                String materialcategory = "";
            %>
            <%!
                public String formMessage(int count,String materialcategory) {
                    String emailMessage = "";
                    switch(count) {
                        case 1: 
                            emailMessage = 
                                "Dear Sir," + System.lineSeparator() +
                                "With reference to the material details mentioned below, kindly fill in and send your tender. The format for the same is mentioned following the material details." 
                                + System.lineSeparator() + System.lineSeparator() +
                                "Goods Required : " + System.lineSeparator() + System.lineSeparator() +
                                "Material Number - " + materialnumber[0] + System.lineSeparator() +
                                "Material Name - " + materialnames[0] + System.lineSeparator() +
                                "Material Description - " + materialdes[0] + System.lineSeparator() +
                                "Ordered Quantity - " + orderedquantity[0] + System.lineSeparator() +
                                System.lineSeparator() +
                                "Please send the tender in the below mentioned format - " + System.lineSeparator() +
                                "Mail Subject : " + materialcategory + "" + System.lineSeparator() + System.lineSeparator() +
                                "Message body :" + System.lineSeparator() +
                                "TOTAL COST : value(in Rs. and without any commas)<line-break>" + System.lineSeparator() +
                                "DELIVERY TIME : value(in days)<line-break>" + System.lineSeparator() +
                                "WARRANTY : value(in months)<line-break>" + System.lineSeparator() + System.lineSeparator() +
                                "Terms and conditions : " + System.lineSeparator() + 
                                "1. All the goods are to be delivered to the below mentioned address : " + System.lineSeparator() +
                                "Irla, N. R. G Marg," + System.lineSeparator() + "Opposite Cooper Hospital," + System.lineSeparator() + "Vileparle (W)," + System.lineSeparator() + "Mumbai 400056" + System.lineSeparator() + "India" + System.lineSeparator() +
                                "2. We here by declare that the above information is true. " +
                                "3. We here by also declare that all of the received information will be kept confidential." +
                                "4. Suppliers are entitled to charge the buyer, GST taxes as applicable, only and only upon successful display of supplier's GSTIN." + System.lineSeparator() +
                                "5. Supplier shall, at its own expense, pack, load, and deliver Goods to the Delivery Point and in accordance with the invoicing, delivery terms, shipping, packing, and other instructions printed on the face of the Purchase Order or otherwise provided to Supplier by Buyer in writing. No charges will be allowed for freight, transportation, insurance, shipping, storage, handling, demurrage, cartage, packaging or similar charges unless provided for in the applicable Purchase Order or otherwise agreed to in writing by Buyer." + System.lineSeparator() +
                                "6. Time is of the essence with respect to delivery of the Goods and performance of Services. Goods shall be delivered and Services performed by the applicable Delivery Date. Supplier must immediately notify Buyer if Supplier is likely to be unable to meet a Delivery Date. At any time prior to the Delivery Date, Buyer may, upon notice to Supplier, cancel or change a Purchase Order, or any portion thereof, for any reason, including, without limitation, for the convenience of Buyer or due to failure of Supplier to comply with this Agreement, unless otherwise noted." + System.lineSeparator() + 
                                "7. Upon receival of multiple copies, please refer to the latest request that has been received." + System.lineSeparator() +
                                "8. Suppliers are requested to send their mails without any CC or BCC mail addresses." + System.lineSeparator() +
                                System.lineSeparator() +
                                "Please ensure that you respond to this enquiry as soon as possible."
                                +System.lineSeparator() + System.lineSeparator() +
                                "Thanking you.";
                            break;
                        case 2:
                            emailMessage = 
                                "Dear Sir," + System.lineSeparator() +
                                "With reference to the material details mentioned below, kindly fill in and send your tender. The format for the same is mentioned following the material details." 
                                + System.lineSeparator() + System.lineSeparator() +
                                "Goods Required : " + System.lineSeparator() + System.lineSeparator() +
                                "Material Number - " + materialnumber[0] + System.lineSeparator() +
                                "Material Name - " + materialnames[0] + System.lineSeparator() +
                                "Material Description - " + materialdes[0] + System.lineSeparator() +
                                "Ordered Quantity - " + orderedquantity[0] + System.lineSeparator() +
                                System.lineSeparator() +
                                "Material Number - " + materialnumber[1] + System.lineSeparator() +
                                "Material Name - " + materialnames[1] + System.lineSeparator() +
                                "Material Description - " + materialdes[1] + System.lineSeparator() +
                                "Ordered Quantity - " + orderedquantity[1] + System.lineSeparator() +
                                System.lineSeparator() +
                                "Please send the tender in the below mentioned format - " + System.lineSeparator() +
                                "Mail Subject : " + materialcategory + "" + System.lineSeparator() + System.lineSeparator() +
                                "Message body :" + System.lineSeparator() +
                                "TOTAL COST : value(in Rs. and without any commas)<line-break>" + System.lineSeparator() +
                                "DELIVERY TIME : value(in days)<line-break>" + System.lineSeparator() +
                                "WARRANTY : value(in months)<line-break>" + System.lineSeparator() + System.lineSeparator() +
                                "Terms and conditions : " + System.lineSeparator() + 
                                "1. All the goods are to be delivered to the below mentioned address : " + System.lineSeparator() +
                                "Irla, N. R. G Marg," + System.lineSeparator() + "Opposite Cooper Hospital," + System.lineSeparator() + "Vileparle (W)," + System.lineSeparator() + "Mumbai 400056" + System.lineSeparator() + "India" + System.lineSeparator() +
                                "2. We here by declare that the above information is true. " +
                                "3. We here by also declare that all of the received information will be kept confidential." +
                                "4. Suppliers are entitled to charge the buyer, GST taxes as applicable, only and only upon successful display of supplier's GSTIN." + System.lineSeparator() +
                                "5. Supplier shall, at its own expense, pack, load, and deliver Goods to the Delivery Point and in accordance with the invoicing, delivery terms, shipping, packing, and other instructions printed on the face of the Purchase Order or otherwise provided to Supplier by Buyer in writing. No charges will be allowed for freight, transportation, insurance, shipping, storage, handling, demurrage, cartage, packaging or similar charges unless provided for in the applicable Purchase Order or otherwise agreed to in writing by Buyer." + System.lineSeparator() +
                                "6. Time is of the essence with respect to delivery of the Goods and performance of Services. Goods shall be delivered and Services performed by the applicable Delivery Date. Supplier must immediately notify Buyer if Supplier is likely to be unable to meet a Delivery Date. At any time prior to the Delivery Date, Buyer may, upon notice to Supplier, cancel or change a Purchase Order, or any portion thereof, for any reason, including, without limitation, for the convenience of Buyer or due to failure of Supplier to comply with this Agreement, unless otherwise noted." + System.lineSeparator() + 
                                "7. Upon receival of multiple copies, please refer to the latest request that has been received." + System.lineSeparator() +
                                "8. Suppliers are requested to send their mails without any CC or BCC mail addresses." + System.lineSeparator() +
                                System.lineSeparator() +
                                "Please ensure that you respond to this enquiry as soon as possible."
                                +System.lineSeparator() + System.lineSeparator() +
                                "Thanking you.";
                            break;
                        case 3:
                            emailMessage = 
                                "Dear Sir," + System.lineSeparator() +
                                "With reference to the material details mentioned below, kindly fill in and send your tender. The format for the same is mentioned following the material details." 
                                + System.lineSeparator() + System.lineSeparator() +
                                "Goods Required : " + System.lineSeparator() + System.lineSeparator() +
                                "Material Number - " + materialnumber[0] + System.lineSeparator() +
                                "Material Name - " + materialnames[0] + System.lineSeparator() +
                                "Material Description - " + materialdes[0] + System.lineSeparator() +
                                "Ordered Quantity - " + orderedquantity[0] + System.lineSeparator() +
                                System.lineSeparator() +
                                "Material Number - " + materialnumber[1] + System.lineSeparator() +
                                "Material Name - " + materialnames[1] + System.lineSeparator() +
                                "Material Description - " + materialdes[1] + System.lineSeparator() +
                                "Ordered Quantity - " + orderedquantity[1] + System.lineSeparator() +
                                System.lineSeparator() +
                                "Material Number - " + materialnumber[2] + System.lineSeparator() +
                                "Material Name - " + materialnames[2] + System.lineSeparator() +
                                "Material Description - " + materialdes[2] + System.lineSeparator() +
                                "Ordered Quantity - " + orderedquantity[2] + System.lineSeparator() +
                                System.lineSeparator() +
                                "Please send the tender in the below mentioned format - " + System.lineSeparator() +
                                "Mail Subject : " + materialcategory + "" + System.lineSeparator() + System.lineSeparator() +
                                "Message body :" + System.lineSeparator() +
                                "TOTAL COST : value(in Rs. and without any commas)<line-break>" + System.lineSeparator() +
                                "DELIVERY TIME : value(in days)<line-break>" + System.lineSeparator() +
                                "WARRANTY : value(in months)<line-break>" + System.lineSeparator() + System.lineSeparator() +
                                "Terms and conditions : " + System.lineSeparator() + 
                                "1. All the goods are to be delivered to the below mentioned address : " + System.lineSeparator() +
                                "Irla, N. R. G Marg," + System.lineSeparator() + "Opposite Cooper Hospital," + System.lineSeparator() + "Vileparle (W)," + System.lineSeparator() + "Mumbai 400056" + System.lineSeparator() + "India" + System.lineSeparator() +
                                "2. We here by declare that the above information is true. " +
                                "3. We here by also declare that all of the received information will be kept confidential." +
                                "4. Suppliers are entitled to charge the buyer, GST taxes as applicable, only and only upon successful display of supplier's GSTIN." + System.lineSeparator() +
                                "5. Supplier shall, at its own expense, pack, load, and deliver Goods to the Delivery Point and in accordance with the invoicing, delivery terms, shipping, packing, and other instructions printed on the face of the Purchase Order or otherwise provided to Supplier by Buyer in writing. No charges will be allowed for freight, transportation, insurance, shipping, storage, handling, demurrage, cartage, packaging or similar charges unless provided for in the applicable Purchase Order or otherwise agreed to in writing by Buyer." + System.lineSeparator() +
                                "6. Time is of the essence with respect to delivery of the Goods and performance of Services. Goods shall be delivered and Services performed by the applicable Delivery Date. Supplier must immediately notify Buyer if Supplier is likely to be unable to meet a Delivery Date. At any time prior to the Delivery Date, Buyer may, upon notice to Supplier, cancel or change a Purchase Order, or any portion thereof, for any reason, including, without limitation, for the convenience of Buyer or due to failure of Supplier to comply with this Agreement, unless otherwise noted." + System.lineSeparator() + 
                                "7. Upon receival of multiple copies, please refer to the latest request that has been received." + System.lineSeparator() +
                                "8. Suppliers are requested to send their mails without any CC or BCC mail addresses." + System.lineSeparator() +
                                System.lineSeparator() +
                                "Please ensure that you respond to this enquiry as soon as possible."
                                +System.lineSeparator() + System.lineSeparator() +
                                "Thanking you.";
                            break;
                    }
                    return emailMessage;
                }
            %>
            <%
                Connection c = null;
                PreparedStatement stmt = null;
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                c = DriverManager.getConnection("jdbc:derby://localhost:1527/AyreonDB","APP"," ");
                int ponumber1 = Integer.parseInt(application.getAttribute("PO Number").toString());
                stmt = c.prepareStatement("select * from podtls where ponumber = ?",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
                stmt.setInt(1, ponumber1);
                ResultSet podtls = stmt.executeQuery();
                int orderid = 0;
                while(podtls.next()) {
                    orderid = podtls.getInt("orderid");
                }
                podtls.beforeFirst();
                stmt = c.prepareStatement("select materialnumber, materialquantity from orderdtls where orderid = ?",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
                stmt.setInt(1, orderid);
                ResultSet orderdtls = stmt.executeQuery();
                int top = 0;
                while(orderdtls.next()) {
                    materialnumber[top] = orderdtls.getInt("materialnumber");
                    orderedquantity[top] = orderdtls.getInt("materialquantity");
                    top++;
                }
                orderdtls.beforeFirst();
                ResultSet names = null;
                for(int i = 0; i < top; i++) {
                    stmt = c.prepareStatement("select materialname, materialdescription from mara where materialnumber = ?",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
                    stmt.setInt(1,materialnumber[i]);
                    names = stmt.executeQuery();
                    while(names.next()) {
                        materialnames[i] = names.getString("materialname");
                        materialdes[i] = names.getString("materialdescription");
                    }
                    names.beforeFirst();
                }
                materialcategory = application.getAttribute("Material Category").toString();
                int count = 0;
                for(int i = 0; i < orderedquantity.length; i++) {
                    if(orderedquantity[i] != 0) {
                        count++;
                    }
                }
                session.setAttribute("Material Count", count);
                message = formMessage(count,materialcategory);
                vendoremail = (String[])application.getAttribute("Vendor Email");
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
                InternetAddress[] toAddresses = new InternetAddress[vendoremail.length];
                for(int i = 0; i < vendoremail.length; i++) {
                    toAddresses[i] = new InternetAddress(vendoremail[i]);
                }
                msg.setRecipients(Message.RecipientType.TO, toAddresses);
                msg.setSubject("Request for Tender");
                msg.setSentDate(new Date());
                msg.setText(message);

                // sends the e-mail
                Transport.send(msg);
                
                String po = (application.getAttribute("PO Number").toString());
                int ponumber = Integer.parseInt(po);
                int prnumber = 0;
                if(po.length() == 7) {
                    prnumber = Integer.parseInt(po.substring(po.length()-1));
                }
                if(po.length() == 8) {
                    prnumber = Integer.parseInt(po.substring(po.length()-2),po.length()-1);
                }
                session.setAttribute("PR Number", prnumber);
                session.setAttribute("PO Number", ponumber);
                String requestedby = " ";
                try {
                    stmt = c.prepareStatement("update requisitiondtls set status = 2 where prnumber = ?");
                    stmt.setInt(1,prnumber);
                    stmt.executeUpdate();
                    c.commit();
                    stmt = c.prepareStatement("update podtls set status = 2 where ponumber = ?");
                    stmt.setInt(1, ponumber);
                    stmt.executeUpdate();
                    c.commit();
                    stmt = c.prepareStatement("select requestedby from podtls where ponumber = ?");
                    stmt.setInt(1, ponumber);
                    ResultSet rs = stmt.executeQuery();
                    while(rs.next()) {
                        requestedby = rs.getString("requestedby");
                    }
                    c.commit();
                }
                finally {
                    stmt.close();
                    c.close();
                }
                
                message = "Sir, " + System.lineSeparator() +
                        "Your PR, numbered " + prnumber + " is waiting for vendor approval from the department manager.";
                
                Properties properties1 = new Properties();
                properties1.put("mail.smtp.host", host);
                properties1.put("mail.smtp.port", port);
                properties1.put("mail.smtp.auth", "true");
                properties1.put("mail.smtp.starttls.enable", "true");
 
                // creates a new session with an authenticator
                Session mailSession1 = Session.getInstance(properties,
                                new javax.mail.Authenticator() {
                                    protected PasswordAuthentication getPasswordAuthentication() {
                                        return new PasswordAuthentication(userName,password);
                                    }
                                });
                
                Message msg1 = new MimeMessage(mailSession1);
                
                msg1.setFrom(new InternetAddress(userName));
                InternetAddress[] toAddress = { new InternetAddress(requestedby) };
                msg1.setRecipients(Message.RecipientType.TO, toAddress);
                msg1.setSubject("PR Status Update");
                msg1.setSentDate(new Date());
                msg1.setText(message);
                
                Transport.send(msg1);
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
                <center>
                    <form method="post">
                       <br>
                       <b>E-mail was sent successfully.</b>
                       <br>
                       <br>
                       <button type="submit" formaction="ReceiveMail.jsp" class="submit1">Receive Tender</button>
                       <br>
                       <br>
                    </form>
                </center>
            </article>
            
            <footer>Copyright &copy; Ayreon Dev Team</footer>

        </div>
    </body>
</html>