package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.Iterator;
import java.util.ArrayList;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;

public final class PRStatus_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

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
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <link rel=\"icon\" \n");
      out.write("              type=\"image/png\" \n");
      out.write("              href=\"logo.png\">\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"ayreonstyle.css\">\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Ayreon - PR Status</title>\n");
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

                    Socket soc = new Socket("192.168.43.182",9977);
                    String query = "select prnumber from requisitiondtls where requestedby = ?";
                    ObjectOutputStream oos = new ObjectOutputStream(soc.getOutputStream());
                    oos.writeObject(query);
                    oos.writeObject(session.getAttribute("Requested By").toString());
                    ObjectInputStream ois = new ObjectInputStream(soc.getInputStream());
                    ArrayList PRNumbers = (ArrayList)ois.readObject();
                    Iterator i = PRNumbers.iterator();
                    soc.close();
                
      out.write("\n");
      out.write("                <form action = \"GetStatus.jsp\" method = \"POST\">\n");
      out.write("                    <center><h1>Purchase Requisition Details</h1></center><br/><br/>\n");
      out.write("                    <div class = \"alignment\">    \n");
      out.write("                            <br/>\n");
      out.write("                            <br/>\n");
      out.write("                            <center>\n");
      out.write("                                PR Number : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \n");
      out.write("                                <select id = \"prnumberfield\" name = \"prnumberfield\" required style = \"width:150px\">\n");
      out.write("                                ");

                                    while(i.hasNext()) {
                                
      out.write("\n");
      out.write("                                <option>");
      out.print( i.next() );
      out.write("</option>\n");
      out.write("                                ");

                                    }
                                
      out.write("\n");
      out.write("                                </select>\n");
      out.write("                                <br/>\n");
      out.write("                                <br/>\n");
      out.write("                            </center>\n");
      out.write("                            <input type =\"Submit\" value =\"Get Status\" class=\"buttonalign\" >\n");
      out.write("                            <br/>\n");
      out.write("                            <br/>            \n");
      out.write("                    </div>\n");
      out.write("                </form>\n");
      out.write("            </article>\n");
      out.write("            \n");
      out.write("            <footer>Copyright &copy; Ayreon Dev Team</footer>\n");
      out.write("\n");
      out.write("        </div>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
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
