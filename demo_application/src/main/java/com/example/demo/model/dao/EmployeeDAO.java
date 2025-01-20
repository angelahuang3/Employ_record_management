package com.example.demo.model.dao;

import java.util.List;

import com.example.demo.model.Department;
import com.example.demo.model.EmployeeDetails;

public interface EmployeeDAO {
    List<EmployeeDetails> getEmployeeDetails();
    
    List<EmployeeDetails> getEmployeeDetailsByDepartment(int deptId);
    
    List<Department> getAllDepartments();
    
    List<EmployeeDetails> getEmployeeDetailsByManager(String managename);
    
    void addEmployee(EmployeeDetails employee);
    
    EmployeeDetails getEmployeeById(int id);
    
    void updateEmployee(EmployeeDetails employee);
    
    void deleteEmployee(int id);
}
