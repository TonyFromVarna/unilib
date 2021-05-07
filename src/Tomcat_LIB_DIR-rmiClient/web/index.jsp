<%@page language="java" contentType="text/html"
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

<% 
    // session.invalidate();
    response.setHeader("Pragma", "No-cache"); 
    response.setDateHeader("Expires", 0); 
    response.setHeader("Cache-Control", "no-cache"); 
    
    session.setAttribute( "userLogin", new String() );       // Feb 2008
    session.setAttribute("comeFrom", "index.jsp" );
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="lib" scope="session" class="libClient.unilib"/>
<% 
    // session.invalidate();
    if (!lib.isConnected() ) {
        %>
<html>
     <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>UniLib login</title>
        <link href="style.css" rel="stylesheet" type="text/css" />
     </head>
        <body class="non">
              <p>Sorry!!!</p>
         </body>
</html>
        <% 
    }    
    else {
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>UniLib login</title>
        <link href="style.css" rel="stylesheet" type="text/css" />
    </head>

    <body class="login">
    <form name="login" method="POST" action="checkLogin.jsp">
    <table border="0" cellpadding="0" cellspacing="0" width="800">
      <tr>
         <td colspan="3" height="130"></td>
      </tr>
      <tr>
         <td width="55%">&nbsp;</td>
         <td width="34%" class="logo">&nbsp;</td>
         <td width="11%">&nbsp;</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="name">
                 User name: <input type="text" name="username" class="user"><br/>
                 Password: <input type="password" name="pass" class="user">
         </td>
         <td>&nbsp;</td>
       </tr>
       <tr>
         <td>&nbsp;</td>
         <td>
           <input class="butLogin" type="image" value="submitname" src="image/login.png" width="130" height="36" border="0" alt="SUBMIT!" name="image">
         </td>
         <td>&nbsp;</td>
       </tr>
       <tr align="center">
         <td>&nbsp;</td>
         <td class="reg"><a href="regform.jsp">Registration</a>&nbsp;</td>
         <td>&nbsp;</td>
       </tr>
        <tr align="center">
         <td colspan="3">Info: <%= lib.getInfo() %></td>
       </tr>
    </table>
    </form>
    </body>
</html>        
<% 
    }    
%>
