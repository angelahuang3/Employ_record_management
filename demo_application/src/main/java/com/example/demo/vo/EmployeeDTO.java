package com.example.demo.vo;

public class EmployeeDTO {
    private Long employeeId;
    private String employeeName;
    private String managerId;
    private String hireDate;
    private int yearsOfService;
    private String departmentName;

    // Constructor
    public EmployeeDTO(Long employeeId, String employeeName, String managerId, String hireDate, int yearsOfService, String departmentName) {
        this.employeeId = employeeId;
        this.employeeName = employeeName;
        this.managerId = managerId;
        this.hireDate = hireDate;
        this.yearsOfService = yearsOfService;
        this.departmentName = departmentName;
    }

    // Getters and setters
    public Long getEmployeeId() { return employeeId; }
    public void setEmployeeId(Long employeeId) { this.employeeId = employeeId; }
    public String getEmployeeName() { return employeeName; }
    public void setEmployeeName(String employeeName) { this.employeeName = employeeName; }
    public String getManagerId() { return managerId; }
    public void setManagerId(String managerId) { this.managerId = managerId; }
    public String getHireDate() { return hireDate; }
    public void setHireDate(String hireDate) { this.hireDate = hireDate; }
    public int getYearsOfService() { return yearsOfService; }
    public void setYearsOfService(int yearsOfService) { this.yearsOfService = yearsOfService; }
    public String getDepartmentName() { return departmentName; }
    public void setDepartmentName(String departmentName) { this.departmentName = departmentName; }
}
