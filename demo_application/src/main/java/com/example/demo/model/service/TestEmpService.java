package com.example.demo.model.service;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.model.TestEmp;
import com.example.demo.model.dao.TestEmpDao;
import com.example.demo.vo.TestEmpVO;
@Service
public class TestEmpService {
 @Autowired
 public TestEmpDao dao;
 private static final DecimalFormat decimalFormat = new DecimalFormat("0.00");
 
 //處理undo
 @Transactional
 public void save(TestEmp emp) {
	 dao.save(emp);
 }
 @Transactional(readOnly = true)
 public TestEmp getEmpById(int id) {
	 return dao.getEmpById(id);
 }
 public List<TestEmpVO> searchAndSortEmployees(String username, String email, String designation, String sortField, String sortOrder) {
	 List<TestEmpVO> employees = dao.findEmployees(username, email, designation, sortField, sortOrder);
     
     // Format the salary to two decimal places
     for (TestEmpVO employee : employees) {
         employee.setSalary(formatSalary(employee.getSalary()));
     }
     
     return employees;
 }
private BigDecimal formatSalary(BigDecimal salary) {
     // Ensure the salary is formatted to two decimal places
     return new BigDecimal(decimalFormat.format(salary));
}
public List<TestEmp> getEmployees() {
	// TODO Auto-generated method stub
	return dao.getEmployees();
}
public void update(TestEmp emp) {
	// TODO Auto-generated method stub
	
}
public void delete(int id) {
	// TODO Auto-generated method stub
	
}
}
