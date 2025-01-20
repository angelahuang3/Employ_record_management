<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Details</title>
<link rel="stylesheet" type="text/css" href="/resources/static/css/style.css">
</head>
<body>
    <h1>Employee Details</h1>
 
    <!-- Logout button -->
    <button onclick="logout()">Logout</button>

    <form action="/searchEmployees" method="get">
        <label for="username" style="display: inline-block; width: 100px;">Username:</label>
        <input type="text" id="username" name="username" value="${searchUsername}" style="width: 200px; margin-right: 10px;">
        
        <label for="email" style="display: inline-block; width: 100px;">Email:</label>
        <input type="text" id="email" name="email" value="${searchEmail}" style="width: 200px; margin-right: 10px;">
        
        <label for="designation" style="display: inline-block; width: 100px;">Designation:</label>
        <input type="text" id="designation" name="designation" value="${searchDesignation}" style="width: 200px; margin-right: 10px;">
        
        <button type="submit" style="width: 100px; height: 30px;">Search</button>
    </form>

    <c:if test="${not empty employees}">
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <c:set var="queryParams">
                            <c:if test="${not empty param.name}">name=${param.name}&amp;</c:if> 
                            <c:if test="${not empty param.email}">email=${param.email}&amp;</c:if>
                            <c:if test="${not empty param.designation}">designation=${param.designation}&amp;</c:if>
                        </c:set>
                        <th><a href="?${queryParams}sortField=userId&amp;sortOrder=${sortOrder == 'asc' ? 'desc' : 'asc'}">User ID</a></th>
                        <th><a href="?${queryParams}sortField=username&amp;sortOrder=${sortOrder == 'asc' ? 'desc' : 'asc'}">Username</a></th>
                        <th><a href="?${queryParams}sortField=email&amp;sortOrder=${sortOrder == 'asc' ? 'desc' : 'asc'}">Email</a></th>
                        <th><a href="?${queryParams}sortField=password&amp;sortOrder=${sortOrder == 'asc' ? 'desc' : 'asc'}">Password</th>
                        <th><a href="?${queryParams}sortField=salary&amp;sortOrder=${sortOrder == 'asc' ? 'desc' : 'asc'}">Salary</a></th>
                        <th><a href="?${queryParams}sortField=designation&amp;sortOrder=${sortOrder == 'asc' ? 'desc' : 'asc'}">Designation</a></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="employee" items="${employees}">
                        <tr>
                            <td>${employee.userId}</td>
                            <td id="username_${employee.userId}">${employee.username}</td>
                            <td id="email_${employee.userId}">${employee.email}</td>
                            <td id="password_${employee.userId}">${employee.password}</td>
                            <td id="salary_${employee.userId}">
                                <fmt:formatNumber value="${employee.salary}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                            </td>
                            <td id="designation_${employee.userId}">${employee.designation}</td>
                            <td>
							    <button id="editButton_${employee.userId}" onclick="editUser(${employee.userId})">Edit</button>
							    <button id="saveButton_${employee.userId}" onclick="saveUser(${employee.userId})" style="display:none;">Save</button>
							    <button id="cancelButton_${employee.userId}" onclick="cancelEdit(${employee.userId})" style="display:none;">Cancel</button>
							    <button id="deleteButton_${employee.userId}" onclick="deleteUser(${employee.userId})">Delete</button>
                            </td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td>New</td>
                        <td><input type="text" id="newUsername" name="newUsername" onBlur="onBlurValidation('newUsername');"/></td>
                        <td><input type="email" id="newEmail" name="newEmail" onBlur="onBlurValidation('newEmail');"/></td>
                        <td><input type="password" id="newPassword" name="newPassword" /></td>
                        <td><input type="text" id="newSalary" name="newSalary" onBlur="onBlurValidation('newSalary');"/></td>
                        <td><input type="text" id="newDesignation" name="newDesignation"/></td>
                        <td>
                            <button type="button" onclick="addUser()">Add User</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </c:if>
    
    <script>
        // Function to validate user inputs
        // Function to validate user inputs
		function validateInputs(username, email, salary) {
		    var errors = [];
		
		    // Validate username: alphanumeric characters only
		    if (username != null && !/^[a-zA-Z\s]+$/.test(username)) {
		        errors.push("Username can only contain alphabets and spaces.");
		    }
		
		    // Validate email: must contain @ symbol
		    if (email != null && !/\S+@\S+\.\S+/.test(email)) {
		        errors.push("Invalid email format.");
		    }
		
		    // Validate salary: numeric value only with optional commas
		    if (salary != null) {
		        // Remove commas from salary string for validation
		        var formattedSalary = salary.replace(/,/g, '');
		        if (!/^\d+(\.\d{1,2})?$/.test(formattedSalary)) {
		            errors.push("Salary must be a numeric value with up to two decimal places.");
		        }
		    }
		
		    return errors;
		}

        
        function editUser(userId) {
		    var fields = ['username', 'email', 'password', 'salary', 'designation'];
		    fields.forEach(function(field) {
		        var cell = document.getElementById(field + "_" + userId);
		        var value = cell.innerText;
		        var inputId = field + "_input_" + userId;
		        var inputElement = '<input type="text" id="' + inputId + '" name="' + inputId + '" value="' + value + '" />';
		        cell.innerHTML = inputElement;
		        
		        // Store original values in the data attribute
		        cell.setAttribute('data-original-value', value);
		    });
		
		    // Hide the edit button and show the save and cancel buttons
		    var editButton = document.getElementById('editButton_' + userId);
		    var saveButton = document.getElementById('saveButton_' + userId);
		    var cancelButton = document.getElementById('cancelButton_' + userId);
		    editButton.style.display = 'none';
		    saveButton.style.display = 'inline';
		    cancelButton.style.display = 'inline';
		}

        
        function cancelEdit(userId) {
		    var fields = ['username', 'email', 'password', 'salary', 'designation'];
		    fields.forEach(function(field) {
		        var cell = document.getElementById(field + "_" + userId);
		        var originalValue = cell.getAttribute('data-original-value');
		        cell.innerHTML = originalValue;
		    });
		
		    // Hide the save and cancel buttons and show the edit button
		    var editButton = document.getElementById('editButton_' + userId);
		    var saveButton = document.getElementById('saveButton_' + userId);
		    var cancelButton = document.getElementById('cancelButton_' + userId);
		    editButton.style.display = 'inline';
		    saveButton.style.display = 'none';
		    cancelButton.style.display = 'none';
		}
		           
      	function saveUser(userId) {
		    var fields = ['username', 'email', 'password', 'salary', 'designation'];
		    var updatedData = { userId: userId };
		    
		    fields.forEach(function(field) {
		        var input = document.getElementById(field + '_input_' + userId);
		        var value = input.value;
		
		        // Format salary to two decimal places with comma separator
		       
	            if (field === 'salary') {
       				 var salaryValue = parseFloat(value.replace(/,/g, ''));
    				 var salary = salaryValue.toFixed(2); // Ensure salary is formatted to two decimal places
		        }
		
		        var cell = document.getElementById(field + "_" + userId);
		        cell.innerText = value;
		        updatedData[field] = value;
		    });
		
		    // Hide the save button and show the edit button
		    var editButton = document.getElementById('editButton_' + userId);
		    var saveButton = document.getElementById('saveButton_' + userId);
		    saveButton.style.display = 'none';
		    editButton.style.display = 'inline';
		
		    // Send updated data to the server using AJAX
		    var xhr = new XMLHttpRequest();
		    xhr.open('POST', '/updateUser', true);
		    xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
		    xhr.onreadystatechange = function() {
		        if (xhr.readyState === 4) {
		            if (xhr.status === 200) {
		                // Handle success response
		                console.log('User updated successfully');
		            } else {
		                // Handle error response
		                console.error('Failed to update user');
		            }
		        }
		    };
		    xhr.send(JSON.stringify(updatedData));
		}
		
		function addUser() {
		    var username = document.getElementById('newUsername').value;
		    var email = document.getElementById('newEmail').value;
		    var password = document.getElementById('newPassword').value;
		    ≈ salary = document.getElementById('newSalary').value;
		    var designation = document.getElementById('newDesignation').value;
		
		    // Validate inputs
		    var validationErrors = validateInputs(username, email, salary);
		
		    // Display errors if any
		    if (validationErrors.length > 0) {
		        alert("Please correct the following errors:\n" + validationErrors.join("\n"));
		        return; // Exit function if there are validation errors
		    }
		
		    // Remove commas and format salary to two decimal places
		    var formattedSalary = parseFloat(salary.replace(/,/g, '')).toFixed(2);
		
		    var newUser = {
		        username: username,
		        email: email,
		        password: password,
		        salary: formattedSalary,
		        designation: designation
		    };
		
		    // Send data to the server using AJAX
		    var xhr = new XMLHttpRequest();
		    xhr.open('POST', '/addUser', true);
		    xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
		    xhr.onreadystatechange = function() {
		        if (xhr.readyState === 4) {
		            if (xhr.status === 200) {
		                // Handle success response
		                console.log('User added successfully');
		                location.reload(); // Optionally reload the page to show the new user
		            } else {
		                // Handle error response
		                console.error('Failed to add user');
		            }
		        }
		    };
		    xhr.send(JSON.stringify(newUser));
		}


        function deleteUser(userId) {
            // Send delete request to the server using AJAX
            var xhr = new XMLHttpRequest();
            xhr.open('DELETE', '/deleteUser', true);
            xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        // Handle success response
                        console.log('User deleted successfully');
                        location.reload(); // Optionally reload the page to remove the deleted user
                    } else {
                        // Handle error response
                        console.error('Failed to delete user');
                    }
                }
            };
            xhr.send(JSON.stringify({ userId: userId }));
        }

        // Global variable to store the last validation error message
        var lastValidationMessage = '';
        
        // Function to handle onBlur validation for inputs
        function onBlurValidation(fieldId) {
            var fieldValue = document.getElementById(fieldId).value.trim();
            var validationMessage = '';
            if (fieldId == null) return;
            switch (fieldId) {
                case 'newUsername':
                    if (!/^[a-zA-Z\s]+$/.test(fieldValue)) {
                        validationMessage = "Username can only contain alphabets and spaces.";
                    }
                    break;
                case 'newEmail':
                    if (!/\S+@\S+\.\S+/.test(fieldValue)) {
                        validationMessage = "Invalid email format.";
                    }
                    break;
                case 'newSalary':
                    if (!/^\d+(\.\d{1,2})?$/.test(fieldValue)) {
                        validationMessage = "Salary must be a numeric value with up to two decimal places.";
                    }
                    break;
                // Add cases for other input fields as needed
            }
        
            // Check if this validation message is the same as the last one shown
            if (validationMessage != lastValidationMessage) {
                lastValidationMessage = validationMessage; // Update the last validation message
        
                // Show the validation message if it's not empty
                if (validationMessage != '') {
                    alert(validationMessage);
                    document.getElementById(fieldId).focus(); // Keep focus on the current field
                }
            }
        }
        // Function to format number with commas and fixed decimal places
		function formatNumber(number) {
		    // Convert to number and ensure it's a valid number
		    number = parseFloat(number);
		
		    // Use Intl.NumberFormat to format with commas and two decimal places
		    return new Intl.NumberFormat('en-US', {
		        minimumFractionDigits: 2,
		        maximumFractionDigits: 2
		    }).format(number);
		}

        function logout() {
            // Clear any session storage or tokens
            // Example: localStorage.removeItem('accessToken');
            
            // Redirect to logout endpoint or login page
            window.location.href = '/logout'; // Redirect to your logout endpoint
        }
    </script>
</body>
</html>
