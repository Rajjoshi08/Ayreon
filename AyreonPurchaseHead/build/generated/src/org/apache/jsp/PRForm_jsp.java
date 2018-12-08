package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.sql.PreparedStatement;
import java.util.Iterator;
import java.util.ArrayList;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.sql.ResultSet;
import java.io.ObjectOutputStream;
import java.io.ObjectInputStream;
import java.net.Socket;

public final class PRForm_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


            ArrayList list, selectedmaterialcodes;
            HashMap materialcodelist,userdtls;
            Iterator i, i1;
            ObjectOutputStream oos;
            ObjectInputStream ois;
            int prnumber;
            String category = "ABC";
            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");  
            Date currentdate = new Date();
            String requestdate = "";
            String username = "";
            String requestedby = "";
        
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
      out.write("        <title>Ayreon - Create PR</title>\n");
      out.write("        <script type =\"text/javascript\" language = \"JavaScript\">\n");
      out.write("            var rowcount = 1;\n");
      out.write("            function addrow() {\n");
      out.write("                if(rowcount !== 3) {\n");
      out.write("                    var table = document.getElementById(\"orderdtls\");\n");
      out.write("                    var lastrow = table.rows.length;\n");
      out.write("                    var row = table.insertRow(lastrow);\n");
      out.write("                    var cell1 = row.insertCell(0);\n");
      out.write("                    var element1 = document.createElement('input');\n");
      out.write("                    element1.type = 'number';\n");
      out.write("                    element1.name = 'code';\n");
      out.write("                    cell1.appendChild(element1);\n");
      out.write("                    var cell2 = row.insertCell(1);\n");
      out.write("                    var element2 = document.createElement('input');\n");
      out.write("                    element2.type = 'number';\n");
      out.write("                    element2.name = 'quantity';\n");
      out.write("                    cell2.appendChild(element2);\n");
      out.write("                    var cell3 = row.insertCell(2);\n");
      out.write("                    var element3 = document.createElement('input');\n");
      out.write("                    element3.type = 'button';\n");
      out.write("                    element3.value = 'Add Row';\n");
      out.write("                    element3.onclick = 'addrow()';\n");
      out.write("                    cell3.appendChild(element3);\n");
      out.write("                    rowcount++;\n");
      out.write("                }\n");
      out.write("            }\n");
      out.write("        </script>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        ");
      out.write("\n");
      out.write("        ");

            requestedby = session.getAttribute("Requested By").toString();
            
            //retrieving pr number
            Socket s = new Socket("192.168.43.182",9999);
            oos = new ObjectOutputStream(s.getOutputStream());
            String getPRNumber = "select max(prnumber) as maxpr from requisitiondtls";
            oos.writeObject(getPRNumber);
            ois = new ObjectInputStream(s.getInputStream());
            prnumber = Integer.parseInt(ois.readObject().toString());
            application.setAttribute("PRNumber", prnumber);
            s.close();
            requestdate = formatter.format(currentdate);
            application.setAttribute("Request Date", requestdate);

            //retrieving category
            Socket soc = new Socket("192.168.43.182",9999);
            oos = new ObjectOutputStream(soc.getOutputStream());
            String getCategory = "select category from categorymaster";
            oos.writeObject(getCategory);
            ois = new ObjectInputStream(soc.getInputStream());
            list = (ArrayList)ois.readObject();
            i = list.iterator();
            soc.close();

            //creating hashmap
            Socket newsoc = new Socket("192.168.43.182",51412);
            oos = new ObjectOutputStream(newsoc.getOutputStream());
            String getMaterialCodes = "select materialnumber,materialcategory from mara";
            oos.writeObject(getMaterialCodes);
            ois = new ObjectInputStream(newsoc.getInputStream());
            materialcodelist = (HashMap)ois.readObject();
            session.setAttribute("MaterialCodeList", materialcodelist);
            newsoc.close();
        
      out.write("\n");
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
      out.write("                <form action = \"SubmitPR.jsp\" method = \"POST\">\n");
      out.write("                        <h1 class=\"pr\">Purchase Requisition Form</h1><br/><br/>\n");
      out.write("                    <div class = \"alignment\">\n");
      out.write("                    PR Number : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type = \"number\" required id = \"prnumberfield\" name = \"prnumberfield\" value = \"");
      out.print(prnumber);
      out.write("\" disabled = \"yes\"><br/><br/>\n");
      out.write("                    Date of Request : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type = \"date\" required id = \"requestdate\" name = \"requestdate\" value = \"");
      out.print(requestdate);
      out.write("\" disabled = \"yes\"><br/><br/>\n");
      out.write("                    Purchase Head Contact: &nbsp;&nbsp;&nbsp;&nbsp;<input type = \"email\" required id = \"contact\" name = \"contact\" disabled=\"yes\" value=\"");
      out.print(requestedby);
      out.write("\"><br/><br/>\n");
      out.write("                    PR Description : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <textarea rows = \"4\" cols = \"50\" id = \"description\" name = \"description\"></textarea><br/><br/>\n");
      out.write("                    Material Category : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \n");
      out.write("                    <select id = \"materialdropdown\" name = \"materialdropdown\">\n");
      out.write("                        ");

                            while(i.hasNext()) {
                        
      out.write("\n");
      out.write("                        <option>");
      out.print( i.next() );
      out.write("</option>\n");
      out.write("                        ");

                            }
                        
      out.write("\n");
      out.write("                    </select><br/><br/>\n");
      out.write("                    Material Details : <br/><br/>\n");
      out.write("                    <table class = \"tableborder\" id = \"orderdtls\" name = \"orderdtls\">\n");
      out.write("                        <tr>\n");
      out.write("                            <th>Code</th>\n");
      out.write("                            <th>Quantity</th>\n");
      out.write("                            <th> </th>\n");
      out.write("                        </tr>\n");
      out.write("                        <tr>\n");
      out.write("                            <td><input type = \"number\" id = \"code\" name = \"code\" required></td>\n");
      out.write("                            <td><input type = \"number\" id = \"quantity\" name = \"quantity\" required></td>\n");
      out.write("                            <td><input type = \"button\" onclick = \"addrow()\" value = \"Add Row\"></td>\n");
      out.write("                        </tr>\n");
      out.write("                    </table>\n");
      out.write("                    <br/><br/>\n");
      out.write("                    Estimated Value : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type = \"number\" required id = \"value\" name = \"value\"><br/><br/>\n");
      out.write("                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type =\"Submit\" value =\"Submit\" class=\"submit1\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type =\"reset\" value =\"Reset\" class=\"reset1\">\n");
      out.write("                    <br/><br/><br/>\n");
      out.write("                    </div>\n");
      out.write("                </form>\n");
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
