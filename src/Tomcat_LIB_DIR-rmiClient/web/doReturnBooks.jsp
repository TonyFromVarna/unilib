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

   int numbRet     = 0;
   
   Integer count = (Integer)session.getAttribute("resultCount");
   int sessionCount = count.intValue();
   
 
   if (sessionCount == 0) { // Added 20 Feb 2008
       sessionCount = numb;
   }
   
   String warning = (String)session.getAttribute("alert");
   session.setAttribute( "alert", new String() );
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Get <%= userLogin %> loans</title>
        <link href="style.css" rel="stylesheet" type="text/css" />
        <script language="javascript" src="forms.js" type="text/javascript"></script>
        <!-- There are <%=  sessionCount %> results from <%=  comesFrom %> -->
        <!-- The size of JSP-dataset (ArroyList) is <%=  lib.getRequestNumberBooks() %> results!!! -->
        <!-- There is an alert <%=  warning %>  -->
        
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
          
           StringBuffer err = new StringBuffer();
           //String err = "";
           String allErrors = "";
           bookSet[] res = new bookSet[sessionCount];  
           res = lib.getResult();
           for (int i=0;i<sessionCount;i++) {
           //for (int i=0;i<res.length;i++) {    
               String checkboxName = "retID"+i;
               //if (request.getParameter(checkboxName.trim()) != null) {
               if (request.getParameter("retID"+i) != null) {
                   lib.returnBook(userLogin,res[i].getNodeID(),res[i].geID(),err);
                   if (err.length() > 0) {
                       allErrors +=err.toString()+"\n";
                       %>
                          <script type="text/javascript">
                              alert ("<%= err.toString() %>")
                          </script>    
                       <%
                   }
                   numbRet++;
               }
           }
           String info = "There are " +  numbRet + " returned books!";
           session.setAttribute( "info", info );
           if (!allErrors.equals("")) {
               session.setAttribute( "errorsInfo", allErrors );
           }
           if (numbRet == 0){ 
                String nothingCheck = "Have to mark something for return "+userLogin+"!!!";
                session.setAttribute( "alert", nothingCheck );
           %>
                <script type="text/javascript">
                         alert ("Have to mark some books for return!!!");
                 </script>
         <% 
           }
           // String info           = request.getParameter( "info" );  // status.jsp
           String information = "There are " +  numbRet + " returned books!";
        %>
     <jsp:forward page="status.jsp">
        <jsp:param name="comeFrom" value="status"/>
        <jsp:param name="info" value="There are <%= numbRet %> returned books!"/>
        <jsp:param name="resultsCount" value="<%= numbRet %>"/>
     </jsp:forward>
 <%
    }
    //else { // sessionCount == 0   ??????
   
   // }
 %>       