<%-- 
    Document   : StoreLog
    Created on : 19 Mar, 2018, 2:01:18 PM
    Author     : Jimil
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
        <link rel="icon" href="logo.png">
        <link rel="stylesheet" href="ayreonstyle.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ayreon - Log Delivery</title>
    </head>
    <body>
        <%!
            public void sendMail(Connection c, int prnumber, final String host, final String port, final String userName, final String password) throws Exception{
                PreparedStatement stmt = c.prepareStatement("select requestedby from requisitiondtls where prnumber = ?");
                stmt.setInt(1, prnumber);
                ResultSet rs2 = stmt.executeQuery();
                String requestedby = " ";
                while(rs2.next()) {
                    requestedby = rs2.getString("requestedby");
                }
                String mess = "Sir," + System.lineSeparator() +
                        "Assets for your PR, numbered, " + prnumber + " have been delivered by the vendor." + System.lineSeparator() +
                        "Status of your PR is updated to 'CLOSED'.";
                
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
                msg.setText(mess);

                // sends the e-mail
                Transport.send(msg);
            }
        %>
        <%
            ServletContext context = getServletContext();
            final String host = context.getInitParameter("host");
            final String port = context.getInitParameter("port");
            final String userName = context.getInitParameter("user");
            final String password = context.getInitParameter("pass");
            int cost = 0, dtime = 0, warranty = 0;
            int m = 0, zerocount = 0;
            int[] currentq = new int[]{0,0,0};
            int[] faulty = new int[]{0,0,0};
            String signedby = session.getAttribute("username").toString();
            int vendorcode = Integer.parseInt(session.getAttribute("Delivered By").toString());
            int ponumber = Integer.parseInt(session.getAttribute("PO Number").toString());
            int orderid = Integer.parseInt(session.getAttribute("Order ID").toString());
            String chalannumber = request.getParameter("chalan");
            java.util.Date date = new SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("deliverydate")); 
            java.sql.Date deliverydate = new java.sql.Date(date.getTime());
            int top = Integer.parseInt(session.getAttribute("Material Count").toString());
            String[] materialnames = (String[])session.getAttribute("Material Names");
            int[] materialquantity = (int[])session.getAttribute("Material Quantity");
            String[] a = request.getParameterValues("receivedquantity");
            String[] b = request.getParameterValues("faulty");
            int[] receivedquantity = new int[]{0,0,0};
            for(int k = 0; k < top; k++) {
                receivedquantity[k] = Integer.parseInt(a[k]);
            }
            for(int k = 0; k < top; k++) {
                faulty[k] = Integer.parseInt(b[k]);
            }
            int[] quantityleft = new int[]{0,0,0};
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/AyreonDB","APP"," ");
            PreparedStatement stmt = null;
            stmt = c.prepareStatement("select * from deliverydtls where ponumber = ?",ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            stmt.setInt(1, ponumber);
            ResultSet rs = stmt.executeQuery();
            rs.last();
            int rows = rs.getRow();
            if(rows == 0) {
                for(int k = 0; k < top; k++) {
                    quantityleft[k] = materialquantity[k] - (receivedquantity[k] - faulty[k]);
                    if(quantityleft[k] == 0) {
                        zerocount++;
                    }
                }
                for(int i = 0; i < top; i++) {
                    stmt = c.prepareStatement("insert into deliverydtls values(?,?,?,?,?,?,?,?,?,?)");
                    stmt.setInt(1, ponumber);
                    stmt.setInt(2, orderid);
                    stmt.setString(3, materialnames[i]);
                    stmt.setInt(4, materialquantity[i]);
                    stmt.setInt(5, receivedquantity[i]);
                    stmt.setInt(6, quantityleft[i]);
                    stmt.setString(7, chalannumber);
                    stmt.setDate(8, deliverydate);
                    stmt.setString(9, signedby);
                    stmt.setInt(10, vendorcode);
                    stmt.executeUpdate();
                }
                if(zerocount == top) {
                    stmt = c.prepareStatement("update podtls set status = 5 where ponumber = ?");
                    stmt.setInt(1, ponumber);
                    stmt.executeUpdate();
                    int prnumber = 0;
                    if((Integer.toString(ponumber)).length() == 7) {
                        prnumber = Integer.parseInt((Integer.toString(ponumber)).substring((Integer.toString(ponumber)).length()-1));
                    }
                    if((Integer.toString(ponumber)).length() == 8) {
                        prnumber = Integer.parseInt((Integer.toString(ponumber)).substring((Integer.toString(ponumber)).length()-2),(Integer.toString(ponumber)).length()-1);
                    }
                    c.commit();
                    stmt = c.prepareStatement("update requisitiondtls set status = 5 where prnumber = ?");
                    stmt.setInt(1,prnumber);
                    stmt.executeUpdate();
                    c.commit();
                    sendMail(c,prnumber,host,port,userName,password);
                }
            } else {
                stmt = c.prepareStatement("select currentquantity from deliverydtls where ponumber = ?");
                stmt.setInt(1, ponumber);
                ResultSet current = stmt.executeQuery();
                while(current.next()) {
                    currentq[m] = current.getInt("currentquantity") + (receivedquantity[m] - faulty[m]);
                    m++;
                }
                for(int k = 0; k < top; k++) {
                    quantityleft[k] = materialquantity[k] - currentq[k];
                    if(quantityleft[k] == 0) {
                        zerocount++;
                    }
                }
                for(int i = 0; i < top; i++) {
                    stmt = c.prepareStatement("update deliverydtls set currentquantity = ?, quantityleft = ?, chalannumber = ?, deliverydate = ?, signedby = ? where ponumber = ? and materialname = ?");
                    stmt.setInt(1, currentq[i]);
                    stmt.setInt(2, quantityleft[i]);
                    stmt.setString(3, chalannumber);
                    stmt.setDate(4, deliverydate);
                    stmt.setString(5,signedby);
                    stmt.setInt(6, ponumber);
                    stmt.setString(7, materialnames[i]);
                    stmt.executeUpdate();
                }
                c.commit();
                if(zerocount == top) {
                    stmt = c.prepareStatement("update podtls set status = 5 where ponumber = ?");
                    stmt.setInt(1, ponumber);
                    stmt.executeUpdate();
                    int prnumber = 0;
                    if((Integer.toString(ponumber)).length() == 7) {
                        prnumber = Integer.parseInt((Integer.toString(ponumber)).substring((Integer.toString(ponumber)).length()-1));
                    }
                    if((Integer.toString(ponumber)).length() == 8) {
                        prnumber = Integer.parseInt((Integer.toString(ponumber)).substring((Integer.toString(ponumber)).length()-2),(Integer.toString(ponumber)).length()-1);
                    }
                    c.commit();
                    stmt = c.prepareStatement("update requisitiondtls set status = 5 where prnumber = ?");
                    stmt.setInt(1,prnumber);
                    stmt.executeUpdate();
                    c.commit();
                    sendMail(c,prnumber,host,port,userName,password);
                }
            }
            c.commit();
            stmt = c.prepareStatement("select cost, deliverytime, warranty from tenderdtls where ponumber = ?");
            stmt.setInt(1, ponumber);
            ResultSet rs1 = stmt.executeQuery();
            while(rs1.next()) {
                cost = rs1.getInt("cost");
                dtime = rs1.getInt("deliverytime");
                warranty = rs1.getInt("warranty");
            }
            Calendar cal = Calendar.getInstance();
            cal.setTime(deliverydate);
            int month = cal.get(Calendar.MONTH);
            PrintWriter fos = new PrintWriter(new BufferedWriter(new FileWriter("D:\\AyreonLogs\\Month" + (month+1) + "Log.txt", true)), true);
            fos.println("----------------------------- Log Entry -----------------------------");
            fos.println("PO Number : " + ponumber);
            fos.println("Material Name \t\t\t Total Quantity \t\t\t Quantity Left To Receive ");
            for(int i = 0; i < top; i++) {
                fos.println(materialnames[i] + "\t\t\t\t" + materialquantity[i] + "\t\t\t\t" + quantityleft[i]);
            }
            fos.println(" ");
            fos.println("Tender Details : ");
            fos.println("\t Cost : Rs. " + cost + "/-");
            fos.println("\t Delivery Time : " + dtime + " days");
            fos.println("\t Warranty : " + warranty + " months");
            fos.println(" ");
            fos.println("Chalan Number : " + chalannumber);
            fos.println("Delivery Date : " + date);
            fos.println("Signed By : " + signedby);
            fos.println("Delivered By : " + vendorcode);
            fos.close();
        %>
        <div class="container">

            <header>
                <h1>AYREON</h1>
            </header>
  
            <nav>
                <ul>
                    <li><a href="SelectPO.jsp">Log Delivery</a></li>
                    <li><a href="Logout.jsp">Log Out</a></li>
                </ul>
            </nav>

            <article>
                <form>
                    <br><br>
                    <center>
                        <b>Delivery was logged successfully.</b><br><br>
                        <button type="submit" formaction="Welcome.jsp" class="submit1">Home</button>
                        <br><br>
                    </center>
                </form>
            </article>
            
            <footer>Copyright &copy; Ayreon Dev Team</footer>

        </div>
    </body>
</html>
