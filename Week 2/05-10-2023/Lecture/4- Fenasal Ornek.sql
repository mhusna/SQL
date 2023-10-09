Declare
    Cursor c_loc is
        Select
            location_id,
            city
        From Locations 
        Order By city;
    
    r_loc c_loc%ROWTYPE;
    
    Cursor c_dep(p_loc_id departments.location_id%TYPE) is
        Select
            department_id,
            department_name,
            location_id
        From Departments
        Where department_id = p_loc_id
        Order By department_name;
    
    r_dep c_dep%ROWTYPE;
    
    Cursor c_emp(p_dep_id employees.department_id%TYPE) is
        Select
            employee_id,
            first_name,
            last_name,
            department_id
        From Employees
        Where department_id = p_dep_id
        Order By employee_id;
    
    r_emp c_emp%ROWTYPE;
Begin
    Open c_loc;
        Loop
            Fetch c_loc INTO r_loc;
            Exit When c_loc%NotFound;
            dbms_output.put_line('Lokasyon: ' || r_loc.City || '(' || r_loc.Location_id || ')');
        
            -- ***********************************
            -- Simdi Department icin cursor acalim
            -- ***********************************
            
            Open c_dep(r_loc.Location_id);      
            Loop
                Fetch c_dep INTO r_dep;
                Exit When c_dep%NotFound;
                dbms_output.put_line('      (' || r_loc.Location_id || ')' ||
                                     ' Department: ' || r_dep.Department_Name ||
                                     '(' || r_dep.Department_id || ')'
                                     );
            
            -- ***********************************
            -- Simdi Employees icin cursor acalim
            -- ***********************************
                
                Open c_emp(r_dep.department_id);
                Loop
                    Fetch c_emp INTO r_emp;
                    Exit When c_emp%NotFound;
                    dbms_output.put_line('          ' ||
                                         'Employee_Name: ' || r_emp.First_name || r_emp.Last_name ||
                                         'Employee_id: ' || r_emp.employee_id ||
                                         '(' || r_emp.department_id || ')'
                                        );
                End Loop;
                Close c_emp;
                dbms_output.put_line(' ');
                dbms_output.new_line;
                
            End Loop;
            Close c_dep;
            
        End Loop;
        Close c_loc;
End;

-- Yukarýdaki ornegi bir - iki degisiklik ile yeniden yapalým

Declare
      Cursor c_loc IS Select Location_id, City From Locations Order By City;
      r_loc  c_loc%ROWTYPE;
            
      Cursor c_dep(p_loc_id Departments.Location_id%type) IS
                  Select Department_id, Department_Name, Location_id
                  From Departments
                  Where Location_id = p_loc_id
                  Order By Department_Name;
      r_dep  c_dep%ROWTYPE;

     Cursor c_emp(p_dep_id Employees.Employee_id%type) IS
                  Select Employee_id, First_Name || ' ' || Last_Name AdiSoyadi, Department_id, Job_id, Hire_Date
                  From Employees
                  Where Department_id = p_dep_id
                  Order By Employee_id;
      r_emp  c_emp%ROWTYPE;-- Bu tur tanýmlamalara
                           -- Record veri tipi veya Referans veri tipi denir
      
/

