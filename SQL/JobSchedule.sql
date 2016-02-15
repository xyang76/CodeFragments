create or replace procedure Job_Schedule 
is 
  v_tid INTEGER;
  v_sid INTEGER;
  v_email VARCHAR(20);
  v_tomorrow TIMESTAMP;
  secNum INTEGER;
  title VARCHAR(50);
  message VARCHAR(500);
  c_theatre sys_refcursor;
  c_Staff sys_refcursor;
begin 
  --SET THE DAY IS TOMORROW
  SELECT sysdate + 1 next_day INTO v_tomorrow FROM DUAL;

  open c_theatre for SELECT ID FROM THEATRE;
  loop
  fetch c_theatre into v_tid;
  exit when c_theatre%notfound;
      --FIND THEATRE IF NO security
      SELECT count(*) INTO secNum 
      FROM STAFFSCHEDULE 
      WHERE JOBTYPE = 'Security' AND THEATREID=v_tid 
          AND TO_CHAR(TIME, 'YYYY-MM-DD')=TO_CHAR(v_tomorrow, 'YYYY-MM-DD');
          
--      dbms_output.put_line(' theatre:' || theatreId);
      IF(secNum = 0) THEN
        --DO ALERT(Find out all owner or manager in this theatre)
        OPEN c_Staff FOR
          SELECT staffmemberid FROM STAFFROLE WHERE THEATREID = v_tid and ROLE='Manager' OR ROLE='Owner';
        LOOP
          fetch c_Staff into v_sid;
          exit when c_Staff%notfound;
          
              dbms_output.put_line(' theatre:' || v_tid || 'staffId' || v_sid);
              SELECT email INTO v_email FROM staffmember WHERE ID=v_sid; 
              title := 'Security alert';
              message := 'No security is scheduled to work tomorrow';
              --SEND AN ALERT BY EMAIL
              IF v_email IS NOT NULL THEN
                SEND_MAIL(v_email, title, message);
              END IF;
              --ADD TO TABLE
              INSERT INTO ALERT VALUES(S_Alert.nextval, v_sid, 'Staffmember', title, message);
        END LOOP;
      END IF;
  end loop;
  close c_theatre;
end;