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
   String userLogin = (String)session.getAttribute("userLogin");

   response.setHeader("Pragma", "No-cache"); 
   response.setDateHeader("Expires", 0); 
   response.setHeader("Cache-Control", "no-cache"); 
   
   String title     = request.getParameter( "title" );
   String resCount  = request.getParameter( "resultsCount" );
   String goingFrom = request.getParameter( "comeFrom" );
   if (goingFrom == null) {
       goingFrom = (String)session.getAttribute("comeFrom");
       if (goingFrom == null) {
           goingFrom = "search";
       }
   }
   String back      = goingFrom+".jsp";
   int resNumber    = lib.getRequestNumberBooks();
   String[] nodeNames = lib.getNodesNames();
   // session.setAttribute("comeFrom","searchResults");

   // Added 15/Jan/2008
   response.setHeader("Pragma", "No-cache"); 
   response.setDateHeader("Expires", 0); 
   response.setHeader("Cache-Control", "no-cache"); 
   
   String alert = (String)session.getAttribute("alert");
 %> 
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>UniLib search results for <%=  userLogin %></title>
        <link href="style.css" rel="stylesheet" type="text/css" />
        <script language="javascript" src="forms.js" type="text/javascript"></script>
	<script type="text/javascript" src="js/inc.js"></script>
        <!-- The size of JSP-dataSet (ArrayList <bookSet>) is <%=  resNumber %> results!!! -->
        <!-- The alert session param is: <%=  alert %> !! -->
    </head>
    
    <body class="result">

    <script type="text/javascript">
/* <![CDATA[ */

var tid = null;

function openl(o, minW, maxW, f){

	if(f && o.offsetWidth <= maxW)
	{
			clearTimeout(tid);
			o.style.width = o.offsetWidth + maxW/o.offsetWidth + 5 + 'px';
			tid = setTimeout( function (){ openl(o, minW, maxW, 1); } , 10);
	}
	else if(f && o.offsetWidth > maxW)
	{
		o.style.width = maxW + 'px';
		clearTimeout(tid);
	}
	else if(o.offsetWidth > minW)
	{
		clearTimeout(tid);
		o.style.width = Math.abs(parseInt(o.style.width) - o.offsetWidth/minW - 2) + 'px';
		tid = setTimeout( function (){ openl(o, minW, maxW); } , 10);
	}
	else if(o.offsetWidth < minW)
	{
		clearTimeout(tid);
		o.style.width = minW + 'px';
	}

	_(o, 'div', 1, 1).display = (o.offsetWidth > 202)? 'block' : 'none';
	_(o, 'div', 2, 1).display = (o.offsetWidth >= maxW - 10)? 'block' : 'none';

}

$('myLay').onmouseover = function (){ openl(this, 101, 313, 1); }
$('myLay').onmouseout = function (){ openl(this, 101, 323); }

/* ]]> */
</script>

<table border="0" cellpadding="0" cellspacing="0">
  <tr height="120">
    <td>&nbsp;</td>
  </tr>
</table> 
     

    <form name="searchresult" onreset="" method="POST" action="doGetBooks.jsp">
    <%
     try 
     {
       bookSet[] res = new bookSet[resNumber];  
       res = lib.getResult();
       if ( res.length == 0) { 
           session.setAttribute( "resultCount", "0" );
       %>
           <b> Sorry no results found! </b><br>
           <br><A HREF="<%= back.trim() %>" >Go back</A><br>
       <%    
       }
       else {
           String tit;
           String auth;
           String genre;
           String publ;
           String keys;
           String nodeName;
           %>
              <!-- <%= "Nodes names array length"+nodeNames.length %> -->
              <p class="number">There are <%= res.length %> results found</p> 
              <div id="txtBox">
              <table border="0" cellpadding="5" cellspacing="0" width="740" class="restable">
              <tr align="center" class="titletable">
              <td>№</td><td>Title</td><td>Author</td><td>Genre</td><td>Location</td><td>Get</td>
              </tr>
           <%
           Integer count = new Integer(res.length);
           session.setAttribute( "resultCount", count );
           for (int i=0;i<res.length;i++) {
               tit     =   res[i].getTitle();
               auth    =   res[i].getAuthor();
               if (auth == null) {
                  auth = "&nbsp;";
               }
               genre =   res[i].getGenre();
               if (genre == null) {
                  genre = "&nbsp;";
               }
               publ  =   res[i].getPublisher();
               if (publ == null) {
                  publ = "&nbsp;";
               }
               keys  =  res[i].getKeywords();
               if (keys == null) {
                  keys = "&nbsp;";
               }
               // nodeName = nodesNames[res[i].getNodeID()];
               nodeName = "secret"; 
               int nodeIndex = res[i].getNodeID();
               
               try {
                   nodeName = nodeNames[res[i].getNodeID()];
                }
               catch (Exception ex) {
                   nodeName = "Exception: "+ex.getMessage();
               }
               
               %>
                 <!--  ********************* Node index is: <%= nodeIndex %>  *********************  
                      bookInfo(title, author, genre, publ, keywords, lang)-->
                 <tr align="left">
                   <td><%= (i+1) %></td>
                   <td><a href="javascript:void(0)" onclick="bookInfo('<%= tit %>','<%= auth %>','<%= genre %>' ,'<%= publ %>' ,'<%= keys %>' ,'English')" class="ltitle"><%= tit %></a></td>
                   <td>&nbsp; <%= auth %> </td>
                   <td>&nbsp; <%= genre %> </td>
                   <td>&nbsp; <%= nodeName %> </td>
                   <td><input type="checkbox" name="<%= "getID"+i %>" value="<%="id"+i %>" style="width:25px; height:25px;" class="markbox"/></td>
                 </tr>   
            <%  
                  
            } // for
             
           %>
            </table>
            </form>
            </div>
	<!-- scroll -->
	<div id="scrollBar">
		<div id="up"></div>
		<div id="slide_back">
	
			<div id="slide_back_button"></div>
		</div>
		<div id="down"></div>
	</div>
	<!-- /scroll -->
	<br clear="all" />
	
	<script type="text/JavaScript">
	/* <![CDATA[ */
	SCR.init('txtBox', 'slide_back', 'slide_back_button', 'up', 'down', 0);
	/* ]]> */
	</script>
            <br> <table border="0" cellpadding="5" cellspacing="0" >
            <tr><td class="back"><A HREF="<%= back.trim() %>">Go back</A></td>
            <td class="back"><A HREF="javascript: document.searchresult.submit();">Continue</A></td></tr>
            </table>
           <% 
         }
     }
     
     catch (NullPointerException ex) {
         Integer zero = new Integer(0);
         session.setAttribute( "resultCount", zero );
         String errMsg = "Exception: " + ex.getMessage();  %>
          <br><b> Error - null resultSet!! </b><u> <%= errMsg %></u><br>
          <br> <A HREF="<%= back.trim() %>">Go back</A><br>
      <%
     }
    
    catch (Exception ex) {
         Integer zero = new Integer(0);
         session.setAttribute( "resultCount", zero );
         String errMsg2 = "Exception: " + ex.getMessage();  %>
         <br><b> Error - bad case!! </b><u> <%= errMsg2 %> </u><br>
         <br> <A HREF="<%= back.trim() %>">Go back</A><br>
    <% 
     }
      if (alert != null && alert.length() > 0 ) {
       %>
             <!- Alert: <%= alert %> -->
             <script type="text/javascript">
                  alert ("<%= alert %>"); 
             </script>
       <% 
        }
    %>
    
    </body>
</html>
