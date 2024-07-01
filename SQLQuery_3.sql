SELECT * FROM timesheet.employees;
-- --------->ceo can approve anyone
UPDATE timesheets t
JOIN employee_projects ep ON t.employee_project_id = ep.id
JOIN employees e ON ep.employee_id = e.id
SET t.status = (SELECT id FROM timesheet_status WHERE name = 'approved'),
    t.approved_by = (
        SELECT e_approver.id
        FROM employees e_approver
        WHERE e_approver.can_approve_timesheets = TRUE 
    )
WHERE e.id IN (
    SELECT e_inner.id
    FROM employees e_inner
    JOIN divisions d ON e_inner.division_id = d.id
    WHERE e_inner.division_id = 1 OR d.parent_id = 1
)
AND t.status = (SELECT id FROM timesheet_status WHERE name = 'pending');


-- -------manager can approve employees under him
UPDATE timesheets t
JOIN employee_projects ep ON t.employee_project_id = ep.id
SET t.status = (SELECT id FROM timesheet_status WHERE name = 'approved'),
    t.approved_by = 3
WHERE ep.employee_id IN (
    SELECT e.employee_id
    FROM employee_projects e
    WHERE e.project_id = 1 AND e.can_approve_timesheets = FALSE
) AND t.status = (SELECT id FROM timesheet_status WHERE name = 'pending');


--   director approves manager
UPDATE timesheets t
JOIN employee_projects ep ON t.employee_project_id = ep.id
JOIN employees e ON ep.employee_id = e.id
SET t.status = (SELECT id FROM timesheet_status WHERE name = 'approved'),
    t.approved_by = 7
WHERE ep.project_id = 1
  AND ep.can_approve_timesheets = TRUE
  AND e.reports_to = 7
  AND t.status = (SELECT id FROM timesheet_status WHERE name = 'pending');


select * from employees where can_approve_timesheets=true;

select employee_id from employee_projects where can_approve_timesheets=true and project_id=1 limit 1;


select * from  timesheets t
JOIN employee_projects ep ON t.employee_project_id = ep.id
JOIN employees e ON ep.employee_id = e.id
where e.id in(
        SELECT e_approver.id
        FROM employees e_approver
        WHERE e_approver.can_approve_timesheets = False and parent_id=);

