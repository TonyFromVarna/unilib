<%@page contentType="text/html"
        pageEncoding="UTF-8" session="true"
        import="libClient.*, rmiunilib.*"
%>
<%--
The taglib directive below imports the JSTL library. If you uncomment it,
you must also add the JSTL library to the project. The Add Library... action
on Libraries node in Projects view can be used to add the JSTL 1.1 library.
--%>
<%--
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
--%>

<jsp:useBean id="lib" scope="session" class="libClient.unilib"/>

<%
    String userLogin = request.getParameter( "username" );
    String login = (String) session.getAttribute("userLogin");
    
    response.setHeader("Pragma", "No-cache"); 
    response.setDateHeader("Expires", 0); 
    response.setHeader("Cache-Control", "no-cache"); 
    
    
    String goingFrom = request.getParameter( "comeFrom" );
//  String comeFrom = (String) session.getAttribute( "comeFrom" );
    String info           = request.getParameter( "info" );
    String inform       = (String) session.getAttribute( "info" );
    String[] nodeNames = lib.getNodesNames();
    String   back           = "search.jsp"; 
    if (goingFrom == null) {
        goingFrom = (String) session.getAttribute( "comeFrom" );
        if (goingFrom == null) { 
             back      = "search.jsp"; 
        }
        else {
             back  = goingFrom+".jsp";
        }
    }
    

    // session.setAttribute("comeFrom","searchResults"); // ????

    String alert = (String) session.getAttribute("alert");  // Feb 2008
    String warning = (String)session.getAttribute("alert");
    
    session.setAttribute( "alert", new String() );  // !!!!! clear for the next time
    
//    String resultCount = session.getAttribute("resultCount");
//    int numb           = lib.getRequestNumberBooks();  // ?????????
 %> 
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

   
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style.css" rel="stylesheet" type="text/css" />
        <title>UniLib loans list <%=  userLogin %></title>
         <!-- The size of JSP-dataSet (ArrayList <bookSet>) is <%=  lib.getRequestNumberBooks() %> results!!! -->
         <!-- There is an alert <%= alert %>  OR same shit warning  <%= warning %> -->
    </head>
    <!--body class="result" -->
     <%
 //  if (login == null || userLogin == null || login.equals("") || userLogin.equals("")) { 
    if (login == null || login.equals("") ) {
       %>
       <body class="login">
           <div class="wrong">
             <p><br><b>You have to login first!!!</b><br></p>
             <A HREF="index.jsp">Go back</A>
           </div>
         </body>
         </html> 
       <%
    }
    else {
        if (info != null) { %>
        <!-- The info is: <%= info %> -->
        
     <%     
        }
       if (inform != null) { %>
        <!-- The info from session is: <%= inform %> -->
     <%     
        }
       StringBuffer err =  new StringBuffer();
       lib.userLoans(login,err);
       int numb = lib.getRequestNumberBooks();
       if (err.length() > 0) { %>
         <body class="login">
            <div class="wrong">
              <p><b>Error - <%= err.toString() %> !</b></p>
              <p><a HREF="search.jsp">Go back</a></p>
            </div>
         </body>
      </html>  
      <%  
       }
       else {
            if ( numb == 0) {
                session.setAttribute("comeFrom","status");
       %>
          <body class="login">
             <div class="wrong">
               <p><b>No any loaned books for <%= login %>!</b></p><br><br>
               <p><A HREF="<%= back.trim() %>">Go back</A></p>
             </div>
          </body>
       </html> 
       <%    
            }
            else {
            
                bookSet[] res = new bookSet[numb];  
                res = lib.getResult();
                String tit;
                String auth;
                String genre;
                String publ;
                String nodeName;
                String loanDate;
           %>
              <!-- <%= "Nodes names array length"+nodeNames.length %> -->
              <body class="result">
                <form name="userstatus" method="POST" action="doReturnBooks.jsp">
                           
                 <table border="0" cellpadding="5" cellspacing="0" width="740" class="maintable">
                     <tr align="center" class="titletable">
                       <td>№</td><td>Title</td><td>Author</td><td>Loaned from</td><td>Location</td><td>Return</td>
                     </tr>
           <%
           for (int i=0;i<res.length;i++) {
               tit     =   res[i].getTitle();
               auth    =   res[i].getAuthor();
               if (auth == null) auth = "";
               genre =   res[i].getGenre();
               if (genre == null) genre = "";
               publ  =   res[i].getPublisher();
               if (publ == null) publ = "";
               // nodeName = nodesNames[res[i].getNodeID()];
               loanDate = res[i].getLoanDate();
               if (loanDate == null) loanDate = "";
               nodeName = "secret"; 
               int nodeIndex = res[i].getNodeID();
               
               try {
                   nodeName = nodeNames[res[i].getNodeID()];
                }
               catch (Exception ex) {
                   nodeName = "Exception: "+ex.getMessage();
               }
               %>
                 <!--  ********************* Node index is: <%= nodeIndex %>  *********************  -->
                 <tr align="left">
                   <td><%= (i+1) %></td>
                   <td><b> <%= tit %> </b></td>
                   <td>&nbsp; <%= auth %> </td>
                   <td>&nbsp; <%= loanDate %> </td>
                   <td>&nbsp; <%= nodeName %> </td>
                   <td><input type="checkbox" name="<%= "retID"+i %>" value="<%="retID"+i %>" style="width:25px; height:25px;" class="markbox"/></td>
                 </tr>   
            <%   
           }
           Integer count = new Integer(res.length);
           session.setAttribute( "resultCount", count );
           %>
            </tbody></table>
            </form>
             <br>
               <table border="0" cellpadding="5" cellspacing="0" >
                <tr>
                    <td class="back"><A HREF="<%= back.trim() %>">Go back</A></td>
                    <td class="back"><A HREF="javascript: document.userstatus.submit();">Continue</A></td>
                </tr>
              </table>
           
               
           <% 
          }
       }
    }
     if (alert != null && alert.length() > 0) {
       %>
             <script type="text/javascript">
                  alert ("<%= alert %>");
             </script>
       <% 
        }
    %>
   
    </body>
</html>
