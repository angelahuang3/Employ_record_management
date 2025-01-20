package com.example.demo.model.dao;

import java.math.BigDecimal;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.model.TestUser;
import com.example.demo.vo.TestEmpVO;

@Repository
public class TestUserDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List getUsers() {
        String query = "SELECT * FROM users";
        List<TestUser> userList = jdbcTemplate.query(query, new BeanPropertyRowMapper<>(TestUser.class));
        return userList;
    }
    @Transactional
    public boolean updateUser(Integer userId, String username, String email, String password, String salary, String designation) {
        try {
            // Convert salary to a numeric type
            BigDecimal salaryNum = new BigDecimal(salary.replace(",", ""));
            // Update the users table
            String sqlUsers = "UPDATE users SET username = ?, email = ? WHERE id = ?";
            jdbcTemplate.update(sqlUsers, username, email, userId);

            // Update the login table
            String sqlLogin = "UPDATE login SET account = ?, password = ? WHERE account = (SELECT username FROM users WHERE id = ?)";
            jdbcTemplate.update(sqlLogin, username, password, userId);

            // Update the emp table
            String sqlEmp = "UPDATE emp SET name = ?, salary = ?, designation = ? WHERE name = (SELECT username FROM users WHERE id = ?)";
            jdbcTemplate.update(sqlEmp, username, salaryNum, designation, userId);

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    @Transactional
    public boolean addUser(String username, String email, String password, String salary, String designation) {
        try {
            // Convert salary to a numeric type
            double numericSalary = Double.parseDouble(salary);

            // Insert into users table
            String sqlUsers = "INSERT INTO users (username, email) VALUES (?, ?)";
            jdbcTemplate.update(sqlUsers, username, email);

            // Insert into login table
            String sqlLogin = "INSERT INTO login (account, password) VALUES (?, ?)";
            jdbcTemplate.update(sqlLogin, username, password);

            // Insert into emp table
            String sqlEmp = "INSERT INTO emp (name, salary, designation) VALUES (?, ?, ?)";
            jdbcTemplate.update(sqlEmp, username, numericSalary, designation);

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Transactional
    public boolean deleteUser(Integer userId) {
        try {
            String deleteUsersSql = "DELETE FROM users WHERE id = ?";
            String deleteLoginSql = "DELETE FROM login WHERE id = ?";
            String deleteEmpSql = "DELETE FROM emp WHERE id = ?";
            
            jdbcTemplate.update(deleteUsersSql, userId);
            jdbcTemplate.update(deleteLoginSql, userId);
            jdbcTemplate.update(deleteEmpSql, userId);         
            return true; 
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}

