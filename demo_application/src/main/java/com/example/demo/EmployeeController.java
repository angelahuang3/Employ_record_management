package com.example.demo;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.model.Department;
import com.example.demo.model.EmployeeDetails;
import com.example.demo.model.service.EmployeeService;

@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    @GetMapping("/employee")
    public String displayEmployeeDetails(@RequestParam(name = "deptId", required = false) Integer deptId,
                                         @RequestParam(name = "managerName", required = false) String managerName,
                                         Model model) {
        List<EmployeeDetails> employees;

        if (deptId != null && deptId != -1) {
            employees = employeeService.getEmployeeDetailsByDepartment(deptId);
        } else if (managerName != null && managerName.length() >= 3) {
            employees = employeeService.getEmployeeDetailsByManager(managerName);
        } else {
            employees = employeeService.getAllEmployeeDetails();
        }

        List<Department> departments = employeeService.getAllDepartments();

        model.addAttribute("departments", departments);
        model.addAttribute("employees", employees);

        return "employee";
    }

    @PostMapping("/employee/add")
    @ResponseBody
    public ResponseEntity<String> addEmployee(@RequestBody EmployeeDetails newEmployee) {
        try {
            employeeService.addEmployee(newEmployee);
            return ResponseEntity.ok("Employee added successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error adding employee: " + e.getMessage());
        }
    }

    @RequestMapping(value = "/updateemp/{id}", method = RequestMethod.GET)
    public String edit(@PathVariable int id, Model m) {
        EmployeeDetails emp = employeeService.getEmployeeById(id);
        List<Department> departments = employeeService.getAllDepartments();
   
        m.addAttribute("departments", departments);
        m.addAttribute("command", emp);

        return "empeditform"; 
    }

    @RequestMapping(value = "/updatesave", method = RequestMethod.POST)
    public String editsave(@ModelAttribute EmployeeDetails emp, RedirectAttributes redirectAttributes) {
        employeeService.updateEmployee(emp);
        redirectAttributes.addFlashAttribute("successMessage", "Employee updated successfully!");
        
        return "redirect:/employee"; 
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
    public String delete(@PathVariable int id, RedirectAttributes redirectAttributes) {
        employeeService.deleteEmployee(id);
        redirectAttributes.addFlashAttribute("successMessage", "Employee deleted successfully!");

        return "redirect:/employee"; 
    }

}
