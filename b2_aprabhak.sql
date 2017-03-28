--to run both procedures, type @b2_aprabhak in sqlplus.
SET SERVEROUTPUT ON SIZE 32000

DECLARE
	Agegroup USERS.age%TYPE;
	NumberofUsers number;
	AvgBooked number;

	CURSOR TEMPCURSOR IS
		SELECT age,count(userid), (SUM(numberBookedSoFar)/count(userid))
		FROM users
		group by age;
	BEGIN
		        OPEN TEMPCURSOR;
			dbms_output.put_line('Agegroup  NumberOfUsers  AvgBooked');
			dbms_output.put_line('----------------------------------');
			LOOP
                                
				FETCH TEMPCURSOR INTO Agegroup,NumberofUsers, AvgBooked;
				EXIT WHEN TEMPCURSOR%NOTFOUND;
				DBMS_OUTPUT.PUT_LINE(Agegroup ||' '|| Numberofusers || ' '||AvgBooked);

				
			END LOOP;
	                CLOSE TEMPCURSOR;
END;
/

SET SERVEROUTPUT ON SIZE 32000

DECLARE
	Theater Theaters.name%TYPE;
	Movietitle Movies.title%TYPE;
	user Users.userID%TYPE;
	Starttime showtimes.Starttime%TYPE;
	Endtime showtimes.endtime%TYPE;
	hall showtimes.hall%TYPE;
	email Users.email%TYPE;
	age Users.age%TYPE;

	CURSOR TEMPCURSOR IS
         select name
         from showtimes natural join theaters natural join tickets natural join users natural join movies
         order by theaterid;

    CURSOR TEMPCURSOR2 is
    	 select title, starttime,endtime, hall
         from showtimes natural join theaters natural join tickets natural join users natural join movies
         order by theaterid;
    CURSOR TEMPCURSOR3 is
         select userid, email, age
         from showtimes natural join theaters natural join tickets natural join users natural join movies
         order by theaterid;
	BEGIN
		        OPEN TEMPCURSOR;
		        OPEN TEMPCURSOR2;
		        OPEN TEMPCURSOR3;
			dbms_output.put_line('--------');
			dbms_output.put_line('Theater Movietitle Starttime Endtime hall Userid email age');
			LOOP
                                
				FETCH TEMPCURSOR INTO Theater;
				EXIT WHEN TEMPCURSOR%NOTFOUND;
				
				FETCH TEMPCURSOR2 INTO Movietitle,Starttime,Endtime,hall;
				EXIT WHEN TEMPCURSOR2%NOTFOUND;
				
				FETCH TEMPCURSOR3 INTO user,email,age;
				EXIT WHEN TEMPCURSOR3%NOTFOUND;
				
				DBMS_OUTPUT.PUT_LINE(Theater ||' '|| Movietitle ||' '||Starttime || ' '|| Endtime ||' ' || hall ||' '|| user || ' ' || email || ' ' || age);


			END LOOP;
	                CLOSE TEMPCURSOR;
	                CLOSE TEMPCURSOR2;
	                CLOSE TEMPCURSOR3;
END;
/