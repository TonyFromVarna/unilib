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
   String userLogin  = (String)session.getAttribute("userLogin");
   String comesFrom  = (String)session.getAttribute("comeFrom");
   
   response.setHeader("Pragma", "No-cache"); 
   response.setDateHeader("Expires", 0); 
   response.setHeader("Cache-Control", "no-cache"); 
   
   int numb          = lib.getRequestNumberBooks();  // ?????????
   Integer count = (Integer)session.getAttribute("resultCount");  
   int sessionCount = count.intValue();
    
   session.setAttribute( "alert", new String() );  // Feb 2008
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Get <%= userLogin %> loans</title>
        <link href="style.css" rel="stylesheet" type="text/css" />
        <script language="javascript" src="forms.js" type="text/javascript"></script>
        <!-- There are <%=  sessionCount %> results from <%=  comesFrom %> -->
        <!-- The size of JSP-dataset (ArroyList) is <%=  lib.getRequestNumberBooks() %> results!!! -->
    </head>
    
<%
     if (userLogin.equals("")){ %>
        <body class="login">
          <div class="wrong">
             <p><b> Blank username!!! </b></p><br /><br />
             <p> <A HREF="index.jsp">Go back</A></p>
          </div> 
        </body>
   </html
<%
     }   
     if (sessionCount > 0) {
           int numbGet = 0;
           StringBuffer err = new StringBuffer();
           bookSet[] res = new bookSet[sessionCount];  
           res = lib.getResult();
           for (int i=0;i<sessionCount;i++) {
               String checkboxName = "getID"+i;
               if (request.getParameter("getID"+i) != null) {
                   lib.getBook(userLogin,res[i].getNodeID(),res[i].geID(),err);
                   numbGet++;
               }
           }
           if (numbGet == 0){ 
               String alert = "You not mark anything! Have to mark some for get!!";
               session.setAttribute( "alert", alert );
        %>
      <!--    <body class="login">
             <div class="wrong">
               <p><b> Have to get some book idiot!!! </b></p><br /><br />
               <p><A HREF="searchResults">Go back</A></p>
             </div> 
          </body>
      </html> --> 
             <script type="text/javascript">
                  alert ("You not mark anything! Have to mark some for get!!");
             </script>
             <jsp:forward page="searchResults.jsp">
                 <jsp:param name="comeFrom" value="<%= comesFrom %>"/>
                 
             </jsp:forward>
             
         <% 
           }
           else {
        %>
     <jsp:forward page="status.jsp">
        <jsp:param name="comeFrom" value="searchResults"/>
        <jsp:param name="info" value="There are <%= numbGet %> taken books!"/>
        <jsp:param name="resultsCount" value="<%= numbGet %>"/>
     </jsp:forward>
 <%
           }
     }
     else { // sessionCount == 0   ??????
    %>
        <body class="login">
          <div class="wrong">
             <p><b> Very strange case - how could it happen ?!? </b></p><br /><br />
             <p><A HREF="searchResults">Go back</A></p>
          </div> 
        </body>
   </html
   <%    
    }
 %>       %    
    }
 %>       