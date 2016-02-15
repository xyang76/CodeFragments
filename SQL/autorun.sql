VARIABLE jobno number;
begin
  DBMS_JOB.SUBMIT(:jobno,'Job_Schedule;',Sysdate,'sysdate+1');    
  commit;
end;