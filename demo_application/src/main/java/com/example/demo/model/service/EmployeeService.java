package com.example.demo.model.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.model.Department;
import com.example.demo.model.EmployeeDetails;
import com.example.demo.model.dao.EmployeeDAO;

@Service
public class EmployeeService {

    @Autowired
    private EmployeeDAO employeeDAO;

    public List<EmployeeDetails> getAllEmployeeDetails() {
        return employeeDAO.getEmployeeDetails();
    }

    public List<EmployeeDetails> getEmployeeDetailsByDepartment(int deptId) {
        return employeeDAO.getEmployeeDetailsByDepartment(deptId);
    }
    public List<Department> getAllDepartments() {
        return employeeDAO.getAllDepartments();
    }
    
    public List<EmployeeDetails> getEmployeeDetailsByManager(String managename) {
        return employeeDAO.getEmployeeDetailsByManager(managename);
    }
    
    public void addEmployee(EmployeeDetails employee) {
        employeeDAO.addEmployee(employee);
    }
    
    public EmployeeDetails getEmployeeById(int id) {
        return employeeDAO.getEmployeeById(id);
    }

    public void updateEmployee(EmployeeDetails employee) {
    	employeeDAO.updateEmployee(employee);
    }

    public void deleteEmployee(int id) {
    	employeeDAO.deleteEmployee(id);
    }

}
