// File: Payable.java
package xyzsportsclub;

public interface Payable {
    double calculateSalary();
}

// File: Person.java
package xyzsportsclub;

public class Person {
    protected int id;
    protected String name;
    protected String mobile;
    protected String email;

    public Person(String name, String mobile, String email) {
        this.id = IDGenerator.generateId();
        this.name = name;
        this.mobile = mobile;
        this.email = email;
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public String getMobile() { return mobile; }
    public String getEmail() { return email; }
}

// File: Employee.java
package xyzsportsclub;

public abstract class Employee extends Person implements Payable {
    protected String department;
    protected String designation;
    protected String doj;

    public Employee(String name, String mobile, String email, String department, String designation, String doj) {
        super(name, mobile, email);
        this.department = department;
        this.designation = designation;
        this.doj = doj;
    }
}

// File: SalariedEmployee.java
package xyzsportsclub;

public class SalariedEmployee extends Employee {
    private double basic;

    public SalariedEmployee(String name, String mobile, String email, String department, String designation, String doj, double basic) {
        super(name, mobile, email, department, designation, doj);
        this.basic = basic;
    }

    @Override
    public double calculateSalary() {
        double da = 0.10 * basic;
        double hra = 0.15 * basic;
        double pf = 0.12 * basic;
        return basic + da + hra - pf;
    }
}

// File: ContractEmployee.java
package xyzsportsclub;

public class ContractEmployee extends Employee {
    private int hoursWorked;
    private double hourlyRate;

    public ContractEmployee(String name, String mobile, String email, String department, String designation, String doj, int hoursWorked, double hourlyRate) {
        super(name, mobile, email, department, designation, doj);
        this.hoursWorked = hoursWorked;
        this.hourlyRate = hourlyRate;
    }

    @Override
    public double calculateSalary() {
        return hoursWorked * hourlyRate;
    }
}

// File: Vendor.java
package xyzsportsclub;

public class Vendor extends Employee {
    private int noOfEmployees;
    private double amount;

    public Vendor(String name, String mobile, String email, String department, String designation, String doj, int noOfEmployees, double amount) {
        super(name, mobile, email, department, designation, doj);
        this.noOfEmployees = noOfEmployees;
        this.amount = amount;
    }

    @Override
    public double calculateSalary() {
        return amount + (amount * 0.18);
    }
}

// File: Member.java
package xyzsportsclub;

public class Member extends Person {
    private String membershipType;
    private double amountPaid;

    public Member(String name, String mobile, String email, String membershipType, double amountPaid) {
        super(name, mobile, email);
        this.membershipType = membershipType;
        this.amountPaid = amountPaid;
    }
}

// File: IDGenerator.java
package xyzsportsclub;

public class IDGenerator {
    private static int idCounter = 1;

    public static int generateId() {
        return idCounter++;
    }
}

// File: Main.java
package xyzsportsclub;

import java.util.*;

public class Main {
    static Scanner sc = new Scanner(System.in);
    static List<Employee> employees = new ArrayList<>();

    public static void main(String[] args) {
        loadSampleData();
        boolean running = true;
        while (running) {
            System.out.println("\n--- XYZ Sports Club Menu ---");
            System.out.println("1. Display employees by type");
            System.out.println("2. Search employee by ID");
            System.out.println("3. Search employee by name");
            System.out.println("4. Display all employees");
            System.out.println("5. Display salary for designation");
            System.out.println("6. Display 5 employees from a department");
            System.out.println("7. Exit");
            System.out.print("Choose an option: ");

            int choice = sc.nextInt();
            sc.nextLine();

            switch (choice) {
                case 1: displayByType(); break;
                case 2: searchById(); break;
                case 3: searchByName(); break;
                case 4: displayAll(); break;
                case 5: salaryByDesignation(); break;
                case 6: displayByDepartment(); break;
                case 7: running = false; break;
                default: System.out.println("Invalid option.");
            }
        }
    }

    static void loadSampleData() {
        employees.add(new SalariedEmployee("Alice", "9999999999", "alice@mail.com", "HR", "Manager", "2022-01-15", 30000));
        employees.add(new ContractEmployee("Bob", "8888888888", "bob@mail.com", "Tech", "Developer", "2023-03-12", 160, 250));
        employees.add(new Vendor("Charlie", "7777777777", "charlie@mail.com", "Supply", "Vendor", "2021-08-20", 10, 50000));
    }

    static void displayByType() {
        System.out.print("Enter type (salaried/contract/vendor): ");
        String type = sc.nextLine().toLowerCase();
        for (Employee e : employees) {
            if ((type.equals("salaried") && e instanceof SalariedEmployee) ||
                (type.equals("contract") && e instanceof ContractEmployee) ||
                (type.equals("vendor") && e instanceof Vendor)) {
                System.out.println(e.name + " | " + e.getClass().getSimpleName());
            }
        }
    }

    static void searchById() {
        System.out.print("Enter ID: ");
        int id = sc.nextInt();
        for (Employee e : employees) {
            if (e.getId() == id) {
                System.out.println("Found: " + e.name);
                return;
            }
        }
        System.out.println("Employee not found.");
    }

    static void searchByName() {
        System.out.print("Enter name: ");
        String name = sc.nextLine();
        for (Employee e : employees) {
            if (e.getName().equalsIgnoreCase(name)) {
                System.out.println("Found: " + e.name);
                return;
            }
        }
        System.out.println("Employee not found.");
    }

    static void displayAll() {
        for (Employee e : employees) {
            System.out.println(e.name + " | " + e.getClass().getSimpleName());
        }
    }

    static void salaryByDesignation() {
        System.out.print("Enter designation: ");
        String des = sc.nextLine();
        for (Employee e : employees) {
            if (e.designation.equalsIgnoreCase(des)) {
                System.out.println(e.name + " | Salary: " + e.calculateSalary());
            }
        }
    }

    static void displayByDepartment() {
        System.out.print("Enter department: ");
        String dep = sc.nextLine();
        int count = 0;
        for (Employee e : employees) {
            if (e.department.equalsIgnoreCase(dep)) {
                System.out.println(e.name);
                count++;
                if (count == 5) break;
            }
        }
    }
}
