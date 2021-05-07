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
    String login = (String) session.getAttribute("userLogin");
    
    response.setHeader("Pragma", "No-cache"); 
    response.setDateHeader("Expires", 0); 
    response.setHeader("Cache-Control", "no-cache"); 
    // ************************************
    
    String tit = request.getParameter( "title" ); 
    session.setAttribute("comeFrom", "search" );
 %> 

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>UniLib post search</title>
        <link href="style.css" rel="stylesheet" type="text/css" />
    </head>
    <%
    if (login == null ||  login.equals("") ) { //||userLogin == null || userLogin.equals("")) {
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
        if ( tit.equals("") || tit == null ) { 
      %>
         <body class="login">
         <div class="wrong">
             <p><b> Blank Title! </b></p><br /><br />
             <p><A HREF="search.jsp">Go back</A></p>
           </div>
         </body>
         </html> 
     <%
        }
        else {
            String author = "";
            String genre = "";
            String publ = "";
            StringBuffer err = new StringBuffer();
            int[] types = null;
//         public void searchBook(String mName, String mAuthor, int[] mType, String mGenre, String mPublisher, String errorMessage)       
            lib.searchBook(tit,author,types,genre,publ,err);
//          int numb = lib.getNumberFound();
            int numb = lib.getRequestNumberBooks();   
            if (err.length() > 0) {
     %>
          <body class="login">
            <div class="wrong">
                <br><b> Error!!! </b><u> <%= err.toString() %> </u><br>
                <A HREF="search.jsp">Go back</A>
            </div>         
          </body>
         </html> 
     <%
            }
            if (numb > 0) {
     %>
     <jsp:forward page="searchResults.jsp">
        <jsp:param name="title" value="<%= tit %>"/>
        <jsp:param name="comeFrom" value="search"/>
        <jsp:param name="resultsCount" value="<%= numb %>"/>
     </jsp:forward>
     <%
            }
            else {
       %>
        <body class="login">
          <div class="wrong">
            <p><b>Nothing found with search for title: <%= tit %>!</b></p><br /><br />
            <p><a HREF="search.jsp">Go back</a></p>
          </div>
         </body>
         </html> 
    <% 
            }
        }
    }  
    %>    
