/*
 * LibServer.java
 *
 * Created on  ?????, 2008, ???????? 8, 13:23
 *
 *
import java.rmi.*;
*/

package libserver;

/**
 *
 * @author silvi
 */


import java.rmi.*;
import java.rmi.server.*;
import java.rmi.registry.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
// import java.sql.*;
import java.io.*;
import java.util.ArrayList;
import java.util.Vector;
import rmiunilib.*;

public class LibServer extends UnicastRemoteObject
                 implements rmiunilib.LibInterface{
    private int numbBooks = 0;
    private int numbNodes = 0;
    private boolean connected = false;
    private StringBuffer errorMessage = new StringBuffer(); 
    //private String[] servers = {"//tonypc/library", "//silvipc/library", "//tonypc/unilib", "//silvipc/unilib"};   // jdbc:mysql:server
    //private String[] userLogins = {"guest", "guest", "guest", "guest"};
    //private String[] userPasswords = {"123456", "123456", "123456", "123456"};
    private String[] servers;   // jdbc:mysql:server
    private String[] userLogins;
    private String[] userPasswords;
    private String[] uniLibNames;
    private int[] activeNodes;
    private int numberFound = 0;  // The size of booksFound
    private boolean readNodesConfig = false;
    //private ArrayList <bookSet> booksFound = new ArrayList<bookSet>();
    private Vector <bookSet> booksFound = new Vector<bookSet>();
    
    private void setConnections(){
        int nodesNumber = 4;
        try {
             configReader conf = new configReader();
             if (conf.hasRead()) {
                 nodesNumber = conf.sizeOf();
                 servers = new String[nodesNumber];
                 userLogins = new String[nodesNumber];
                 userPasswords = new String[nodesNumber];
                 uniLibNames   = new String[nodesNumber];
                 servers    = conf.getServers();
                 userLogins = conf.getLogins();
                 userPasswords = conf.getPasswords();
                 numbNodes = nodesNumber;
                 //for (int i=0;i<servers.length;i++) {
                 //    System.out.println("Line "+(i+1)+" server: "+servers[i]+" login: "+userLogins[i]+" password: "+userPasswords[i]);
                 //}
                 activeNodes = new int[nodesNumber];
                 readNodesConfig = true;
             }
        }
        catch (IOException ex) {
             System.out.println("?? ?????!!!");
             nodesNumber = 0;
        }
        
    }
    
    private void catchNodes(){
        int checkedNodes = 0;
        numbNodes = servers.length;
        uniLibNames = new String[numbNodes];  
        String errorLog = "";
        numbBooks = 0;
        if (readNodesConfig) {
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
            }
            catch (Exception ex) {
         // *****   handle the error  ***
                errorMessage.append("1st SQLException: " + ex.getMessage());
            }
            for (int i=0;i<numbNodes;i++) {
                int numb = 0;
                try {
                   String server = "jdbc:mysql:"+servers[i];
                   Connection conn = DriverManager.getConnection(server.trim(),userLogins[i],userPasswords[i]);
                   java.sql.ResultSet rst=null;
                   java.sql.Statement stmt=null;
                   stmt=conn.createStatement();
                   //query = "SELECT name FROM db_options";  
	           rst = stmt.executeQuery("SELECT name FROM db_options");
                   if (rst.next()) uniLibNames[i] = rst.getString(1);  // ????   
                   //query = "SELECT count(*) FROM books";
                   rst = stmt.executeQuery("SELECT count(*) FROM books");
                   if (rst.next()) numb = rst.getInt(1);
                   numbBooks = numbBooks + numb;
	           checkedNodes++;    // Active nodes count
                   activeNodes[i] = 1;
                   conn.close();
                }
                catch (Exception ex){
                    errorLog = errorLog + "Exception: " + ex.getMessage();
           	    errorLog = errorLog + " server "+servers[i]+" not available\n";
                    activeNodes[i] = 0;
                }
            }  // Nodes Loop
            if (checkedNodes == 0) {
                errorMessage.append("No server available!!\n"+errorLog);
                
                connected = false;
            }
            else {
                connected = true;
                numbNodes = checkedNodes;
            }
        }    
        
    }
    
    public String getInfo() throws RemoteException {
        setConnections();
        if (connected) {
            catchNodes();
            return "The number of active nodes is: "+numbNodes+" and number of available books is: "+numbBooks;
        }
        return "There is a problem: "+errorMessage.toString();
    }
    
     
    public String[] nodesNames() throws RemoteException {
        if (connected) {
            return uniLibNames;
        }
        return null;   
    }    
    
    public LibServer() throws RemoteException {
        super();  // ???
        //int checkedNodes;
        setConnections();  // init servers, logins, passwords
        catchNodes();    
    }
    
  
   
    public Vector <bookSet>  getResult() throws RemoteException {
        if (booksFound.size() == 0){
            return null;
        }
        //bookSet[] res = new bookSet[booksFound.size()];
        System.out.println("Server send: "+booksFound.size()+" to client!");
        return  booksFound;
    }
    
    //interface
    public void searchBook(String mName, String mAuthor, 
                            int[] mType, String mGenre, 
                      String mPublisher, StringBuffer errorMessage) throws RemoteException{
//     ArrayList <bookSet> booksFound = new ArrayList();
//     bookSet[] result;
       StringBuffer errMessage = new StringBuffer();
//     errorMessage = new StringBuffer();

       if (!booksFound.isEmpty()){
         booksFound.clear();
       }
       
       for (int i=0;i<servers.length;i++) {
           if (activeNodes[i] > 0) {
               search(mName, mAuthor, mGenre, mPublisher, mType, i, errMessage);
               // if (nodeResult.length > 0) 
           }
           // if (!errMessage.equals("")) errorMessage.append(errMessage);
           if (errorMessage.length() > 0) {
               errorMessage.append(errMessage);
           }
       }
//     numb = booksFound.size();
//       if (numb > 0) {
//        result = new bookSet[numb];
//        result = booksFound.toArray(result);
       if (booksFound.isEmpty()){
           System.out.println("Nothing found: at all nodes!");
           numberFound = 0;
       }
       else {
           System.out.println("Number of books found: "+booksFound.size()+" at all nodes!");
           numberFound = booksFound.size();
       }
    }

  //interface
    public boolean checkUserName(String loginName, StringBuffer errMessage) throws RemoteException {  
        int numb = 0;
        int i    = 0;
//      errMessage = new StringBuffer();
        StringBuffer errLog = new StringBuffer();
        if (loginName == null || loginName.equals("") ) {
            errMessage.append("Empty login!!");
//          System.out.println("Set errMessage := "+errMessage.toString());
            return false;
        }
        String query = "SELECT count(*) FROM users WHERE login = \'"+loginName.trim()+"\'  ";
       //    numb = getNumber(query);
        for (i=0;i<servers.length;i++) {
           if (activeNodes[i] > 0) {
               numb = numb + getNumber(query,i,errLog); // Check node and validate user
           }
        }
        if (numb == 0) {
           return true;
        }
        errMessage.append(loginName + " found in " + numb + " nodes!");
       // System.out.println("Set errMessage := "+errMessage.toString());
       // System.out.println("checkUserName:: reporting: "+errMessage);
        return false;
    }
    
    // interface
    public void addUser(String loginName, String pass, 
                        String firstName, String lastName,
                        String address, String email, StringBuffer errLog
            ) throws RemoteException { 
        /**
          Only add user in active nodes without check for exist username
         */
       int numb = 0;
       int i    = 0;
       short addressFlag = 0;
       short emailFlag   = 0;
       StringBuffer err = new StringBuffer();
       //String query = "INSERT INTO users (login, password, Name ";
//     errLog = new StringBuffer();   // !!!!!!!!!!!!!!!!!!!!!!!!
      String query = "INSERT INTO users (login, password, firstName, lastName ";
      if (loginName == null) {
           errLog.append("Invalid login");
           return;
       } 
       if (pass == null) {
           errLog.append("Blank password"); // maybe check goodness of password too
           return;
       }
       if (firstName == null) {
           errLog.append("Blank first name"); 
           return;
       }
       if (!checkUserName(loginName,err)){
           errLog.append("Username: "+loginName+" already in use! "+err.toString());
           return;
       }
       if (address != null) {
           addressFlag = 1;
           query = query + ", Address";
       }
       if (email != null) {
           emailFlag = 1;
           query = query + ", Email";
       }
       query = query + ") VALUES (\'" + loginName.trim()+"\',  ";
       query = query + "\'" + pass.trim()+"\', ";
       query = query + "\'" + firstName + " \', \'" + lastName + "\', ";
       if (addressFlag != 0) query = query + "\'" + address+ "\', ";
       if (emailFlag != 0 ) query = query + "\'" + email+ "\' ";
       query = query + ")";
       for (i=0;i<servers.length;i++) {
           if (activeNodes[i] > 0) updateLib(query,i,errLog); // Add user in active nodes
       }
    }
    
    //interface
    public boolean validUser(String loginName, String pass) throws RemoteException{ 
       int numb = 0;
       int numb_nodes = 0;
       int i    = 0;
       StringBuffer errLog = new StringBuffer();
       
       if (loginName == null || pass == null || loginName.equals("") || pass.equals("") ) {
           return false;
       }
       String query = "SELECT count(*) FROM users WHERE login = \'"+loginName.trim()+"\'  ";
       query = query + " AND password = \'"+pass.trim()+"\'";
       //    numb = getNumber(query);
       for (i=0;i<servers.length;i++) {
           if (activeNodes[i] > 0) {
               numb = numb + getNumber(query,i,errLog); // Check node and validate user
               numb_nodes++;
           }
       }
       if (numb == 0) {
           return false;
       }
       
       if (numb < numb_nodes) {
           replicateUser(loginName, pass);
       }
       return true;
    }
    
        
    // Interfase
    public void userLoans (String userLogin, StringBuffer errMsg) throws RemoteException{   // to create booksFound for given userLogin
        StringBuffer err   = new StringBuffer();
        String query = "";
        int uID      = 0;
        if (userLogin == null || userLogin.equals("")) {  // Client check
            errMsg.append("Empty username!");
          //  System.out.println("userLoans:: "+errMsg);
            return;
        }
        if (!checkUserName(userLogin,err)) {  // checkUserName search free username
            if (!booksFound.isEmpty())
                booksFound.clear();
        }
        else {
            if (err.length() == 0){  // ????????
                errMsg.append("Sorry but user "+userLogin+" not found in library system!");
            }    
            else 
                errMsg.append("Sorry but there is an error: "+err.toString());
        //    System.out.println("userLoans:: "+errMsg);
            return;        
        }
        
        for (int i=0;i<servers.length;i++) {
           if (activeNodes[i] > 0) {
               uID = getUserID(userLogin, i, err);
               if (uID > 0) {
            //       System.out.println("userLoans:: Hi userID found: "+uID+" for nodeID: "+i);
                   try  {                // DB connect for nodeID i
                       Class.forName("com.mysql.jdbc.Driver").newInstance();
                   }
                   catch (Exception ex) {
                       err.append("1st SQLException: " + ex.getMessage());
                   } 
                   
                   try {      // SELECT from DB-node
                       String server = "jdbc:mysql:"+servers[i];
                       bookSet resRow;
                       Connection conn = DriverManager.getConnection(server.trim(),userLogins[i],userPasswords[i]);
                       java.sql.ResultSet rst  = null;
                       java.sql.Statement stmt = null;
                       stmt=conn.createStatement();
                       // query = "SELECT b.* FROM books b, loans l WHERE l.userID = " + uID + " AND b.id = l.bookID ";
                       // SELECT DATE_FORMAT(loaned,\'%d/%m/%y %H:%i\'),b.* FROM books b, loans l WHERE l.userID = " + uID + " AND b.id = l.bookID ";
                       query = "SELECT DATE_FORMAT(l.loaned,\'%d/%m/%y %H:%i\'),b.* FROM books b, loans l WHERE l.userID = " + uID + " AND b.id = l.bookID ";
                       rst = stmt.executeQuery(query);
                       while (rst.next()) {
                           resRow = new bookSet(rst.getInt(2),rst.getString(3),rst.getString(4),rst.getString(6),rst.getString(7),rst.getString(8),rst.getString(1),rst.getInt(9),i); // set fields of bookSet object from SELECT
                           booksFound.add(resRow);
                       }
                       conn.close();
                   }
                   catch (Exception ex){
                      err.append("Exception: " + ex.getMessage());
                   }
           
               }   // check for userName in node i
           }  
        }     // Nodes loop
        
        if (booksFound.isEmpty()) {
            errMsg.append("Nothing found for user " + userLogin);
            System.out.println("Ooops userLoans:: "+errMsg.toString());
            
        }
        numberFound = booksFound.size();   /// Comunicate with RMI client
        System.out.println("userLoans:: books.length = "+booksFound.size());
    }
    
