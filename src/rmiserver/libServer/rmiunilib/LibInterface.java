/*
 * LibInterface.java
 *
 * Created on ?????, 2008, ???????? 8, 10:53
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package rmiunilib;

//import java.rmi.*;
import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Vector;

/**
 *
 * @author silvi
 */

public interface LibInterface extends Remote{
   public String getInfo() throws RemoteException;
   public void userLoans (String userLogin, StringBuffer errMsg) throws RemoteException;
   public boolean checkUserName(String loginName, StringBuffer errMessage) throws RemoteException;
   public boolean validUser(String loginName, String pass) throws RemoteException;
   public void addUser(String loginName, String pass, 
                        String firstName, String lastName,
                        String address, String email, StringBuffer errLog
                       ) throws RemoteException;
   public void searchBook(String mName, String mAuthor, 
                           int[] mType, String mGenre, 
                     String mPublisher, StringBuffer errorMessage) throws RemoteException;
   public void getBook(String login, int nodeID, int bookID, StringBuffer errMessage) throws RemoteException;
   public void returnBook(String login, int nodeID, int bookID, StringBuffer errMessage) throws RemoteException;
   //public ArrayList<bookSet> getResult() throws RemoteException;
   //public bookSet[] getResult() throws RemoteException;
   public Vector <bookSet> getResult() throws RemoteException;
   public String[] nodesNames() throws RemoteException;
}
