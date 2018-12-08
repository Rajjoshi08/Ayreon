package jsp.emailreceive;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Properties;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import java.util.HashMap;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

public class EmailRecServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String vendormessage = " ";
            HashMap messageMap = new HashMap();
            HttpSession session = request.getSession();
            ServletContext context = request.getServletContext();
            final String user = context.getInitParameter("user");
            final String password = context.getInitParameter("pass");
            int oldinboxsize = Integer.parseInt(context.getAttribute("Old Inbox Size").toString());

            //1) get the session object  
            Properties properties = new Properties();
            properties.put("mail.store.protocol", "imaps");
            //Session emailSession = Session.getDefaultInstance(properties);  
            Session emailSession = Session.getDefaultInstance(properties,
                    new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(user, password);
                }
            });

            //2) create the POP3 store object and connect with the pop server  
            Store emailStore = emailSession.getStore("imaps");
            emailStore.connect("imap.gmail.com", user, password);

            //3) create the folder object and open it  
            Folder emailFolder = emailStore.getFolder("INBOX");
            emailFolder.open(Folder.READ_ONLY);

            //4) retrieve the messages from the folder in an array and print it  
            Message[] messages = emailFolder.getMessages();
            int msgindex = 0;
            int newinboxsize = messages.length;
            if (newinboxsize > oldinboxsize) {
                    for(int i = 1; i <= (newinboxsize-oldinboxsize); i++) {
                        msgindex = messages.length-i;
                        Message message = messages[msgindex];
                        BodyPart clearTextPart = null;
                        if (message instanceof MimeMessage) {
                            MimeMessage m = (MimeMessage) message;
                            Object contentObject = m.getContent();
                            if (contentObject instanceof Multipart) {
                                clearTextPart = null;
                                Multipart content = (Multipart) contentObject;
                                int count = content.getCount();
                                for (int j = 0; j < count; j++) {
                                    BodyPart part = content.getBodyPart(j);
                                    if (part.isMimeType("text/plain")) {
                                        clearTextPart = part;
                                        vendormessage = clearTextPart.getContent().toString();
                                    }
                                }
                                session.setAttribute(message.getFrom()[0].toString(),(String)clearTextPart.getContent());
                                session.setAttribute("Vendor Category", message.getSubject().toString());
                            }
                        }
                        final String host = context.getInitParameter("host");
                        final String port = context.getInitParameter("port");

                        // sets SMTP server properties
                        properties.put("mail.smtp.host", host);
                        properties.put("mail.smtp.port", port);
                        properties.put("mail.smtp.auth", "true");
                        properties.put("mail.smtp.starttls.enable", "true");

                        // creates a new session with an authenticator
                        Session mailSession = Session.getInstance(properties,
                                        new javax.mail.Authenticator() {
                                            protected PasswordAuthentication getPasswordAuthentication() {
                                                return new PasswordAuthentication(user,password);
                                            }
                                        });

                        // creates a new e-mail message
                        Message msg = new MimeMessage(mailSession);

                        msg.setFrom(new InternetAddress(user));
                        InternetAddress[] toAddresses = { new InternetAddress("thisisayreon@gmail.com") };
                        msg.setRecipients(Message.RecipientType.TO, toAddresses);
                        msg.setSubject("Tender from " + message.getFrom()[0].toString());
                        msg.setSentDate(new Date());
                        msg.setText(vendormessage);

                        // sends the e-mail
                        Transport.send(msg);
                    }
                    String difference = Integer.toString(newinboxsize - oldinboxsize);
                    out.write(difference);
                }
            //5) close the store and folder objects  
            emailFolder.close(false);
            emailStore.close();
            }
            catch(MessagingException e) { e.printStackTrace(); }
            catch(IOException e) { e.printStackTrace(); }
            catch(Exception e) { e.printStackTrace(); }
        } 
}