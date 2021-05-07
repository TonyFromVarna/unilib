/*
 * unilibUser.java
 *
 * Created on ?????, 2008, ???????? 8, 10:53
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package rmiunilib;

import java.io.Serializable;

/**
 *
 * @author silvi
 */

public class unilibUser implements Serializable{

    private int userID;
    private String login;
    private String password;
    private String firstName;
    private String lastName;
    private String address;
    private String email;
    private int nodeID;
    private int age;
    private String notes;
    
    public unilibUser(){
        userID = -1;
        nodeID = -1;
        age = 0;
    }
    
    public unilibUser(String log, String pass, String name1, String name2, String addr, String uEmail, int nID){
        login    = log;
        password = pass;
        firstName = name1;
        lastName = name2;
        address  = addr;
        email    = uEmail;
        nodeID   = nID;
    }
    
    public unilibUser(int uID, String log, String pass, String name1, String name2, String addr, String uEmail, int nID){
        login    = log;
        password = pass;
        firstName = name1;
        lastName = name2;
        address  = addr;
        email    = uEmail;
        nodeID   = nID;
        userID   = uID;
    }
    
    public String getLogin(){
        return login;
    }
    
    public String getFirstName(){
        return firstName;
    }
    
    public String getLastName(){
        return lastName;
    }
    
    public String getAddress(){
        return address;
    }
     
    public String getEmail(){
        return email;
    }
    
    public int getNodeID(){
        return nodeID;
    }
    
    public int getUserID(){
        return userID;
    }
    
    public void setLogin(String login) {
        this.login = login;
    }
    
    public void setPassword(String pass) {
        this.password = pass;
    }
    
    public void setFirstName(String first) {
        this.firstName = first;
    }
    
    public void setLastName(String last) {
        this.lastName = last;
    }
    
    public void setAddress(String addr) {
        this.address = addr;
    }
}
