select * 
from employees;

SELECT 
  COUNT(CASE WHEN EMPLOYMENT_STATUS ILIKE 'terminated' THEN 1 END)::FLOAT / COUNT(*) * 100 AS ATTRITION_RATE
FROM SI_HR_DEMO.PUBLIC.EMPLOYEES;

SELECT 
  EMPLOYMENT_STATUS,
  -- Calculate percentage of employees who were promoted
  COUNT(CASE WHEN p.PROMOTED = TRUE THEN 1 END)::FLOAT / COUNT(*) * 100 AS PROMOTION_RATE,
  -- Calculate percentage of employees meeting or exceeding performance expectations
  COUNT(CASE WHEN p.PERFORMANCE_RATING ILIKE '%exceeds%' OR p.PERFORMANCE_RATING ILIKE '%meets%' THEN 1 END)::FLOAT / COUNT(*) * 100 AS MEETS_OR_EXCEEDS_RATE
FROM SI_HR_DEMO.PUBLIC.EMPLOYEES e
-- Join with performance data, keeping all employees even if they don't have performance records
LEFT JOIN SI_HR_DEMO.PUBLIC.EMPLOYEE_PERFORMANCE p 
  ON e.EMPLOYEE_ID = p.EMPLOYEE_ID
-- Group results by employment status to see metrics for active vs terminated employees
GROUP BY EMPLOYMENT_STATUS;