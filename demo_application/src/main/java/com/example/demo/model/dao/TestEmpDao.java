 package com.example.demo.model.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.example.demo.model.TestEmp;
import com.example.demo.vo.TestEmpVO;

@Repository
public class TestEmpDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public void save(TestEmp emp) {
		String query = "INSERT INTO emp(name, salary, designation) VALUES (?, ?, ?)";
		jdbcTemplate.update(query, emp.getName(), emp.getSalary(), emp.getDesignation());
	}

	public List<TestEmp> getEmployees() {
		String query = "SELECT * FROM emp";
		List<TestEmp> list = jdbcTemplate.query(query, new BeanPropertyRowMapper(TestEmp.class));
		return list;
	}

	public TestEmp getEmpById(int id) {
		String query = "SELECT * FROM emp WHERE id=?";
		return (TestEmp) jdbcTemplate.queryForObject(query, new Object[] { id }, new BeanPropertyRowMapper(TestEmp.class));
	}

	public void update(TestEmp emp) {
		String query = "UPDATE emp SET name=?, salary=?, designation=? WHERE id=?";
		jdbcTemplate.update(query, new Object[] { emp.getName(), emp.getSalary(), emp.getDesignation(), emp.getId() });
	}

	public void delete(int id) {
		String query = "DELETE FROM emp WHERE id=?";
		jdbcTemplate.update(query, id);
	}
	public List<TestEmpVO> findEmployees(String username, String email, String designation, String sortField, String sortOrder) {
        StringBuilder sql = new StringBuilder("SELECT u.id AS userId, u.username, u.email, l.password, e.salary, e.designation " +
                     "FROM users u " +
                     "JOIN login l ON u.username = l.account " +
                     "JOIN emp e ON u.username = e.name " +
                     "WHERE 1=1 ");

        if (username != null && !username.isEmpty()) {
            sql.append("AND u.username LIKE '%").append(username).append("%' ");
        }
        if (email != null && !email.isEmpty()) {
            sql.append("AND u.email LIKE '%").append(email).append("%' ");
        }
        if (designation != null && !designation.isEmpty()) {
            sql.append("AND e.designation LIKE '%").append(designation).append("%' ");
        }

        if (sortField != null && !sortField.isEmpty() && sortOrder != null && !sortOrder.isEmpty()) {
            sql.append("ORDER BY ").append(sortField).append(" ").append(sortOrder);
        }

        return jdbcTemplate.query(sql.toString(), new BeanPropertyRowMapper<>(TestEmpVO.class));
    }

}
