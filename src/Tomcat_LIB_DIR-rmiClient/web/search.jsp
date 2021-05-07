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

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
   
<jsp:useBean id="lib" scope="session" class="libClient.unilib"/>

<%
     String userLogin = request.getParameter( "username" );
     String login = (String) session.getAttribute("userLogin");
     response.setHeader("Pragma", "No-cache"); 
     response.setDateHeader("Expires", 0); 
     response.setHeader("Cache-Control", "no-cache"); 
     
     session.setAttribute( "alert", new String() );  // Feb 2008 
     session.setAttribute("comeFrom", "search" );
%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Online Library</title>
     <link href="style.css" rel="stylesheet" type="text/css" />
 </head>
 
  <%
    if (login == null || login.equals("")) { //|| userLogin == null || userLogin.equals("")) {
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
 %> 
 <body>
 <form name="search" method="POST" action="doSearch.jsp">
 <table border="0" cellpadding="0" cellspacing="0" width="800">
 <tr id="hg"> 
    <td width="440">&nbsp;</td>
    <td width="115">&nbsp;</td>
    <td width="115">&nbsp; Welcome: <b><%= login %></b></td>
    <td width="166">&nbsp;</td>
 </tr>
 <tr> 
 <td colspan="4">
    <ul id="topnav">
          <li class="search_sel"><a href="search.jsp"></a></li>
          <li class="adsearch"><a href="adsearch.jsp"></a></li>
          <li class="status"><a href="status.jsp"></a></li>
     </ul>
  </td>
 </tr> 
 <tr>
  <td>&nbsp;</td>
  <td colspan="3" class="library">Search the library</td>
 </tr>
 <tr align="center">
<td>&nbsp;</td>
<td colspan="3">
 <input type="text" name="title" class="spole" />
 <input class="button" type="image" value="submitname" src="image/1.png" width="130" height="36" border="0" alt="SUBMIT!" name="image"> 
</td>
 </tr>
 <tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td class="logout"><a href="index.jsp" alt="">logout</a></td>
 </tr>
</table>
</form>
</body>
</html>
<%
  }
 %>