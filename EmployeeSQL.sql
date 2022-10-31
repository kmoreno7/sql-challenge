--DROP TABLE IF EXISTS
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;

-- Creating Tables
CREATE TABLE department (
	dept_no VARCHAR(10) NOT NULL,
	dept_name VARCHAR(30) NOT NULL
);


CREATE TABLE dept_emp (
	emp_no INT,
	dept_no VARCHAR(10)NOT NULL 
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(10)NOT NULL,	
	emp_no INT
);

CREATE TABLE employees (
	emp_no INT,
	emp_title_id VARCHAR(10)NOT NULL,	
	birth_date DATE,
	first_name VARCHAR(20)NOT NULL,	
	last_name VARCHAR(20)NOT NULL,	
	sex	VARCHAR(1)NOT NULL,
	hire_date DATE
);

CREATE TABLE salaries (
	emp_no INT,
	salary INT
);

CREATE TABLE titles (
	title_id VARCHAR(10)NOT NULL,
	title VARCHAR(30)NOT NULL
);

SELECT * FROM department;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;

-- List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT 
	employees.emp_no,
	employees.last_name,
	employees.first_name,
	employees.sex,
	salaries.salary
FROM employees
INNER JOIN salaries ON employees.emp_no = salaries.emp_no;

--List first name, last name, and hire date for employees who were hired in 1986.
SELECT
	employees.first_name,
	employees.last_name,
	employees.hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'; 

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT
	dept_manager.dept_no,
	department.dept_name,
	employees.emp_no,
	employees.last_name,
	employees.first_name
FROM ((dept_manager
INNER JOIN department ON dept_manager.dept_no = department.dept_no)
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no);

--List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT
	employees.emp_no,
	employees.last_name,
	employees.first_name,
	department.dept_name
FROM ((employees
INNER JOIN dept_emp ON dept_emp.emp_no = employees.emp_no)
INNER JOIN department ON department.dept_no = dept_emp.dept_no);

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT
	employees.first_name,
	employees.last_name,
	employees.sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT
	employees.emp_no,
	employees.last_name,
	employees.first_name,
	department.dept_name
FROM ((employees
INNER JOIN dept_emp ON dept_emp.emp_no = employees.emp_no)
INNER JOIN department ON department.dept_no = dept_emp.dept_no)
WHERE dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT
	employees.emp_no,
	employees.last_name,
	employees.first_name,
	department.dept_name
FROM ((employees
INNER JOIN dept_emp ON dept_emp.emp_no = employees.emp_no)
INNER JOIN department ON department.dept_no = dept_emp.dept_no)
WHERE dept_name = 'Sales' OR dept_name = 'Development';

--List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.
SELECT COUNT(last_name), last_name
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;