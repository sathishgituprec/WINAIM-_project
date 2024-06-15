#create database empolyee;
#use empolyee;
#1 execise
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL
);


CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    department_id INT,
    hire_date DATE NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);


CREATE TABLE salaries (
    employee_id INT,
    salary DECIMAL(10, 2) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    PRIMARY KEY (employee_id, from_date),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO departments (department_id, department_name) VALUES
(1, 'Human Resources'),
(2, 'Finance'),
(3, 'Engineering'),
(4, 'Sales');


INSERT INTO employees (employee_id, first_name, last_name, department_id, hire_date) VALUES
(101, 'John', 'Doe', 1, '2020-01-15'),
(102, 'Jane', 'Smith', 2, '2019-03-22'),
(103, 'Emily', 'Jones', 3, '2021-07-01'),
(104, 'Michael', 'Brown', 4, '2018-05-10'),
(105, 'Sarah', 'Davis', 3, '2022-09-13');


INSERT INTO salaries (employee_id, salary, from_date, to_date) VALUES
(101, 60000, '2020-01-15', '2021-01-14'),
(101, 65000, '2021-01-15', '2022-01-14'),
(101, 70000, '2022-01-15', '2023-01-14'),
(102, 70000, '2019-03-22', '2020-03-21'),
(102, 75000, '2020-03-22', '2021-03-21'),
(103, 80000, '2021-07-01', '2022-06-30'),
(103, 85000, '2022-07-01', '2023-06-30'),
(104, 55000, '2018-05-10', '2019-05-09'),
(104, 60000, '2019-05-10', '2020-05-09'),
(105, 90000, '2022-09-13', '2023-09-12');

select * from salaries;





#2SQL Queries
SELECT employee_id, first_name, last_name, department_id, hire_date
FROM employees
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

SELECT d.department_name, SUM(s.salary) AS total_salary_expenditure
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN salaries s ON e.employee_id = s.employee_id
GROUP BY d.department_name;

SELECT e.employee_id, e.first_name, e.last_name, d.department_name, s.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN salaries s ON e.employee_id = s.employee_id
ORDER BY s.salary DESC
LIMIT 5;

#execise2

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);


CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


INSERT INTO customers (customer_id, first_name, last_name, email) VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@example.com'),
(2, 'Bob', 'Smith', 'bob.smith@example.com'),
(3, 'Charlie', 'Brown', 'charlie.brown@example.com');


INSERT INTO orders (order_id, customer_id, order_date) VALUES
(1001, 1, '2023-06-01'),
(1002, 2, '2023-06-05'),
(1003, 3, '2023-06-10');


INSERT INTO products (product_id, product_name, price) VALUES
(101, 'Laptop', 1500.00),
(102, 'Smartphone', 800.00),
(103, 'Tablet', 400.00);


INSERT INTO order_items (order_item_id, order_id, product_id, quantity, price) VALUES
(1, 1001, 101, 1, 1500.00),
(2, 1002, 102, 2, 1600.00),
(3, 1003, 103, 1, 400.00),
(4, 1003, 102, 1, 800.00);

#2

SELECT c.customer_id, c.first_name, c.last_name, COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

SELECT p.product_id, p.product_name
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

SELECT c.customer_id, c.first_name, c.last_name, SUM(oi.price * oi.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_date >= CURDATE() - INTERVAL 1 MONTH
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 1;

#3 execise


CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    enrollment_date DATE NOT NULL
);

CREATE TABLE professors (
    professor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department VARCHAR(100) NOT NULL
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    professor_id INT,
    FOREIGN KEY (professor_id) REFERENCES professors(professor_id)
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO students (first_name, last_name, enrollment_date) VALUES
('John', 'Doe', '2021-08-20'),
('Jane', 'Smith', '2021-09-01'),
('Alice', 'Johnson', '2021-09-15'),
('Bob', 'Brown', '2021-10-01');

INSERT INTO professors (first_name, last_name, department) VALUES
('Dr. Alan', 'Turing', 'Computer Science'),
('Dr. Grace', 'Hopper', 'Computer Science'),
('Dr. Katherine', 'Johnson', 'Mathematics'),
('Dr. Carl', 'Sagan', 'Astronomy');

INSERT INTO courses (course_name, professor_id) VALUES
('Introduction to Computer Science', 1),
('Data Structures and Algorithms', 2),
('Calculus I', 3),
('Astrophysics', 4);

INSERT INTO enrollments (student_id, course_id, grade) VALUES
(1, 1, 'A'),
(1, 2, 'B'),
(2, 1, 'B'),
(2, 3, 'A'),
(3, 3, 'C'),
(3, 4, 'B'),
(4, 2, 'A'),
(4, 4, 'A');


#2
SELECT 
    c.course_name, 
    COUNT(e.student_id) AS total_students
FROM 
    courses c
LEFT JOIN 
    enrollments e ON c.course_id = e.course_id
GROUP BY 
    c.course_name;

SELECT 
    c.course_name
FROM 
    courses c
JOIN 
    professors p ON c.professor_id = p.professor_id
WHERE 
    p.department = 'Computer Science';
    
    CREATE TABLE grade_conversion (
    grade CHAR(2) PRIMARY KEY,
    grade_value INT
);

INSERT INTO grade_conversion (grade, grade_value) VALUES
('A', 4),
('B', 3),
('C', 2),
('D', 1),
('F', 0);

SELECT 
    c.course_name, 
    AVG(gc.grade_value) AS average_grade
FROM 
    enrollments e
JOIN 
    courses c ON e.course_id = c.course_id
JOIN 
    grade_conversion gc ON e.grade = gc.grade
GROUP BY 
    c.course_name;

SELECT 
    s.student_id, 
    s.first_name, 
    s.last_name, 
    COUNT(e.course_id) AS total_courses
FROM 
    students s
JOIN 
    enrollments e ON s.student_id = e.student_id
GROUP BY 
    s.student_id, 
    s.first_name, 
    s.last_name
HAVING 
    COUNT(e.course_id) > 3;