// Interface    
    public void getBook(String login, int nodeID, int bookID, StringBuffer errMessage) throws RemoteException{
        int numb_b = 0;
        int numb_l = 0;
        int numb   = 0;
        int userID = 0;
        String query;
//      errMessage = new StringBuffer();
        query = " SELECT count(*) FROM books where id = " + bookID;
        numb_b = getNumber(query, nodeID, errorMessage);
        query = "SELECT count(*) FROM users where  login = \'"+login.trim()+"\' ";
        numb  = getNumber(query, nodeID, errorMessage);
        if (numb_b == 1 && numb == 1) {
            query = "SELECT id FROM users where  login = \'"+login.trim()+"\' ";
            int uID = getNumber(query, nodeID, errMessage);
            if ( uID > 0 && (errMessage.length() == 0) ) { // errMessage.equals("") ) {
                query = "SELECT count(*) FROM loans where userID = "+ uID +" AND bookID = " + bookID; // already get this book from this node
                numb  = getNumber(query, nodeID, errorMessage);
                if (numb == 0) {
                   query = "INSERT INTO loans (id, bookID, userID, loaned) VALUES (null, " + bookID + ", " + uID + ", now())";
                   updateLib(query,nodeID,errMessage);
                }
                else {
                    query = "SELECT title from books where bookID = " + bookID;
                    StringBuffer err = new StringBuffer();
                    errMessage.append("You already get " + getString(query,nodeID,err) + "!");
                }
            }
        }
    }
    
    public int getRequestNumberBooks(){       //// RMI-client - server communication
        numberFound = 0;
        if (booksFound.isEmpty()){
            numberFound = 0;
        }
        else {
            numberFound = booksFound.size();
        }
        return numberFound;
    }
    
