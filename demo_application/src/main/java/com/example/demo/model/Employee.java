package com.example.demo.model;

public class Employee {
    private int id;
    private String employeeName;
    private int deptId;
    private String managerId;
    private String hireDateString; // This will be a formatted date string, not a Date object
    private int yearsOfService;
    private String departmentName; // Assuming you just need the department name

    // Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    public String getManagerId() {
        return managerId;
    }

    public void setManagerId(String managerId) {
        this.managerId = managerId;
    }

    public String getHireDateString() {
        return hireDateString;
    }

    public void setHireDateString(String hireDateString) {
        this.hireDateString = hireDateString;
    }

    public int getYearsOfService() {
        return yearsOfService;
    }

    public void setYearsOfService(int yearsOfService) {
        this.yearsOfService = yearsOfService;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

	public int getDeptId() {
		return deptId;
	}

	public void setDeptId(int deptId) {
		this.deptId = deptId;
	}
}
