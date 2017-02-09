/* What are the first and last names of employees who live in Houston? */
SELECT fname, lname
FROM employee
WHERE address LIKE '%Houston%';

/* What are the SSNs of the top 5 employees who worked the most hours on project number Y?
List them in descending order */
SELECT essn
FROM   works_on
WHERE  pno = 30
ORDER BY hours DESC
LIMIT 5;

/* Example of NULL comparison not working */
SELECT * 
FROM employee 
WHERE superssn = NULL;

/*
Which departments are project X, project Y, and project Z controlled by? 
*/
SELECT DISTINCT dnum
FROM project
WHERE pname IN ('ProductX', 'ProductY', 'ProductZ');