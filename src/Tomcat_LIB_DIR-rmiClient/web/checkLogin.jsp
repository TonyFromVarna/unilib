<%@page contentType="text/html"
        pageEncoding="UTF-8" session="true"
        import="libClient.*"
 %>
<%--
The taglib directive below imports the JSTL library. If you uncomment it,
you must also add the JSTL library to the project. The Add Library... action
on Libraries node in Projects view can be used to add the JSTL 1.1 library.
--%>
<%--
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="lib" scope="session" class="libClient.unilib"/>

<%
     String userLogin = request.getParameter( "username" );
     String userPass  = request.getParameter( "pass" );
//     String insLog   = lib.getUserLogin();
//     String insPass  = lib.getUserPassword();
 %>
 
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>UniLib login check</title>
        <link href="style.css" rel="stylesheet" type="text/css" />
    </head>    
    <%
     // String userLogin = request.getParameter( "username" );
     // String userPass = request.getParameter( "pass" );
     if (userPass.equals("") || userLogin.equals("") ){
     %>
         <body class="login">
           <div class="wrong">
         <%    
         if (userLogin.equals("")){  %>
             <p><b> Blank Login </b></p>
         <%
         }
         if (userPass.equals("")){  %>
             <p><b> Blank password </b></p><br /><br />
         <%
         } 
         %>   
             <p> <A HREF="index.jsp">Go back</A></p>
           </div>
         </body>
         </html> 
     <%     
     }
     else {
       session.setAttribute( "userLogin", userLogin );
       session.setAttribute( "userPass", userPass );
       if ( lib.validUser(userLogin, userPass) ){
           session.setAttribute( "userLogin", userLogin );
           session.setAttribute( "userPass", userPass );
       ////// if ( lib.validUser() ){
       //      out.println( "<br><b> Success!! </b><br>" );
    %>    
     <jsp:forward page="search.jsp">
        <jsp:param name="login" value="<%= userLogin %>"/>
        <jsp:param name="pass" value="<%= userPass %>"/>
     </jsp:forward>
     <%
     }
      else {
         %>
         <body class="login">
           <div class="wrong">
             <p><br><b>WRONG USERNAME/PASSWORD!!</b><br></p>
             <p>You enter name: <%=  userLogin %></p><br><br>
             <A HREF="index.jsp">Go back</A>
           </div>
         </body>
         </html> 
      <%
      }
   }       
    %>
