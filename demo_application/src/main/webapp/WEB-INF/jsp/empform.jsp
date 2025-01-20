<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html xmlns:mso="urn:schemas-microsoft-com:office:office"
 xmlns:msdt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882">

<head>
<meta charset="BIG5">
<title>Insert title here</title>
</head>
<body>

       <h1>Edit Employee</h1>  
       <form:form method="post" action="save">    
        <table >     
         <tr>    
          <td>Name : </td>   
          <td><form:input path="name"  /></td>  
         </tr>    
         <tr>    
          <td>Salary :</td>    
          <td><form:input path="salary" /></td>  
         </tr>   
         <tr>    
          <td>Designation :</td>    
          <td><form:input path="designation" /></td>  
         </tr>   
         <tr>    
          <td> </td>    
          <td><input type="submit" value="Save" /></td>    
         </tr>    
        </table>    
       </form:form> 

</body>
</html>