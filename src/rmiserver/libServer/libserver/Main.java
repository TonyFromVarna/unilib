/*
 * Main.java
 *
 * Created on ?????, 2008, ???????? 8, 12:39
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package libserver;

import java.rmi.*;
/**
 *
 * @author tony
 */
public class Main {
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        System.setProperty( "java.security.policy", "server.policy" );
        System.setSecurityManager(new RMISecurityManager());
        try {
           LibServer lib = new LibServer();
           Naming.rebind("LibraryServer" , lib); 
           System.out.println("Unilib server started! Info: "+lib.getInfo());
        }
        catch (Exception ex) {
            System.out.println("Ooops: "+ex.getMessage());
        }
        
    }
    
}
