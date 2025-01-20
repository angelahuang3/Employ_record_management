<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<table>
    <thead>
        <tr>
            <th>Department Name</th>
            <th>Employee Name</th>
            <th>Hire Date</th>
            <th>Years of Service</th>
            <th>Manager ID</th>
            <th>Manager Name</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${employees}" var="employee">
            <tr>
                <td>${employee.deptName}</td>
                <td>${employee.employeeName}</td>
                <td>${employee.hireDate}</td>
                <td>${employee.yearsOfService}</td>
                <td>${employee.managerId}</td>
                <td>${employee.managerName}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
