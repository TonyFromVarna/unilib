========================
Run Tomcat DESCRIPTION
========================
Download binary Tomcat for web server host operation system.
Copy jar files in ${catalina.home}/lib directory (libClient.jar and remote interface jar).
Edit client.policy and catalina.policy - have to add permitions to connect to rmi server
and FilePermitions to write in ${catalina.home}/lib and set server codebase. 
Copy jsp files in ${catalina.home}/webapps/directory. 
Run Tomcat using Security Manager (something like $CATALINA_HOME/bin/catalina.sh start -security; 
check Documentation)!