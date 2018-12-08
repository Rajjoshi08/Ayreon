package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.BufferedReader;
import java.io.ObjectOutputStream;
import java.net.Socket;
import com.google.common.collect.ArrayListMultimap;
import com.google.common.collect.Multimap;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.ArrayList;
import com.google.common.collect.BiMap;
import com.google.common.collect.ImmutableBiMap;

public final class SubmitPR_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


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
                
  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <link rel=\"icon\" \n");
      out.write("              type=\"image/png\" \n");
      out.write("              href=\"logo.png\">\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"ayreonstyle.css\">\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Ayreon - Submit PR</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <div class=\"container\">\n");
      out.write("\n");
      out.write("            <header>\n");
      out.write("                <h1>AYREON</h1>\n");
      out.write("            </header>\n");
      out.write("  \n");
      out.write("            <nav>\n");
      out.write("                <ul>\n");
      out.write("                    <li><a href=\"PRForm.jsp\">Create PR</a></li>\n");
      out.write("                    <li><a href=\"PRStatus.jsp\">View PR</a></li>\n");
      out.write("                    <li><a href=\"Logout.jsp\">Logout</a></li>\n");
      out.write("                </ul>\n");
      out.write("            </nav>\n");
      out.write("\n");
      out.write("            <article>\n");
      out.write("                ");
      out.write("\n");
      out.write("                ");

                    prnumber = Integer.parseInt(application.getAttribute("PRNumber").toString());
                    application.removeAttribute("PRNumber");
                    requestdate = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").parse(application.getAttribute("Request Date").toString());
                    contact = application.getAttribute("Requested By").toString();
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
                
      out.write("\n");
      out.write("                <p><b>PR Form was submitted successfully</b></p>\n");
      out.write("                ");

                    }
                    else {
                
      out.write("\n");
      out.write("                <p><b>Some information entered was wrong. Please retry.</b></p>\n");
      out.write("                ");

                    } 
                
      out.write("\n");
      out.write("                <script type =\"text/javascript\">\n");
      out.write("                    function display() {\n");
      out.write("                        alert(\"PR Number = \" + ");
      out.print(prnumber);
      out.write(");\n");
      out.write("                        alert(\"Request date = \" + ");
      out.print(requestdate);
      out.write(");\n");
      out.write("                        alert(\"Contact Info = \" + ");
      out.print(contact);
      out.write(");\n");
      out.write("                        alert(\"PR Description = \" + ");
      out.print(description);
      out.write(");\n");
      out.write("                        alert(\"PR Category = \" + ");
      out.print(category);
      out.write(");\n");
      out.write("                        alert(\"PR Value = \" + ");
      out.print(value);
      out.write(");\n");
      out.write("                        ");

                            for(int j = 0; j < enteredCodes.length; j++) {
                        
      out.write("    \n");
      out.write("                            alert(");
      out.print(enteredCodes[j]);
      out.write(" + \"       \" + ");
      out.print(enteredQuantity[j]);
      out.write(" + \"<br>\");\n");
      out.write("                        ");

                            }
                        
      out.write("\n");
      out.write("                        alert(\"Correct : \" + ");
      out.print(correct);
      out.write(")\n");
      out.write("                    }\n");
      out.write("                </script>\n");
      out.write("            </article>\n");
      out.write("            \n");
      out.write("            <footer>Copyright &copy; Ayreon Dev Team</footer>\n");
      out.write("\n");
      out.write("        </div>\n");
      out.write("    </body>\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
