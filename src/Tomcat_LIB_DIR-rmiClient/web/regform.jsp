<%@page language="java" contentType="text/html"
    pageEncoding="UTF-8"  session="true"
    import = "libClient.*"
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
     response.setHeader("Pragma", "No-cache"); 
     response.setDateHeader("Expires", 0); 
     response.setHeader("Cache-Control", "no-cache"); 
     
     session.setAttribute( "userLogin", new String() ); // Feb 2008
     session.setAttribute( "alert", new String() );
     session.setAttribute("comeFrom", "registration.jsp" );
%>

<html>
<head>
<title>Online Library</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<script src="js/check1.js" type="text/javascript"></script>
</head>
<body class="login">
<form name="regform" method="POST" action="regisration.jsp">
<table border="0" cellpadding="0" cellspacing="0" width="800">
<tr>
   <td colspan="3" height="130"></td>
</tr>
<tr>
   <td width="55%">&nbsp;</td>
   <td width="38%" class="form">&nbsp;</td>
   <td width="7%">&nbsp;</td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td class="name">
    
    First name: <b class="sor">*</b> &nbsp; <input type="text" name="firstname" class="user"><br />
    Last name: <b class="sor">*</b>&nbsp;<input type="text" name="lastname" class="user"><br />
    User name: <b class="sor">*</b>&nbsp;<input type="text" name="login" class="user"><br />
    Pass: <b class="sor">*</b>&nbsp;<input type="password" name="passwd" class="user"><br />
    Pepeat Pass: <b class="sor">*</b>&nbsp;<input type="password" name="repass" class="user"><br />
    Address: &nbsp; <input type="text" name="address" class="user"><br />
    e-mail: &nbsp;<input type="text" name="email" class="user"><br />
  </td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td><input class="butsubmit" type="image" onclick="check_all();" value="submitname" src="image/submit.png" width="130" height="36" border="0" alt="SUBMIT!" name="image"></td>
  <td>&nbsp;</td>
</tr>
</table>
</form>
</body>
</html>
