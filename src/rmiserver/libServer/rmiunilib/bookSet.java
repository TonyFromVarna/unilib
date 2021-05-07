/*
 * bookSet.java
 *
 * Created on ?????, 2008, ???????? 8, 10:56
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
public class bookSet  implements Serializable{
    
/*
 * bookSet.java
 *
 * Created on Понеделник, 2008, Януари 21, 12:22
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

    private int bookID;
    private String title;
    private String author;
    private String genre;
    private String publisher;
    private String keywords;
    private String loanDate;
    private int languageID;
    private int nodeID;
    

    public bookSet() {
        bookID = 0;
        title = null;
        author = null;
        genre = null;
        publisher = null;
        keywords = null;
        loanDate = null;
        languageID = 0;
        nodeID = 0;
    }
    
    public bookSet(int bID, String bookName, String bookAuthor, String bookGenre, String bookPublisher, String keys, String mDate,int lang, int nodeIndex) {
        bookID  = bID;
        title   = bookName;
        author  = bookAuthor;
        genre   = bookGenre;
        publisher = bookPublisher;
        keywords = keys;
        loanDate = mDate;
        languageID = lang;
        nodeID = nodeIndex;
    }
    
    public bookSet(int bID, String bookName, String bookAuthor, String bookGenre, String bookPublisher, String keys, int lang, int nodeIndex) {
        bookID = bID;
        title  = bookName;
        author = bookAuthor;
        genre  = bookGenre;
        publisher = bookPublisher;
        keywords = keys;
        languageID = lang;
        nodeID = nodeIndex;
    }

    public bookSet(int bID, String bookName, String bookAuthor, String bookGenre, String bookPublisher, String keys, int nodeIndex) {
        bookID = bID;
        title  = bookName;
        author = bookAuthor;
        genre  = bookGenre;
        publisher = bookPublisher;
        keywords = keys;
        nodeID = nodeIndex;
    }
    
    public bookSet(int bID, String bookName, String bookAuthor, String bookGenre, String bookPublisher, int nodeIndex) {
        bookID = bID;
        title  = bookName;
        author = bookAuthor;
        genre  = bookGenre;
        publisher = bookPublisher;
        nodeID = nodeIndex;
    }
    
    public bookSet(int bID, String bookName, String bookAuthor, String bookGenre, int nodeIndex) {
        bookID = bID;
        title  = bookName;
        author = bookAuthor;
        genre  = bookGenre;
        nodeID = nodeIndex;
    }
      
    public bookSet(int bID, String bookName, String bookAuthor, int nodeIndex) {
        bookID = bID;
        title  = bookName;
        author = bookAuthor;
        nodeID = nodeIndex;
    }

    public void setLoanDate (String lDate){
        loanDate = lDate;
    }
    
    public int geID(){
        return bookID;
    }
    
    public String getTitle(){
        return title;
    }
    
    public String getAuthor(){
        return author;
    }
    
    public String getGenre(){
        return genre;
    }
    
    public int getNodeID(){
        return nodeID;
    }

    public String getPublisher(){
        return publisher;
    }
    
    public String getKeywords(){
        return keywords;
    }

    public int getLanguageID(){
        return languageID;
    }
    
    public String getLoanDate (){
        return loanDate;
    }
    
}
