/*3.a
CREATE VIEW MostLucrativeAuthor AS SELECT a.fname AS 'Author', b.stock_sold AS 'Number sold' FROM authors a JOIN books b ON a.idauthors=b.idauthors ORDER BY stock_sold desc LIMIT 1;*/
SELECT * FROM MostLucrativeAuthor;

/*3.b	designed to a specific author id
CREATE VIEW MostPopular AS SELECT a.fname, g.name, b.title, SUM(b.stock_sold) AS sold FROM genres g JOIN genres_books gb ON g.idgenres=gb.idgenres JOIN books b ON gb.idbooks=b.idbooks JOIN authors a ON a.idauthors=b.idauthors WHERE b.idauthors = 2 GROUP BY g.idgenres ORDER BY sold desc LIMIT 1;*/
SELECT * FROM MostPopular;

/*3.c
CREATE VIEW unfinished AS SELECT a.fname, b.title, b.start_date FROM authors a JOIN books b ON a.idauthors=b.idauthors WHERE b.published = 0 ORDER BY b.start_date;*/
SELECT * FROM unfinished;