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

<jsp:useBean id="lib" scope="session" class="libClient.unilib"/>

<%
    String userLogin = request.getParameter( "username" );
    String login = (String) session.getAttribute("userLogin");
    response.setHeader("Pragma", "No-cache"); 
    response.setDateHeader("Expires", 0); 
    response.setHeader("Cache-Control", "no-cache"); 
    
//  session.setAttribute( "alert", new String() );
     session.setAttribute("comeFrom", "adsearch" );
    // ************************************
    String tit  = "";
    String author = "";
    String subject = "";
    String keywors = "";
    String publ = "";
    String genre = "";
    
    if(request.getParameter("useTitle") != null) {
        tit = request.getParameter( "title" );
    }
    if(request.getParameter("useAuth") != null) {
        author   = request.getParameter( "author" );
    }
    
    if(request.getParameter("useSubj") != null) {
        subject  = request.getParameter( "subject" );
    }
    
    if(request.getParameter("usePub") != null) {
        publ = request.getParameter( "publisher" );
    }
    
    if(request.getParameter("useKey") != null) {
        keywors = request.getParameter( "keys" );
    }
    
    int[] mTypes   = new int[6];
    int typesCount = 0;
            
    
    
    if(request.getParameter("books") != null){
        mTypes[0] = 1;
        typesCount+=1;
    }
    else {
        mTypes[0] = 0;
    }
    
    if(request.getParameter("journals") != null){
        mTypes[1] = 2;  
        typesCount+=1;
    }    
    else {
        mTypes[1] = 0;
    }
    
    if(request.getParameter("magazines") != null){
        mTypes[2] = 3;  
        typesCount+=1;
    }    
    else {
        mTypes[2] = 0;
    }
    
    if(request.getParameter("news") != null){
        mTypes[3] = 4;  
        typesCount+=1;
    }    
    else {
        mTypes[3] = 0;
    }
    
    if(request.getParameter("enc") != null){
        mTypes[4] = 5;  
        typesCount+=1;
    }    
    else {
        mTypes[4] = 0;
    }
    
    if(request.getParameter("cd") != null){
        mTypes[5] = 6;  
        typesCount+=1;
    }    
    else {
        mTypes[5] = 0;
    } 
   
    if (typesCount > 0) {
        for (int j=0;j<mTypes.length;j++) {
%>
                    <!-- type[<%= (j+1) %>] = <%= mTypes[j] %> -->
              <%
        }
    }
    
 %>
 
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>UniLib advanced search</title>
        <link href="style.css" rel="stylesheet" type="text/css" />
    </head>
     <!-- Marked types number is: [<%=  typesCount %> !!! -->
   <%
      
    if (login == null || login.equals("")) { // || userLogin == null || userLogin.equals("")) {
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
     if (tit.equals("") && author.equals("") && subject.equals("") && publ.equals("") ){ 
    %>
}
        <body class="login">
          <div class="wrong">
             <p><b> Please add something to search ! </b></p><br /><br />
             <p> <A HREF="adsearch.jsp">Go back</A></p>
          </div>
         </body>
     </html>    
     <%
     }   
     else {
    // public void searchBook(bookSet[] result, String mName, String mAuthor, int[] mType, String mGenre, String mPublisher, String errorMessage)
//     bookSet[] res;
       //String err = "";
       StringBuffer err = new StringBuffer();
       int[] types;  
       if (typesCount == 0) types = null;
       else types = mTypes;
       
       // types = null;
       
       try {
           genre = subject;
           lib.searchBook(tit,author,types,genre,publ,err);
       }
       catch (Exception ex) { %>
           <body class="login">
            <div class="wrong">
               <p><b> Exception!!! </b><u> <%= ex.getMessage() %> </u></p><br>
               <br> <A HREF="adsearch.jsp">Go back</A><br>
          </div>
         </body>
     </html>
       <%    
       }
       int numb = lib.getRequestNumberBooks();
       if (err.length() > 0) { %>
         <body class="login">
            <div class="wrong">
              <p><b>Error - <%= err.toString() %> !</b></p>
              <p><a HREF="adsearch.jsp">Go back</a></p>
            </div>
         </body>
      </html>       
       <%
       }
       if (numb > 0) {
      %>
     <jsp:forward page="searchResults.jsp">
        <jsp:param name="title" value="<%= tit %>"/>
        <jsp:param name="comeFrom" value="adsearch"/>
        <jsp:param name="resultsCount" value="<%= numb %>"/>
     </jsp:forward>
     <%
      }
       else {  %>
           <body class="login">
             <div class="wrong">
                <p><b>Nothing found with your search!</b></p><br /><br />
                <p><a HREF="adsearch.jsp">Go back</a></p>
             </div>
          </body>
        </html>      
       <%
       } 
     }
    %>            
    </body>
</html>
<%
  }
%> 
  