// Interface
    public void returnBook(String login, int nodeID, int bookID, StringBuffer errMessage) throws RemoteException{
        int numb_b = 0;
        int numb_l = 0;
        int numb   = 0;
        int userID = 0;
        String query;
//      errMessage = new StringBuffer();
        query = " SELECT count(*) FROM books where id = " + bookID;
        numb_b = getNumber(query, nodeID, errorMessage);
        query = "SELECT count(*) FROM users where  login = \'"+login.trim()+"\' ";
        numb  = getNumber(query, nodeID, errorMessage);
        if (numb_b == 1 && numb == 1) {
            query = "SELECT id FROM users where  login = \'"+login.trim()+"\' ";
            int uID = getNumber(query, nodeID, errMessage);
            if ( uID > 0 && (errMessage.length() == 0 ) ) {
                query = "SELECT count(*) FROM loans where userID = "+ uID +" AND bookID = " + bookID;
                numb  = getNumber(query, nodeID, errorMessage);
                if (numb > 0) {
                   query = "DELETE FROM loans WHERE userID = " + uID +" AND bookID = " + bookID;
                   updateLib(query,nodeID,errMessage);
                }
                else {
                    query = "SELECT title from books where bookID = " + bookID;
                    StringBuffer err = new StringBuffer();
                    errMessage.append("You can not return " + getString(query,nodeID,err) + " because not loaned it!");
                }
            }
        }
    }
    
    //  Server side    
    public int getNumber(String query, int nodeNumb, StringBuffer errorMessage) {
      String server;
      int res = 0;
      errorMessage = new StringBuffer();
      try
       {
          Class.forName("com.mysql.jdbc.Driver").newInstance();
       }
      catch (Exception ex) {
            // *****   handle the error  ****
         errorMessage.append("1st SQLException: " + ex.getMessage());
       } 
      try {
               server = "jdbc:mysql:"+servers[nodeNumb];
               Connection conn = DriverManager.getConnection(server.trim(),userLogins[nodeNumb],userPasswords[nodeNumb]);
               java.sql.ResultSet rst  = null;
               java.sql.Statement stmt = null;
               stmt=conn.createStatement();
               rst = stmt.executeQuery(query);
               if (rst.next()) res = rst.getInt(1);
               conn.close();
       }
      catch (Exception ex) {
            errorMessage.append("Exception: " + ex.getMessage());
            errorMessage.append(" server "+servers[nodeNumb]+" looks not available\n");
//          activeNodes[nodeNumb] = 0;  ////// ?????????????????????????
       }
      return res;
    }
    
  //  Server side 
    public String getString(String query, int nodeNumb,StringBuffer errorMessage) {
      String server;
      String res = "";
      errorMessage = new StringBuffer();
      try
       {
          Class.forName("com.mysql.jdbc.Driver").newInstance();
       }
      catch (Exception ex) {
            // *****   handle the error  ****
         errorMessage.append("1st SQLException: " + ex.getMessage());
       } 
      try {
               server = "jdbc:mysql:"+servers[nodeNumb];
               Connection conn = DriverManager.getConnection(server.trim(),userLogins[nodeNumb],userPasswords[nodeNumb]);
               java.sql.ResultSet rst  = null;
               java.sql.Statement stmt = null;
               stmt=conn.createStatement();
               rst = stmt.executeQuery(query);
//             System.out.println("getString SELECT count(*) is: "+rst.getFetchSize()); // return 0 :-((
               if (rst.next()) res = rst.getString(1);
               conn.close();
       }
      catch (Exception ex) {
            errorMessage.append("Exception: " + ex.getMessage());
            errorMessage.append(" server "+servers[nodeNumb]+" looks not available\n");
       }
      return res;
    }
    
  // Server side 
    public void updateLib(String query, int nodeNumb, StringBuffer errorMessage){ // Updata & INSERT 2 in 1
        String server;
        errorMessage = new StringBuffer();
       
        try
        {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
        }
        catch (Exception ex) {
            // *****   handle the error  ****
           errorMessage.append("1st SQLException: " + ex.getMessage());
        } 
        try {
           server = "jdbc:mysql:"+servers[nodeNumb];
           Connection conn = DriverManager.getConnection(server.trim(),userLogins[nodeNumb],userPasswords[nodeNumb]);
           java.sql.Statement stmt = null;
           stmt=conn.createStatement();
           stmt.executeUpdate(query);
           stmt.close();
           conn.commit();
           conn.close();
        }
        catch (Exception ex) {
            errorMessage.append("Exception: " + ex.getMessage());
            errorMessage.append(" server "+servers[nodeNumb]+" looks not available for update\n");
        }
    }
    
    //Server side
    public int getUserID(String userName, int nodeNumb, StringBuffer errorMessage) {
        String query = "SELECT count(*) FROM users where login = \'" + userName.trim() + "\'";
        int numb = 0;
        errorMessage = new StringBuffer();
        numb = getNumber(query,nodeNumb,errorMessage);
        if (numb == 1) {
            query = "SELECT id FROM users where login = \'" + userName.trim() + "\'";
            numb = getNumber(query,nodeNumb,errorMessage);
            return numb;
        }
        if (numb > 1) {
            errorMessage.append(" very strange situation - more than one IDs found!!!!??");
            return 0;
        }
        if (errorMessage.equals("")) {
            errorMessage.append("User " + userName + " not found in nodeID: "+nodeNumb);
        }
        return 0;
    }
    
    //  Server side
    public void search(String bookName, String authorName, String gen, 
                       String publ, int[] mediaType, int nodeNumb, StringBuffer errorMessage) {
      String server;
      String query;
      String whr;
      String whrType;
      int rowCount = 0;
      bookSet resRow;
      errorMessage = new StringBuffer();
      whrType = "";
      try {
           if (mediaType.length > 0) {
            //   int j;
               whrType = " mediaType in (";
               for (int j=0;j<mediaType.length;j++) {
                   whrType = whrType + mediaType[j];
                   if (j !=mediaType.length -1) {
                       whrType = whrType + ", ";
                   }
               }
               whrType = whrType + ")  ";
           }
      }
      catch (NullPointerException ex){
          whrType = "";
      }

      try
       {
          Class.forName("com.mysql.jdbc.Driver").newInstance();
       }
      catch (Exception ex) {
           errorMessage.append("1st SQLException: " + ex.getMessage());
       } 
      try {
               server = "jdbc:mysql:"+servers[nodeNumb];
               Connection conn = DriverManager.getConnection(server.trim(),userLogins[nodeNumb],userPasswords[nodeNumb]);
               java.sql.ResultSet rst  = null;
               java.sql.Statement stmt = null;
               stmt=conn.createStatement();
           //  query = "SELECT id,name,author FROM books b, types t '";
               query = "SELECT * FROM books ";
               //if (bookName.equals("") && authorName.equals("")) 
               //    whr = "";
              // else 
               whr   = " WHERE " + whrType;
               if (!bookName.equals("")) {
//                 whr = whr + " upper(Name) LIKE \'%"+bookName.toUpperCase()+"%\'";
                    if (whr.length() > 10 ){
                          whr = whr + " AND upper(title) LIKE \'%"+bookName.toUpperCase()+"%\'";
                    }
                    else {
                           whr = whr + " upper(title) LIKE \'%"+bookName.toUpperCase()+"%\'";
                    }
               }      
               if (!authorName.equals("")) {
                   if (whr.length() > 10 )
                       whr = whr + " AND upper(author) LIKE \'%"+authorName.toUpperCase()+"%\'"; 
                   else
                       whr = whr + " upper(author) LIKE \'%"+authorName.toUpperCase()+"%\'"; 
               }
               if (!gen.equals("")) {
                   if (whr.length() > 10 )
                       whr = whr + " AND upper(genre) LIKE \'%"+gen.toUpperCase()+"%\'"; 
                   else
                       whr = whr + " upper(genre) LIKE \'%"+gen.toUpperCase()+"%\'"; 
               }
               if (!publ.equals("")) {
                   if (whr.length() > 10 )
                       whr = whr + " AND upper(publisher) LIKE \'%"+publ.toUpperCase()+"%\'"; 
                   else
                       whr = whr + " upper(publisher) LIKE \'%"+publ.toUpperCase()+"%\'"; 
               }
               System.out.println("Try : "+query+whr);
               rst = stmt.executeQuery(query+whr);
//             ArrayList <bookSet> booksFound = new ArrayList();  
//             rowCount = stmt.getFetchSize();
//             if (rst.next()) res = rst.getInt(1);
//  bookSet(int bID, String bookName, String bookAuthor, String bookGenre, String bookPublisher, String keys, int lang, int nodeIndex)
//  bookSet(int bID, String bookName, String bookAuthor, String bookGenre, String bookPublisher, String keys, int nodeIndex) 
               while (rst.next()) {  // query = "SELECT * FROM books ";
                     resRow = new bookSet(rst.getInt(1),rst.getString(2),rst.getString(3),rst.getString(5),rst.getString(6),rst.getString(7),rst.getInt(8),nodeNumb); // set fields of bookSet object from SELECT
                     booksFound.add(resRow);
//                   System.out.println(" Found book "+rst.getString(2)+" by "+rst.getString(3));
                  }
               if (booksFound.size() == 0) {
//                 bookSet[] nodeBooks = new bookSet[booksFound.size()];
//               nodeBooks = booksFound.toArray(nodeBooks);
//               System.out.println("Finaly there are "+nodeBooks.length+" found!");
//               System.out.println("Number of books found: "+nodeBooks.length+" at node"+(nodeNumb+1)+"!");
//               return nodeBooks;
              // }
               errorMessage.append("Nothing found");
               }
               conn.close();
  //           return null;
       }
      catch (Exception ex) {
            errorMessage.append("Exception: " + ex.getMessage());
            errorMessage.append(" server "+servers[nodeNumb]+" looks not available!\n");
//          activeNodes[nodeNumb] = 0;  ////// ?????????????????????????
       }
//     return null;
    }
    
    //Server side
    private void replicateUser (String logName, String pass) {
        int numb  = 0;
        int numb_ins = 0;
        int numb_upd = 0;
        int count = 0;
        int i     = 0;
        String firstName;
        String lastName;
        String address;
        String email;
        StringBuffer errLog = new StringBuffer();
        String sqlstr = "";
        String query = "SELECT count(*) FROM users WHERE login = \'"+logName.trim()+"\'  ";
        query = query + " AND password = \'"+pass.trim()+"\'";
        for (i=0;i<activeNodes.length;i++)
            if (activeNodes[i] > 0) count++;
        if (count == 0) return;
        String[] logins = new String[count];
        String[] passwords = new String[count];
        for (i=0;i<activeNodes.length;i++) {
            if (activeNodes[i] > 0) {
                numb = getNumber(query,i,errLog); // Check node and validate user
                if ( numb == 0) {
                    String query2 = "SELECT count(*) FROM users WHERE login = \'"+logName.trim()+"\' ";
                    numb = getNumber(query2,i,errLog);
                    if (numb == 1) {
                        sqlstr = "UPDATE users set password = \'"+pass.trim()+"\' WHERE login = \'"+logName.trim()+"\' ";
                        // System.out.println("Execute: "+sqlstr);
                        numb_upd++;
                    }
                    else {
                        sqlstr = "INSERT INTO users (id, password, login, Name) VALUES (null, \'"+pass.trim()+"\',  '"+logName.trim()+"\', \'Added by UniLib\') ";
                        // System.out.println("Execute: "+sqlstr);                        
                        numb_ins++;
                    }
                    updateLib(sqlstr,i,errLog);
                }
            }
        }
    }
}
