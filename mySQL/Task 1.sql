/*1.a		only for a specific date "2019-07-08"
CREATE VIEW room_free AS SELECT room_name as 'free rooms' FROM rooms WHERE room_num != (SELECT room_num FROM `room booking` WHERE start_date = "2019-07-08");*/
SELECT * FROM room_free;

/*1.b		for future reference name the view to the trainers name (Christopher)
CREATE VIEW available_training_Chris AS SELECT courses.course_name, cous.fname FROM courses JOIN courses_consultants cc ON courses.course_id=cc.course_id JOIN consultants cous ON cous.consultant_id=cc.consultant_id JOIN trainers t ON t.trainer_id=courses.trainer_id WHERE t.fname = "Christopher" AND cc.status = 1;*/
SELECT * FROM available_training_chris;

/*1.c
CREATE VIEW course_trainers AS SELECT trainers.fname, courses.course_name FROM courses JOIN trainers ON trainers.trainer_id=courses.trainer_id;*/
SELECT * FROM course_trainers;

/*1.d		only for 1 user
CREATE VIEW completed_courses AS SELECT courses.course_name, cons.fname FROM courses JOIN courses_consultants cc ON courses.course_id=cc.course_id JOIN consultants cons ON cons.consultant_id=cc.consultant_id WHERE cons.fname = "Javier" AND cc.status = 0;*/
SELECT * FROM completed_courses;

/*1.e
CREATE VIEW client_consultant AS SELECT cl.fname AS `client`, con.fname AS `consultant` FROM clients cl JOIN client_booking cb ON cl.client_id=cb.client_id JOIN consultants con ON con.consultant_id=cb.consultant_id ORDER BY cl.fname;*/
SELECT * FROM client_consultant;