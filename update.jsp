<%-- 
    Document   : update.jsp
    Created on : Jul 27, 2019, 4:36:53 PM
    Author     : bpkhandelwal
--%>

<%@page import ="java.sql.*"%>
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
  if(email!=null && session.getAttribute(email)!=null){

    try{

        String profile=request.getParameter("profile");
        
        String Gender=request.getParameter("gender");
        String name=request.getParameter("user");
        String dob=request.getParameter("dob");
        String height=request.getParameter("height");
        String marital=request.getParameter("marital");
        String mt=request.getParameter("mt");
        String religion=request.getParameter("religion");
        String caste=request.getParameter("caste");
        
        String city=request.getParameter("city");
        String mob=request.getParameter("mob");
        
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/db","root","");
         PreparedStatement ps=cn.prepareStatement("update matrimonial set CreateProfilefor=?,Gender=?, name=?,Dateofbirth=?,height=?,MaritalStatus=?,MotherTongue=?,Religion=?,Caste=?,City=?,Mobile_no=?  where email=?");
         ps.setString(1,profile);
         ps.setString(2,name);
         ps.setString(3,dob);
         ps.setString(4,Gender);
         
         ps.setString(5,height);
         ps.setString(6,marital);
         ps.setString(7,mt);
         ps.setString(8,religion);
        ps.setString(9,caste);
          
         ps.setString(10,city);
         ps.setString(11,mob);
         ps.setString(12,email);
       
         ps.execute();
         response.sendRedirect("login1.jsp?succ=1");
            cn.close();
        
        }
       catch(Exception e){
                out.println(e.getMessage());
          }
   }
  else{
        response.sendRedirect("login1.jsp");
     }
  
      %>
  
                