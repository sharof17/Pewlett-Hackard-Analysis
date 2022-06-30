-- Retrive the info about employees who are about to retire
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, last_name DESC;

-- Retrieve number of titles who are likely to retire
SELECT COUNT(title) AS count_title, title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count_title DESC;

-- Get employees who are eligible to participate in a mentorship program
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
e.first_name, 
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
INTO mentorship_eligibilty
FROM employees AS e
INNER JOIN dept_emp AS de
ON e.emp_no = de.emp_no
INNER JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE (t.to_date = '9999-01-01') 
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;
-- emp_no # 10291 and # 12155 are different from the image in the task
-- current titles are found

--- Additional Tables ---
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, t.title, d.dept_name, de.from_date, de.to_date
INTO useful
FROM employees AS e
INNER JOIN titles AS t
ON e.emp_no = t.emp_no
INNER JOIN dept_emp AS de
ON e.emp_no = de.emp_no
INNER JOIN departments AS d 
ON de.dept_no = d.dept_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (de.to_date = '9999-01-01')
GROUP BY e.emp_no, e.first_name, e.last_name, t.title, d.dept_name, de.from_date, de.to_date
ORDER BY e.emp_no;

SELECT dept_name, COUNT(dept_name) AS "count"
INTO retiring_departments
FROM useful
GROUP BY dept_name
ORDER BY count DESC;

SELECT * FROM retiring_title_department
 
SELECT dept_name, title, COUNT(title) AS "count" 
INTO retiring_title_department
FROM useful
GROUP BY dept_name, title
ORDER BY dept_name