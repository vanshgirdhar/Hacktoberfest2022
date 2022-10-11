import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;

import java.util.LinkedList;

import java.util.Scanner;

class Employee implements Serializable {
      
      public static Employee readData() {
            String name, designation;
            double salary;
            
            Scanner sc = new Scanner(System.in);
            
            System.out.println("Enter name: ");
            name = sc.next();
            
            System.out.println("Enter Designation: ");
            designation = sc.next();
            
            System.out.println("Enter salary: ");
            salary = sc.nextDouble();
            
//          sc.close();
            
            return new Employee(name, designation, salary);
      }
      
      private static final long serialVersionUID = 1L;
      
      private String name;
      private long empID;
      private long nextEmpID = 1;
      private String designation;
      private double salary;
      
      public Employee(String name, String designation, double salary) {
            this.name = name;
            this.empID = nextEmpID++;
            this.designation = designation;
            this.salary = salary;
      }
      
      public String getName() {
            return name;
      }
      public long getEmpID() {
            return empID;
      }
      public String getDesignation() {
            return designation;
      }
      public double getSalary() {
            return salary;
      }
      
      public String toString() {
            return String.format("\nName: %s\nID: %d\nDesignation: %s\nSalary: %f\n", name, empID, designation, salary);
      }
}

public class SerializationDeserialization {

      @SuppressWarnings("unchecked")
      public static void main(String[] args) {
            
            LinkedList<Employee> employees;
            
            final String filename = "emp.data";
            
            try {
            FileInputStream file = new FileInputStream(filename);
            ObjectInputStream in = new ObjectInputStream(file);
            employees = (LinkedList<Employee>) in.readObject();
            in.close();
            file.close();
            } catch (Exception e) {
                  employees = new LinkedList<Employee>();
            }
            Scanner sc = new Scanner(System.in);
            
            while(true) {
                  int input;
                  
                  System.out.println("Choose option: ");
                  System.out.println("Enter new Employee -> 1");
                  System.out.println("Display all Employee -> 2");
                  System.out.println("Exit -> 3");
                  
                  input = sc.nextInt();
                  
                  if(input == 1) {
                        employees.add(Employee.readData());
                  } else if(input == 2) {
                        System.out.println(employees);
                  } else {
                        break;
                  }
            }
            
            try {
                    FileOutputStream file = new FileOutputStream(filename);    
                    ObjectOutputStream out = new ObjectOutputStream(file);    
                    out.writeObject(employees);    
                    out.flush();  
                    out.close();
                    file.close();
            } catch (Exception e) {
                  System.out.println(e);
            }
            
            sc.close();
      }

}
