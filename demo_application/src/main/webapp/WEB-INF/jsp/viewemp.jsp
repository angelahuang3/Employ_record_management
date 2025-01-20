<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html xmlns:mso="urn:schemas-microsoft-com:office:office" xmlns:msdt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Insert title here</title>

<!--[if gte mso 9]><xml>
<mso:CustomDocumentProperties>
<mso:_dlc_DocId msdt:dt="string">UA2KXXZD3HNA-387041628-295</mso:_dlc_DocId>
<mso:_dlc_DocIdItemGuid msdt:dt="string">4276fc76-4481-4c26-8a4f-2a07dbccc6dc</mso:_dlc_DocIdItemGuid>
<mso:_dlc_DocIdUrl msdt:dt="string">http://dkms/dep/106000/intra/_layouts/15/DocIdRedir.aspx?ID=UA2KXXZD3HNA-387041628-295, UA2KXXZD3HNA-387041628-295</mso:_dlc_DocIdUrl>
</mso:CustomDocumentProperties>
</xml><![endif]--> 
</head>
<body>
	<table border="1">
		<thead>
			<tr>
				<th>Id</th><th>Name</th><th>Salary</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="emp" items="${list}" varStatus="status">
				<tr>
					<td>${emp.id}</td>
					<td>${emp.name}</td>
					<td>${emp.salary}</td>
					<td><a href="editemp/${emp.id}"><button>edit</button></a></td>
					<td><a href="deleteemp/${emp.id}"><button>delete</button></a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>