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

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="lib" scope="session" class="libClient.unilib"/>
<%
    String name1st   = request.getParameter( "firstname" );
    String name2nd   = request.getParameter( "lastname" );
    String userLogin = request.getParameter( "login" );
    String userPass  = request.getParameter( "passwd" );
    String rePasswd  = request.getParameter( "repass" );
    String addr      = request.getParameter( "address" );
    String mail      = request.getParameter( "email" );
    StringBuffer errMessage = new StringBuffer();
//  String insLog    = lib.getUserLogin();
//  String insPass   = lib.getUserPassword(); 
    
    session.setAttribute( "userLogin", new String() ); // Feb 2008
 %> 

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>UniLib login check</title>
        <link href="style.css" rel="stylesheet" type="text/css" />
    </head>
    <!-- POST params are: -->
    <!-- ************************************************* -->
    <!-- Names first - last <%= name1st %> - <%= name2nd %> -->
    <!-- UserLogin: <%= userLogin %>; address is:  <%= addr %>; Email is: <%= mail %> -->
    <%
     // String userLogin = request.getParameter( "username" );
     // String userPass = request.getParameter( "pass" );
     //if ( userPass.equals("") || userLogin.equals("") || name1st.equals("") || 
     //      (!userPass.equals(rePasswd))
      if ( userPass == null || userLogin == null || userPass.equals("") || userLogin.equals("") || name1st == null || 
        (!userPass.equals(rePasswd))
        ){
        %>
         <body class="login">
           <div class="wrong">
         <% 
           if (userLogin == null || userLogin.equals("")) {  %> 
               <p><b> Blank Login </b></p><br>
           <%
           }   
           if (userPass == null ||userPass.equals("")){ %> 
               <p><b> Blank Password </b></p><br> 
           <%
           }
           if ((userPass==null && rePasswd == null) || !userPass.equals(rePasswd) ) { %>
               <p><b> Passwords are not same!</b></p><br>
           <%   
           }
           %>
           <br> <A HREF="regform.jsp">Go back</A><br>
           </div>
     <%
     }
     else {
       lib.addUser(userLogin,userPass,name1st,name2nd,addr,mail,errMessage);
     if (errMessage.length() > 0) {%>
         <body class="login">
           <div class="wrong">
           <p> Error!!! </b><u><%= errMessage.toString() %> </p><br /><br />
           <A HREF="regform.jsp">Go back</A>
       <%
       }
      else {
        session.setAttribute( "userLogin", userLogin );
        session.setAttribute( "userPass", userPass );
        if ( lib.validUser(userLogin, userPass) ){
         // out.println( "<br><b> Success!! </b><br>" );
           
     %>
    <p> Welcome: <b><%= userLogin %></b></p>
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
           <p><b>Registration problem - try again!</b></p><br /><br />
        <!--   <p>You enter name: <%= userLogin %></p><br><br> -->
             <A HREF="regform.jsp">Go back</A>
           </div>
           </body>
         </html> 
         <%
         }
      }
     }
    %>    
 </body>
</html>
