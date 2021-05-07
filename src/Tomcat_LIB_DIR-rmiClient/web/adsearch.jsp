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
     
     session.setAttribute( "alert", new String() );
     session.setAttribute("comeFrom", "adsearch" );
%>

<html>
<head>
<title>Online Library</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<script  language = "Javascript">
/**
 * DHTML resetting image button forms script. Courtesy of SmartWebby.com (http://www.smartwebby.com/dhtml/)
 */

function ResetForm(which){
var pass=true
var first=-1
if (document.images){
for (i=0;i<which.length;i++){
var tempobj=which.elements[i]
 if (tempobj.type=="text"){
  eval(tempobj.value="")
  if (first==-1) {first=i}
 }
 else if (tempobj.type=="checkbox") {
  eval(tempobj.checked=0)
  if (first==-1) {first=i}
 }
 else if (tempobj.col!="") {
  eval(tempobj.value="")
  if (first==-1) {first=i}
 }
}
}
which.elements[first].focus()
return false
}
</script>
</head>

 <%
//  if (login == null || userLogin == null || login.equals("") || userLogin.equals("")) {
    if (login == null || login.equals("")) { 
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

<form name="adsearch" method="POST" action="doAdvSearch.jsp">
<table border="0" cellpadding="0" cellspacing="0" width="800">
<tr id="hg"> 
    <td width="440">&nbsp;</td>
    <td width="115">&nbsp;</td>
    <td width="115">&nbsp; Welcome: <b><%=  login %></b></td>
    <td width="166">&nbsp;</td>
</tr>
<tr>
  <td colspan="4">
    <ul id="topnav">
          <li class="search"><a href="search.jsp"></a></li>
          <li class="adsearch_sel"><a href="adsearch.jsp"></a></li>
          <li class="status"><a href="status.jsp"></a></li>
     </ul>
  </td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td colspan="3" class="adlibrary">Advanced Search </td>
</tr>
<tr>
<td>&nbsp;</td>
<td colspan="3" class="column" align="right">
Title: &nbsp; <input type="text" name="title" class="box">
<input type="checkbox" name="useTitle" value="use1" style="width:25px; height:25px;" class="markbox" />
<br />
Author: &nbsp; 
<input type="text" name="author" class="box">
<input type="checkbox" name="useAuth" value="use2" style="width:25px; height:25px;" class="markbox" />
<br />
Subject: &nbsp; 
<input type="text" name="subject" class="box">
<input type="checkbox" name="useSubj" value="use3" style="width:25px; height:25px;" class="markbox" />
<br />
Publisher: &nbsp; 
<input type="text" name="publisher" class="box">
<input type="checkbox" name="usePub" value="use4" style="width:25px; height:25px;" class="markbox" />
<br />
Keywords &nbsp; 
<input type="text" name="keys" class="box">
<input type="checkbox" name="useKey" value="use5" style="width:25px; height:25px;" class="markbox" />
<br />
</td>
</tr>
<tr>
<td colspan="4">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
     <td class="admedia" colspan="3">
        Media Types
    </td>
</tr>
<tr>
   <td class="books"><input type="checkbox" name="books" checked> Books<br></td>
   <td class="journal"><input type="checkbox" name="journals"> Journals<br></td>
   <td class="journal"><input type="checkbox" name="magazines"> Magazines<br></td>
</tr>
<tr>
   <td class="books"><input type="checkbox" name="news"> Newspapers<br></td>
   <td class="journal"><input type="checkbox" name="enc"> Encyclopedia<br></td>
   <td class="journal"><input type="checkbox" name="cd"> CD/DVD <br></td>
</tr>
</table>
</td>
</tr>
<tr>
<td>&nbsp;</td>
<td>
  <input class="button" type="image" value="submitname" src="image/1.png" width="130" height="36" border="0" alt="SUBMIT!" name="image">
</td>
<!--
<td><input class="clear" type="image" onSubmit="return ResetForm(this)" border="0" name="imgReset" src="image/clear.png" width="130" height="36"></td>
-->
  <td><button type="reset" class="clear"></td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td class="logsearch"><a href="index.jsp" alt="">logout</a></td>
</tr>
</table>
</form>
</body>
</html>
<%
   }
 %>
