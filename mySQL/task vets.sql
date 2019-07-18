/*2.a
CREATE VIEW not_neutered AS SELECT name FROM animals WHERE idanimals NOT IN (SELECT idanimals FROM vet_booking) AND neutered = 0 AND exit_date IS NULL;*/
SELECT * FROM not_neutered;

/*2.b
CREATE VIEW longest_stay AS SELECT name, entry_date FROM animals WHERE exit_date IS NULL ORDER BY entry_date;*/
SELECT * FROM longest_stay;

/*2.c		Only works for penguins
CREATE VIEW smile_and_wave AS SELECT name, anim_type AS species FROM animals WHERE exit_date IS NULL AND anim_type = 'Penguin';*/
SELECT * FROM smile_and_wave;