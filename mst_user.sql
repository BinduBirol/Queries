SET DEFINE OFF;
Insert into JALALABAD.MST_USER
   (USERID, PASSWORD, USERNAME, ROLE, AREA, 
    CREATED_ON, CREATED_BY, STATUS, DEFAULT_URL)
 Values
   ('sales_north', '3307urxj8CpbeitnQSf5+pTkdKdCZAJdZQ+oFY1yH98/L0EJuq+gQBdLz49hbDrm', 'sales_north', 881, '24', 
    TO_DATE('07/30/2017 12:30:51', 'MM/DD/YYYY HH24:MI:SS'), 'admin', 1, 'userDashBoard.action?theme=cupertino');
Insert into JALALABAD.MST_USER
   (USERID, PASSWORD, USERNAME, ROLE, AREA, 
    CREATED_ON, STATUS, DEFAULT_URL)
 Values
   ('admin', 'X12B/C3VmFhBUz5LYOFjabDo6HA1CpXSqe/4WmBWi3tWHHJrZ/coExhNxwCwoZHj', 'IICT', 111, '02', 
    TO_DATE('12/12/2009 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 1, 'userDashBoard.action?theme=cupertino');
Insert into JALALABAD.MST_USER
   (USERID, PASSWORD, USERNAME, ROLE, DESIGNATION, 
    AREA, CREATED_ON, CREATED_BY, STATUS, DEFAULT_URL)
 Values
   ('sales_west', 'QBiVw2Dqwh93TSwdMhqvyaivWES9UhJWEFT49+hSTLNsDbnnTosFxzqkAw9Rl6Mg', 'sales_west', 777, '03', 
    '02', TO_DATE('10/28/2017 13:04:00', 'MM/DD/YYYY HH24:MI:SS'), 'admin', 1, 'userDashBoard.action?theme=cupertino');
Insert into JALALABAD.MST_USER
   (USERID, PASSWORD, USERNAME, ROLE, DESIGNATION, 
    AREA, CREATED_ON, CREATED_BY, STATUS, DEFAULT_URL)
 Values
   ('am_west', 'UvLAT/O9zYjw5wAXkiPx6q2Whh2+TKy66S94DyGkj1Z/gyyELJghpVcHd8VhGBdl', 'Assistant Manager West', 771, '05', 
    '02', TO_DATE('12/27/2017 15:18:15', 'MM/DD/YYYY HH24:MI:SS'), 'admin_north', 1, 'userDashBoard.action?theme=cupertino');
Insert into JALALABAD.MST_USER
   (USERID, PASSWORD, USERNAME, ROLE, DESIGNATION, 
    AREA, CREATED_ON, CREATED_BY, STATUS, DEFAULT_URL)
 Values
   ('am_east', '/xYpVDWTdAEELjztPvS/ErHqjJl2Y+P8VpWhsZjCHBLVmAtRhYENrGEV82KaC94G', 'Assistant Manager East', 771, '05', 
    '01', TO_DATE('12/27/2017 15:20:26', 'MM/DD/YYYY HH24:MI:SS'), 'admin_north', 1, 'userDashBoard.action?theme=cupertino');
Insert into JALALABAD.MST_USER
   (USERID, PASSWORD, USERNAME, ROLE, DESIGNATION, 
    AREA, CREATED_ON, CREATED_BY, STATUS, DEFAULT_URL)
 Values
   ('am_south', 'DCTrHfYkLeh+2gFqx2Pki9r8vnQuABftidm58YzG9QUgfWbomW5tem64igCyjhTM', 'Assistant Manager South', 771, '05', 
    '03', TO_DATE('12/27/2017 15:21:04', 'MM/DD/YYYY HH24:MI:SS'), 'admin_north', 1, 'userDashBoard.action?theme=cupertino');
Insert into JALALABAD.MST_USER
   (USERID, PASSWORD, USERNAME, ROLE, DESIGNATION, 
    AREA, CREATED_ON, CREATED_BY, STATUS, DEFAULT_URL)
 Values
   ('admin_north', 'UYwXonuJURNyL0tr9vmwisqVmjB3tLH1V4Lk8AeUegcpqCADoIX88QqfpQ3KuOdb', 'admin_north', 111, '02', 
    '24', TO_DATE('12/26/2017 18:15:31', 'MM/DD/YYYY HH24:MI:SS'), 'admin', 1, 'userDashBoard.action?theme=cupertino');
Insert into JALALABAD.MST_USER
   (USERID, PASSWORD, USERNAME, ROLE, DESIGNATION, 
    AREA, CREATED_ON, CREATED_BY, STATUS, DEFAULT_URL)
 Values
   ('sales_east', 'xAcHQin3MUxudOo/yRYbxf8NFl/X+lIdeCKYDoIiCAvvm+/oK7RUqbojimwXfFhc', 'sales_east', 881, '05', 
    '01', TO_DATE('02/11/2018 12:25:19', 'MM/DD/YYYY HH24:MI:SS'), 'admin', 1, 'userDashBoard.action?theme=cupertino');
Insert into JALALABAD.MST_USER
   (USERID, PASSWORD, USERNAME, ROLE, DESIGNATION, 
    AREA, CREATED_ON, CREATED_BY, STATUS, DEFAULT_URL)
 Values
   ('am_north', 'amMFlr0P75axkYHz35Gp9123Nd+7PXJxe9F0hn5ds+MUYwub6dYZHTY6YR9OG4dj', 'Assistant Manager North', 771, '05', 
    '24', TO_DATE('12/27/2017 16:31:40', 'MM/DD/YYYY HH24:MI:SS'), 'admin', 1, 'userDashBoard.action?theme=cupertino');
COMMIT;
