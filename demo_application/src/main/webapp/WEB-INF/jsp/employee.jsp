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
	
       <c:if test="${not empty successMessage}">
		    <div class="alert alert-success alert-dismissible fade show" role="alert">
		        ${successMessage}
		        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		    </div>
		</c:if>
  <script>
        function filterEmployees() {
            const deptId = $('#departmentFilter').val();
            const managerName = $('#managerFilter').val().trim();

            if (managerName.length > 0 && !/^[a-zA-Z\s]+$/.test(managerName)) {
                alert("The field only accepts letters.");
                return;
            }

            if (managerName.length > 0 && managerName.length < 3) {
                return;
            }

            $.ajax({
                type: "GET",
                url: "/employee",
                data: { deptId: deptId, managerName: managerName },
                success: function (result) {
                    $('#employeeTable tbody').html($(result).find('tbody').html());
                },
                error: function (xhr, textStatus, errorThrown) {
                    console.error('Error:', textStatus, errorThrown);
                }
            });
        }

		  function addEmployee(){
        	const employeeName = $('#newEmployeeName').val().trim();
        	const hireDate = $('#newHireDate').val();
		    const yearsOfService = $('#newYearsOfService').val();
		    const managerId = $('#newManagerId').val().trim();
		    const departmentId = $('#newDepartment').val();
        	// Form Validation
		    if (employeeName.length < 3 || !/^[a-zA-Z\s]+$/.test(employeeName)) {
		        alert("Employee name must be at least 3 letters and contain only letters.");
		        return;
		    }
		    if (!hireDate) {
		        alert("Please enter a valid hire date.");
		        return;
		    }
		    if (!/^\d+$/.test(yearsOfService) || yearsOfService < 0) {
		        alert("Years of service must be a positive number.");
		        return;
		    }
		    if (!/^\d+$/.test(managerId)) {
		        alert("Manager ID must be numeric.");
		        return;
		    }
		
		    $.ajax({
		        type: "POST",
		        url: "/employee/add",
		        data: JSON.stringify({
		            employeeName: employeeName,
		            hireDate: hireDate,
		            yearsOfService: yearsOfService,
		            managerId: managerId,
		            deptId: departmentId
		        }),
		        contentType: "application/json",
		        success: function(response) {
		            alert("Employee added successfully!");
		            filterEmployees(); // Refresh employee table
		            // Reset form
		            $('#newEmployeeName').val('');
		            $('#newHireDate').val('');
		            $('#newYearsOfService').val('');
		            $('#newManagerId').val('');
		            $('#newDepartment').val('');
		        },
		        error: function(xhr, textStatus, errorThrown) {
		            alert("Error adding employee: " + errorThrown);
		        }
		    });
        }

        function resetForm() {
            $('#newEmployeeName').val('');
            $('#newHireDate').val('');
            $('#newYearsOfService').val('');
            $('#newManagerId').val('');
            $('#newDepartment').val('');
            $('#addEmployeeButton').text("Add Employee").attr("onclick", "addEmployee()");
        }

        $(document).ready(function() {
            $('#managerFilter').on('input', filterEmployees);
            $('#departmentFilter').change(filterEmployees);
            setTimeout(function () {
		        $(".alert").fadeOut("slow");
		    }, 3000); // Hide alert after 3 seconds
        });
    </script>
    
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

    <h1>Employee Information</h1>

    <div class="container">
        <div class="row mb-3">
            <div class="col-md-4">
                <label for="departmentFilter"><strong>Department:</strong></label>
                <select id="departmentFilter" class="form-select form-select-sm">
                    <option value="-1">All</option>
                    <c:forEach items="${departments}" var="department">
                        <option value="${department.deptId}">${department.deptName}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="col-md-4">
                <label for="managerFilter"><strong>Manager:</strong></label>
                <input type="text" id="managerFilter" class="form-control form-control-sm" placeholder="Enter manager name">
            </div>
        </div>

        <table id="employeeTable" class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>Department Name</th>
                    <th>Employee Name</th>
                    <th>Hire Date</th>
                    <th>Years of Service</th>
                    <th>Manager ID</th>
                    <th>Manager Name</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
			    <c:forEach items="${employees}" var="employee">
			           <tr id="employee-${employee.id}" data-dept-id="${employee.deptId}">
					        <td>${employee.deptName}</td>
					        <td>${employee.employeeName}</td>
					        <td>${employee.hireDate}</td>
					        <td>${employee.yearsOfService}</td>
					        <td>${employee.managerId}</td>
					        <td>${employee.managerName}</td>
					        <td>
					            <form action="/updateemp/${employee.id}" method="get" style="display:inline;">
			                        <button type="submit" class="btn btn-warning btn-sm">Edit</button>
			                    </form>
			
			                    <!-- Delete Button: Sends a POST request to delete -->
			                    <form action="/delete/${employee.id}" method="post" style="display:inline;">
			                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this employee?');">Delete</button>
			                    </form>
					        </td>
					    </tr>
			    </c:forEach>
			</tbody>
        </table>

        <!-- Add Employee Form -->
        <div class="add-employee-container">
            <h4>Add New Employee</h4>
            <div class="row">
                <div class="col-md-4">
                    <label>Name:</label>
                    <input type="text" id="newEmployeeName" class="form-control form-control-sm" placeholder="Employee Name">
                </div>

                <div class="col-md-4">
                    <label>Hire Date:</label>
                    <input type="date" id="newHireDate" class="form-control form-control-sm">
                </div>

                <div class="col-md-4">
                    <label>Years of Service:</label>
                    <input type="number" id="newYearsOfService" class="form-control form-control-sm" placeholder="Years">
                </div>
            </div>

            <div class="row mt-2">
                <div class="col-md-4">
                    <label>Manager ID:</label>
                    <input type="text" id="newManagerId" class="form-control form-control-sm" placeholder="Manager ID">
                </div>

                <div class="col-md-4">
                    <label>Department:</label>
                    <select id="newDepartment" class="form-select form-select-sm">
                        <c:forEach items="${departments}" var="department">
                            <option value="${department.deptId}">${department.deptName}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-md-4 d-flex align-items-end">
                    <button onclick="addEmployee()" class="btn btn-primary btn-sm w-100">Add Employee</button>
                </div>
            </div>
        </div>
    </div>

</body>
</html>

       
