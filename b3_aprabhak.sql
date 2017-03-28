CREATE OR REPLACE trigger twomovies     --run @tq.sql to enable the triggers.
BEFORE DELETE OR INSERT OR UPDATE ON Showtimes
FOR EACH ROW

DECLARE
	hall Showtimes.hall%TYPE;
	theaterid Showtimes.theaterid%TYPE;
	starttime Showtimes.starttime%TYPE;
	endtime Showtimes.endtime%TYPE;
	hit NUMBER;

	CURSOR TEMPCURSOR IS
		SELECT theaterid,starttime,endtime,hall
		FROM Showtimes;
BEGIN
	OPEN TEMPCURSOR;
	LOOP
	            FETCH TEMPCURSOR INTO theaterid,starttime,endtime,hall;
				EXIT WHEN TEMPCURSOR%NOTFOUND;
				IF (theaterid =:NEW.theaterid and hall = :NEW.hall and starttime =:NEW.starttime)
				THEN
				raise_application_error(-20000,'no movie at same time and hall');
				END IF;
	END LOOP;
	                CLOSE TEMPCURSOR;
END;
/