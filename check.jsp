<%-- 
    Document   : check.jsp
    Created on : Jul 26, 2019, 11:21:13 AM
    Author     : bpkhandelwal
--%>

<%@page import="javax.jms.Session"%>
<%@page import="java.sql.* ,java.util.* "%>
<!DOCTYPE html>
<%
    String email=null;
        Cookie c[]=request.getCookies();
        for(int i=0;i<c.length;i++){
                if(c[i].getName().equals("user")){
                        email=c[i].getValue();
                        break;
                }
        }
        if(email==null){
                if(request.getParameter("email").length()==0){
                        response.sendRedirect("login1.jsp?email=1");
                        
                }
                else{
                    email=request.getParameter("email");
                    
                }
       }
        if(request.getParameter("pass").length()==0){
                response.sendRedirect("login1.jsp?invalid pass");
        }
        else{
                String pass=request.getParameter("pass");
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/db","root","");
                    Statement st=cn.createStatement();
                    ResultSet rs=st.executeQuery("select * from matrimonial where email='"+email+"' ");
                    if(rs.next()){
                        if(pass.equals(rs.getString("password"))){
                                Cookie ct=new Cookie("user",email);
                                ct.setMaxAge(3600);
                                response.addCookie(ct);
                                session.setAttribute(email,pass);
                                session.setMaxInactiveInterval(100);
                                response.sendRedirect("profile1.jsp");
                        }
                        else{
                               response.sendRedirect("login1.jsp?invalid pass=1");
                        }
                    }
                    else{
                            response.sendRedirect("login1.jsp?email_invalid=1");
                    }
                    cn.close();
                }
        
                catch(Exception e){
                        out.println(e.getMessage());
                }
        }

%>

                                
                           
                        
                 