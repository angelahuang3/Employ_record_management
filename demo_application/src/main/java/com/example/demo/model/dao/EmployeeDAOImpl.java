package com.example.demo.model.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.example.demo.model.Department;
import com.example.demo.model.EmployeeDetails;


@Repository
public class EmployeeDAOImpl implements EmployeeDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<EmployeeDetails> getEmployeeDetails() {
        String sql = "SELECT " +
                     "    d.dept_name AS deptName, " +
                     "    e.employee_id AS employeeId, " +
                     "    e.employee_name AS employeeName, " +
                     "    e.employee_hire_date AS hireDate, " +
                     "    e.year_of_service AS yearsOfService, " +
                     "    e.manager_id AS managerId, " +
                     "    m.employee_name AS managerName " +
                     "FROM " +
                     "    department d " +
                     "    JOIN employee e ON d.dept_id = e.dept_id " +
                     "    LEFT JOIN employee m ON e.manager_id = m.employee_id";

        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            EmployeeDetails details = new EmployeeDetails();
            details.setDeptName(rs.getString("deptName"));
            details.setId(rs.getInt("employeeId"));
            details.setEmployeeName(rs.getString("employeeName"));
            details.setHireDate(rs.getDate("hireDate"));
            details.setYearsOfService(rs.getInt("yearsOfService"));
            details.setManagerId(rs.getInt("managerId"));
            details.setManagerName(rs.getString("managerName"));
            return details;
        });
    }
    
    @Override
    public EmployeeDetails getEmployeeById(int id) {
        String sql = "SELECT d.dept_id AS deptId, "+ 
        			 "		 d.dept_name AS deptName, " +
                     "       e.employee_id AS employeeId, " +
                     "       e.employee_name AS employeeName, " +
                     "       e.employee_hire_date AS hireDate, " +
                     "       e.year_of_service AS yearsOfService, " +
                     "       e.manager_id AS managerId, " +
                     "       m.employee_name AS managerName " +
                     "FROM department d " +
                     "JOIN employee e ON d.dept_id = e.dept_id " +
                     "LEFT JOIN employee m ON e.manager_id = m.employee_id " +
                     "WHERE e.employee_id = ?";

        return jdbcTemplate.queryForObject(sql, new Object[]{id}, (rs, rowNum) -> {
            EmployeeDetails details = new EmployeeDetails();
            details.setDeptId(rs.getInt("deptId"));
            details.setDeptName(rs.getString("deptName"));
            details.setId(rs.getInt("employeeId"));
            details.setEmployeeName(rs.getString("employeeName"));
            details.setHireDate(rs.getDate("hireDate"));
            details.setYearsOfService(rs.getInt("yearsOfService"));
            details.setManagerId(rs.getInt("managerId"));
            details.setManagerName(rs.getString("managerName"));
            return details;
        });
    }

    
    @Override
    public List<EmployeeDetails> getEmployeeDetailsByDepartment(int deptId) {
        // Implementation for fetching employee details by department
        String sql = "SELECT d.dept_name AS deptName, " +
                     "       e.employee_name AS employeeName, " +
                     "       e.employee_hire_date AS hireDate, " +
                     "       e.year_of_service AS yearsOfService, " +
                     "       e.manager_id AS managerId, " +
                     "       m.employee_name AS managerName " +
                     "FROM department d " +
                     "JOIN employee e ON d.dept_id = e.dept_id " +
                     "LEFT JOIN employee m ON e.manager_id = m.employee_id " +
                     "WHERE d.dept_id = ?";

        return jdbcTemplate.query(sql, new Object[]{deptId}, (rs, rowNum) -> {
            EmployeeDetails details = new EmployeeDetails();
            details.setDeptName(rs.getString("deptName"));
            details.setEmployeeName(rs.getString("employeeName"));
            details.setHireDate(rs.getDate("hireDate"));
            details.setYearsOfService(rs.getInt("yearsOfService"));
            details.setManagerId(rs.getInt("managerId"));
            details.setManagerName(rs.getString("managerName"));
            return details;
        });
    }
    
    @Override
    public List<EmployeeDetails> getEmployeeDetailsByManager(String manageName) {
        // Implementation for fetching employee details by department
        String sql = "SELECT d.dept_name AS deptName, " +
                     "       e.employee_name AS employeeName, " +
                     "       e.employee_hire_date AS hireDate, " +
                     "       e.year_of_service AS yearsOfService, " +
                     "       e.manager_id AS managerId, " +
                     "       m.employee_name AS managerName " +
                     "FROM department d " +
                     "JOIN employee e ON d.dept_id = e.dept_id " +
                     "LEFT JOIN employee m ON e.manager_id = m.employee_id " +
                     "WHERE LOWER(m.employee_name) LIKE LOWER(?)";

        return jdbcTemplate.query(sql, new Object[]{"%" + manageName + "%"}, (rs, rowNum) -> {
            EmployeeDetails details = new EmployeeDetails();
            details.setDeptName(rs.getString("deptName"));
            details.setEmployeeName(rs.getString("employeeName"));
            details.setHireDate(rs.getDate("hireDate"));
            details.setYearsOfService(rs.getInt("yearsOfService"));
            details.setManagerId(rs.getInt("managerId"));
            details.setManagerName(rs.getString("managerName"));
            return details;
        });
    }
    @Override
    public List<Department> getAllDepartments() {
        String sql = "SELECT dept_id, dept_name FROM department";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Department department = new Department();
            department.setDeptId(rs.getInt("dept_id"));
            department.setDeptName(rs.getString("dept_name"));
            return department;
        });
    }
    @Override
    public void addEmployee(EmployeeDetails newEmployee) {
        // Insert new employee with deptId
        String insertSql = "INSERT INTO employee (employee_name, employee_hire_date, year_of_service, manager_id, dept_id) " +
                           "VALUES (?, ?, ?, ?, ?)";

        jdbcTemplate.update(insertSql,
            newEmployee.getEmployeeName(),
            newEmployee.getHireDate(),
            newEmployee.getYearsOfService(),
            newEmployee.getManagerId(),
            newEmployee.getDeptId()  
        );
    }
    
    @Override
    public void updateEmployee(EmployeeDetails employee) {
        String sql = "UPDATE employee SET " +
                     "employee_name = ?, " +
                     "employee_hire_date = ?, " +
                     "year_of_service = ?, " +
                     "manager_id = ?, " +
                     "dept_id = ? " +
                     "WHERE employee_id = ?";

        jdbcTemplate.update(sql,
            employee.getEmployeeName(),
            employee.getHireDate(),
            employee.getYearsOfService(),
            employee.getManagerId(),
            employee.getDeptId(),
            employee.getId()
        );
    }

    @Override
    public void deleteEmployee(int id) {
        String sql = "DELETE FROM employee WHERE employee_id = ?";
        jdbcTemplate.update(sql, id);
    }

}
