<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Information</title>
    
    <!-- Bootstrap CSS -->

	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

	<!-- jQuery  -->
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

	<!-- Bootstrap JavaScript Bundle  -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
        /* Custom Styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        .filter-container {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }

        .filter-container select,
        .filter-container input {
            width: 200px;
            padding: 6px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tbody tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        /* Adjusting input field sizes */
        .form-control-sm {
            width: auto;
            max-width: 250px;
        }

        /* Ensure the Manager Name field is not too long */
        .manager-input {
            width: 180px;
        }

        .add-employee-container {
            margin-top: 20px;
            padding: 15px;
            border: 1px solid #ccc;
            background-color: white;
            border-radius: 5px;
        }
    </style>
</head>
<body>
<h1>Edit Employee</h1>  
<form action="/updatesave" method="post">   
    <table>    
        <tr style="display:none;">    
            <td>Id : </td>   
            <td><input type="text" name="id" value="${command.id}" readonly /></td>  
        </tr>  
        <tr>    
            <td>Name : </td>   
            <td><input type="text" name="employeeName" value="${command.employeeName}" /></td>  
        </tr>    
        <tr>    
            <td>Hire Date :</td>    
            <td>
                <input type="date" name="hireDate" value="${command.hireDate}" />
            </td>  
        </tr>  
        <tr>    
            <td>Years of Service :</td>    
            <td><input type="number" name="yearsOfService" value="${command.yearsOfService}" /></td>  
        </tr>   
        <tr>    
            <td>Manager ID :</td>    
            <td><input type="number" name="managerId" value="${command.managerId}" /></td>  
        </tr>  
        <tr>    
            <td>Department:</td>
            <td>
                <select name="deptId" class="form-select">
                    <c:forEach items="${departments}" var="department">
                        <option value="${department.deptId}" 
                            ${department.deptId eq command.deptId ? 'selected="selected"' : ''}>
                            ${department.deptName}
                        </option>
                    </c:forEach>
                </select>
            </td>
        </tr>
        <tr>    
            <td> </td>    
            <td><input type="submit" value="Save Changes" /></td>    
        </tr>    
    </table>    
</form>
</body>
</head>