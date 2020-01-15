<%-- 
    Document   : change_pass.jsp
    Created on : Jul 28, 2019, 11:15:10 AM
    Author     : bpkhandelwal
--%>

<%@page import="java.sql.*,java.util.*"%>
<%
    String email=null;
        Cookie c[]=request.getCookies();
        for(int i=0;i<c.length;i++){
                if(c[i].getName().equals("user")){
                        email=c[i].getValue();
                        break;
                }
        }
        if(email!=null && session.getAttribute(email)!=null){
          
            if(request.getParameter("cp").length()==0||request.getParameter("np").length()==0|| request.getParameter("rp").length()==0){
                response.sendRedirect("changepassword.jsp?err=1");
            }
            else{
                String cp=request.getParameter("cp");
                String np=request.getParameter("np");
                String rp=request.getParameter("rp");
                try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/db","root","");
                        Statement st=cn.createStatement();
                        ResultSet rs=st.executeQuery("select * from matrimonial where email='"+email+"'");
                        if(rs.next()){
                                if(cp.equals(rs.getString("password"))){
                                        if(np.equals(rp)){
                                                st.execute("update matrimonial set password='"+np+"'where email='"+email+"' ");
                                                response.sendRedirect("changepassword.jsp?succ=1");
                                        }
                                        else{
                                                response.sendRedirect("changepassword.jsp?mismatch=1");
                                        }
                                }
                                else{
                                        response.sendRedirect("changepassword.jsp?invalidpass=1");
                                }
                                
                        }
                        else{
                                response.sendRedirect("logout.jsp");
                                
                        }
                        cn.close();
                }
                catch(Exception e){
                        out.println(e.getMessage());
                }
            }
}
        else{
            response.sendRedirect("login1.jsp" );
     }
 %>

