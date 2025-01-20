<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html xmlns:mso="urn:schemas-microsoft-com:office:office" xmlns:msdt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Insert title here</title>

<!--[if gte mso 9]><xml>
<mso:CustomDocumentProperties>
<mso:_dlc_DocId msdt:dt="string">UA2KXXZD3HNA-387041628-294</mso:_dlc_DocId>
<mso:_dlc_DocIdItemGuid msdt:dt="string">ec778021-85d9-443f-9270-efded0d31dfe</mso:_dlc_DocIdItemGuid>
<mso:_dlc_DocIdUrl msdt:dt="string">http://dkms/dep/106000/intra/_layouts/15/DocIdRedir.aspx?ID=UA2KXXZD3HNA-387041628-294, UA2KXXZD3HNA-387041628-294</mso:_dlc_DocIdUrl>
</mso:CustomDocumentProperties>
</xml><![endif]-->
</head>
<body>
        <h1>Edit Employee</h1>  
       <form:form method="post" action="../editsave" modelAttibute="command">    
        <table >    
         <tr style="display:none;">    
          <td>Id : </td>   
          <td><form:input path="id"  /></td>  
         </tr>  
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
          <td><input type="submit" value="Edit" /></td>    
         </tr>    
        </table>    
       </form:form> 
</body>
</html>