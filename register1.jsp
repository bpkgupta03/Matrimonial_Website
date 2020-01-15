<%-- 
    Document   : register.jsp
    Created on : Jul 31, 2019, 11:43:35 AM
    Author     : bpkhandelwal
--%>

<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<!DOCTYPE html>
<%
    
        if(request.getParameter("sn").length()==0){
            response.sendRedirect("index.jsp");
            
        }
        else{
                try{
                    
                
        
        int sn=Integer.parseInt(request.getParameter("sn"));
        String email=request.getParameter("email");
        String pass=request.getParameter("pass");
        String profiler=request.getParameter("applicant");
        String gender=request.getParameter("gender");
        
        String name=request.getParameter("user");
        String dob =request.getParameter("dob");
        String height=request.getParameter("height");
        String marital=request.getParameter("marital");
        String lang=request.getParameter("lang");
        String religion=request.getParameter("religion");

        
        String caste=request.getParameter("caste");
        String city=request.getParameter("city");
        String mobile=request.getParameter("mobile");
        
         Class.forName("com.mysql.jdbc.Driver");
        Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/db","root","");
        Statement st=cn.createStatement();
        ResultSet rs=st.executeQuery("select MAX(sn)from matrimonial");
        if(rs.next()){
                sn=rs.getInt(1);
                
        }
        sn=sn+1;
        LinkedList l=new LinkedList();
        for(char c='A';c<='Z';c++){
                l.add(c+'"');
        }
        for(char c='a';c<='z';c++){
                l.add(c+'"');
        }
        for(int i=0;i<=9;i++){
                l.add(i);
        }
        Collections.shuffle(l);
        String code="";
        
        for(int i=0;i<6;i++){
                code+=l.get(i);
        }
        code=code+"_"+sn;
         PreparedStatement ps=cn.prepareStatement("insert into matrimonial values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
         ps.setString(1,email);
         ps.setString(2,pass);
         ps.setString(3,profiler);
         ps.setString(4,gender);
         
         ps.setString(5,name);
         ps.setString(6,dob);
         ps.setString(7,height);
         ps.setString(8,marital);
         ps.setString(9,lang);
         ps.setString(10,religion);
           
         ps.setString(11,caste);

         ps.setString(12,city);
         ps.setString(13,mobile);
         ps.setInt(14,sn);
         ps.setString(15,code);
         
         ps.execute();
         response.sendRedirect("login1.jsp?succ=1");
         cn.close();
    }
    catch(Exception e){
            out.println(e.getMessage());
    }
        }
        
    
         
         
  %>       