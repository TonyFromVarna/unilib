/*
 * configReader.java
 *
 * Created on ?????, 2008, ???????? 8, 14:26
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package libserver;

/**
 *
 * @author silvi
 */
import java.io.*;
import java.util.ArrayList;
import java.util.Scanner;

public class configReader {
    private ArrayList <String> servers = new ArrayList <String>();
    private ArrayList <String> logins  = new ArrayList <String>();
    private ArrayList <String> passwords = new ArrayList <String>();
    
    public configReader() throws IOException{
        String readLine;
         try { 
            FileReader fr = new FileReader("DBnodes.conf"); 
            BufferedReader br = new BufferedReader(fr); 
            while((readLine = br.readLine()) != null) { 
                parseLine(readLine);
            } 
            fr.close(); 
         }
         catch(FileNotFoundException exc) { 
            System.out.println("Cannot open file!!"); 
            return; 
         }
    }
    
    public configReader(String fname) throws IOException{
        String readLine;
         try { 
            FileReader fr = new FileReader(fname); 
            BufferedReader br = new BufferedReader(fr); 
            while((readLine = br.readLine()) != null) { 
                parseLine(readLine);
            } 
            fr.close(); 
         }
         catch(FileNotFoundException exc) { 
            System.out.println("Cannot open file!!"); 
            return; 
         }
    }
    
    public void parseLine(String line){
//     System.out.println("Scanner try line:" + line);
        Scanner scanner = new Scanner(line);
        scanner.useDelimiter(";");
        if ( scanner.hasNext() ){
            String server = scanner.next(); 
            String user = scanner.next(); 
            String pass = scanner.next();
        //  System.out.println("Server is: " + server.trim() + " and User is: " + user.trim() + " and password is: " + pass.trim());
            servers.add(server.trim());
            logins.add(user.trim());
            passwords.add(pass.trim());
        }
        else {
            System.out.println("Empty or invalid line. Unable to process!!!");
        }
        scanner.close();
    }
    
    public boolean hasRead(){
        if (servers.isEmpty() || logins.isEmpty() || passwords.isEmpty()) {
            return false;
        }
        if (servers.size() != logins.size() || servers.size() != passwords.size() || logins.size() != passwords.size()) {
            return false;
        }
        return true;
    }
    
    public int sizeOf() {
        if (hasRead()) {
            return servers.size();
        }
        return 0;
    }
    
    public String[] getServers(){
        if (hasRead()) {
            String[] res = new String[servers.size()];
            res = servers.toArray(res);
            return res; 
        }
        return null;
    }
    
    public String[] getLogins(){
        if (hasRead()) {
            String[] res = new String[logins.size()];
            res = logins.toArray(res);
            return res; 
        }
        return null;
    }
    
    public String[] getPasswords(){
        if (hasRead()) {
            String[] res = new String[passwords.size()];
            res = passwords.toArray(res);
            return res; 
        }
        return null;
    }
    
}
