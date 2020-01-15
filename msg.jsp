<%-- 
    Document   : msg.jsp
    Created on : Sep 17, 2019, 9:29:37 AM
    Author     : bpkhandelwal
--%>

<%@page import="java.sql.*,java.util.*" %>
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
                String msg=request.getParameter("msg");
                String tcode=request.getParameter("id");
                String fcode="";
                String temail="";
                int sn=0;
                  Class.forName("com.mysql.jdbc.Driver");
                 Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/db","root","");
                 Statement st=cn.createStatement();
                 Statement st1=cn.createStatement();
                 Statement st2=cn.createStatement();
                 Statement st3=cn.createStatement();
                 
                 ResultSet rs=st.executeQuery("select * from matrimonial where email='"+email+"' ");
                 if(rs.next()){
                        fcode=rs.getString(15);
                 }
                 else{
                        response.sendRedirect("login1.jsp?invalid email=1");
                 }
                 ResultSet rs1=st1.executeQuery("select * from matrimonial where code='"+tcode+"' ");
                 if(rs1.next()){
                     temail=rs1.getString(1);
                 }
                 else{
                      response.sendRedirect("user_profile.jsp");
                 }
                 
                 ResultSet rs2=st2.executeQuery("select max(sn) from inbox");
                 if(rs2.next()){
                        sn=rs2.getInt(1);
                 }
                 sn=sn+1;
                 String code="";
                 LinkedList l=new LinkedList();
                 for(char p='a';p<='z';p++){
                        l.add(p+"");
                        
                  }
                 for(char p='A';p<='Z';p++){
                     l.add(p+"");
                 }
                 for(int i=0;i<=9;i++){
                        l.add(i+"");
                 }
                 Collections.shuffle(l);
                 for(int i=0;i<=9;i++){
                        code=code+l.get(i);
                 }
                 code=code+"_"+sn;
                 
                 //st3.execute("insert into inbox values("+sn+",'"+code+"','"+fcode+"','"+email+"','"+tcode+"','"+temail+"','"+msg+"' ");
                 PreparedStatement ps=cn.prepareStatement("insert into inbox values(?,?,?,?,?,?,?)");
                 ps.setInt(1,sn);
                 ps.setString(2,code);
                 ps.setString(3,fcode);
                 ps.setString(4,email);
                 ps.setString(5,tcode);
                 ps.setString(6,temail);
                 ps.setString(7,msg);
                 ps.execute();
                 
                 response.sendRedirect("user_profile.jsp?id="+fcode+" &&succ=1 ");
            //   response.sendRedirect("inbox.jsp");
                 cn.close();
        }
       catch(Exception z){
                out.println(z.getMessage());
       }
    }
    else{
     response.sendRedirect("login1.jsp");       
    }
%>
