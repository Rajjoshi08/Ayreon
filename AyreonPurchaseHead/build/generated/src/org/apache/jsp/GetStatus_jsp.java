package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.Date;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.OutputStreamWriter;
import java.net.Socket;

public final class GetStatus_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


                   int prnumber; 
                   String str;
                   String query;
                   String prdescription;
                   String requestdate;
                   String materialcategory;
                   int value;
                   String status;
                   int[] materialcodes = new int[3];
                   int[] materialquantity = new int[3];
                
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
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <link rel=\"icon\" \n");
      out.write("              type=\"image/png\" \n");
      out.write("              href=\"logo.png\">\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"ayreonstyle.css\">\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Ayreon - Get PR</title>\n");
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

                    str = (String)request.getParameter("prnumberfield");
                    if(str != null) {
                        prnumber = Integer.parseInt(str);
                    }
                    Socket soc = new Socket("192.168.43.182",9978);
                    query = "select description,requestdate,materialcategory,orderid,estimatedvalue,status from requisitiondtls where prnumber = ?";
                    ObjectOutputStream oos = new ObjectOutputStream((soc.getOutputStream()));
                    oos.writeObject(query);
                    oos.writeObject(prnumber);
                    ObjectInputStream ois = new ObjectInputStream(soc.getInputStream());
                    prdescription = (String)ois.readObject();
                    requestdate = ois.readObject().toString();
                    materialcategory = ois.readObject().toString();
                    value = Integer.parseInt(ois.readObject().toString());
                    status = ois.readObject().toString();
                    materialcodes = (int[])ois.readObject();
                    materialquantity = (int[])ois.readObject();
                    soc.close();
                
      out.write("\n");
      out.write("                <form>\n");
      out.write("                    <center><h1>Purchase Requisition Details</h1><br/><br/>    \n");
      out.write("                        <table class=\"tableborder\">\n");
      out.write("                            <tr>\n");
      out.write("                                <th>PR Number</th>\n");
      out.write("                                <td>");
      out.print(prnumber);
      out.write("</td>\n");
      out.write("                            </tr>\n");
      out.write("                            <tr>\n");
      out.write("                                <th>Requested By</th>\n");
      out.write("                                <td>");
      out.print(application.getAttribute("Requested By"));
      out.write("</td>\n");
      out.write("                            </tr>\n");
      out.write("                            <tr>\n");
      out.write("                                <th>Description</th>\n");
      out.write("                                <td>");
      out.print(prdescription);
      out.write("</td>\n");
      out.write("                            </tr>\n");
      out.write("                            <tr>\n");
      out.write("                                <th>Request Date</th>\n");
      out.write("                                <td>");
      out.print(requestdate);
      out.write("</td>\n");
      out.write("                            </tr>\n");
      out.write("                            <tr>\n");
      out.write("                                <th>Material Category</th>\n");
      out.write("                                <td>");
      out.print(materialcategory);
      out.write("</td>\n");
      out.write("                            </tr>\n");
      out.write("                            <tr>\n");
      out.write("                                <th>Estimated Value</th>\n");
      out.write("                                <td>");
      out.print(value);
      out.write("</td>\n");
      out.write("                            </tr>\n");
      out.write("                            <tr>\n");
      out.write("                                <th>Status</th>\n");
      out.write("                                <td>");
      out.print(status);
      out.write("</td>\n");
      out.write("                            </tr>\n");
      out.write("                        </table>\n");
      out.write("                        <br/>\n");
      out.write("                        <b>Material Details: </b>\n");
      out.write("                        <table class=\"tableborder\" style=\"width:150px;\">\n");
      out.write("                            <tr>\n");
      out.write("                                <th>Code</th>\n");
      out.write("                                <th>Quantity</th>\n");
      out.write("                            </tr>\n");
      out.write("                            ");

                                for(int i = 0; i < materialcodes.length; i++) {
                                    if(materialcodes[i] != 0) {
                            
      out.write("\n");
      out.write("                            <tr>\n");
      out.write("                                <td>");
      out.print(materialcodes[i]);
      out.write("</td>\n");
      out.write("                                <td>");
      out.print(materialquantity[i]);
      out.write("</td>\n");
      out.write("                            </tr>\n");
      out.write("                            ");

                                    }
                                }
                            
      out.write("\n");
      out.write("                        </table>\n");
      out.write("                        <br>\n");
      out.write("                    </center>\n");
      out.write("                    <input type=\"submit\" value=\"Back\" class = \"buttonalign1\" formaction=\"PRStatus.jsp\"> \n");
      out.write("                    <br/>\n");
      out.write("                    <br/>\n");
      out.write("                    <br/>\n");
      out.write("                    <br/>\n");
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
