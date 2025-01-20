package com.example.demo;

import org.springframework.http.ResponseEntity;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.example.demo.model.TestEmp;
import com.example.demo.model.TestLogin;
import com.example.demo.model.TestUser;
import com.example.demo.model.dao.TestEmpDao;
import com.example.demo.model.dao.EmployeeDAO;
import com.example.demo.model.dao.TestUserDao;
import com.example.demo.model.service.TestEmpService;
import com.example.demo.vo.TestEmpVO;

@Controller
@SessionAttributes("save")
public class TestLoginController {
	@Autowired
	private EmployeeDAO dao;
	@Autowired
	private TestUserDao userDao;
	@Autowired
	private TestEmpService empService;


	@RequestMapping(value = "/loginform")
	public String showform(Model m) {
		m.addAttribute("command", new TestLogin());
		return "loginform";
	}

	@RequestMapping(value = "/checklogin", method = RequestMethod.POST) 
	public String  checklogin(@ModelAttribute("login") TestLogin login, HttpServletRequest request, Model m) {
		if (login == null || login.getAccount() == null || login.getPassword() == null) {
			return "loginform";
	    }
		//TestLogin sqlob = dao.getpermission(login.getAccount());
//		if (sqlob != null && sqlob.getPassword() != null) {
//	        if (sqlob.getPassword().equals(login.getPassword())) {
//	            //System.out.print("success");
//	            m.addAttribute("successMessage", "Login successful!");
//	            m.addAttribute("save", login.getAccount()); // add session
//	            return "redirect:/viewlogin";
//	        } else {
//	            // Handle invalid password
//	        	m.addAttribute("errorMessage", "Incorrect password.");
//	            System.out.println("Incorrect password");
//	            return "loginform";
//	        }
//	    } else {
//	    	m.addAttribute("errorMessage", "Account does not exist.");
//	        System.out.println("Account does not exist or account is null");
	        return "loginform";
//	    }
	}
//		@ResponseBody
//		public Map<String, String> checklogin(@RequestBody Login login) {
//		Map<String, String> response = new HashMap<>();
//
//	    if (login == null || login.getAccount() == null || login.getPassword() == null) {
//	        response.put("status", "fail");
//	        response.put("message", "Invalid input.");
//	        return response;
//	    }
//
//	    Login sqlob = dao.getpermission(login.getAccount());
//	    if (sqlob != null && sqlob.getPassword() != null) {
//	        if (sqlob.getPassword().equals(login.getPassword())) {
//	            response.put("status", "success");
//	            response.put("message", "Login successful!");
//	        } else {
//	            response.put("status", "fail");
//	            response.put("message", "Incorrect password.");
//	        }
//	    } else {
//	        response.put("status", "fail");
//	        response.put("message", "Account does not exist.");
//	    }
//
//	    return response;
//	}
	@GetMapping("/viewlogin")
    public String viewLogin() {
        return "viewlogin";
	}
	@GetMapping("/searchEmployees")
	public String searchEmployees(@RequestParam(name = "username", required = false) String username,
	                              @RequestParam(name = "email", required = false) String email,
	                              @RequestParam(name = "designation", required = false) String designation,
	                              @RequestParam(name = "sortField", required = false, defaultValue = "userId") String sortField,
	                              @RequestParam(name = "sortOrder", required = false, defaultValue = "asc") String sortOrder,
	                              Model model) {
	    List<TestEmpVO> employees = empService.searchAndSortEmployees(username, email, designation, sortField, sortOrder);
	    model.addAttribute("employees", employees);
	    model.addAttribute("sortField", sortField);
	    model.addAttribute("sortOrder", sortOrder);
	    // Add search criteria to the model to retain it in the form
	    model.addAttribute("searchUsername", username);
	    model.addAttribute("searchEmail", email);
	    model.addAttribute("searchDesignation", designation);
	    return "viewlogin";
	}
	
	
	@RequestMapping("/loginfail")
	public String loginfail() {
		return "loginfail";
	}
	
	@PostMapping("/updateUser")
    public ResponseEntity<String> updateUser(@RequestBody Map<String, Object> updatedData) {
		Integer userId = (Integer) updatedData.get("userId");
        String username = (String) updatedData.get("username");
        String email = (String) updatedData.get("email");
        String password = (String) updatedData.get("password");
        String salary = (String) updatedData.get("salary");
        String designation = (String) updatedData.get("designation");

        boolean isUpdated = userDao.updateUser(userId, username, email, password, salary, designation);

        if (isUpdated) {
            return ResponseEntity.ok("User updated successfully");
        } else {
            return ResponseEntity.status(500).body("Failed to update user");
        }
    }
	
	@PostMapping("/addUser")
    public ResponseEntity<String> addUser(@RequestBody Map<String, Object> newUser) {
        String username = (String) newUser.get("username");
        String email = (String) newUser.get("email");
        String password = (String) newUser.get("password");
        String salary = (String) newUser.get("salary");
        String designation = (String) newUser.get("designation");

        boolean isAdded = userDao.addUser(username, email, password, salary, designation);

        if (isAdded) {
            return ResponseEntity.ok("User added successfully");
        } else {
            return ResponseEntity.status(500).body("Failed to add user");
        }
    }
	
	@DeleteMapping("/deleteUser")
    public ResponseEntity<String> deleteUser(@RequestBody Map<String, Object> request) {
        Integer userId = (Integer) request.get("userId");

        boolean isDeleted = userDao.deleteUser(userId);

        if (isDeleted) {
            return ResponseEntity.ok("User deleted successfully");
        } else {
            return ResponseEntity.status(500).body("Failed to delete user");
        }
    }
	@GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        // Invalidate the session to logout the user
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        // Redirect to the login page or a logout confirmation page
        return "redirect:/loginform";
    }
}
