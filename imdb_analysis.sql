-- Can you get all data about movies?

select * from movies;

-- How do you get all data about directors?

select * from directors;

--  Check how many movies are present in IMDB.

SELECT COUNT(*) FROM movies;



-- Find these 3 directors: James Cameron ; Luc Besson ; John Woo

select * from directors where name="james cameron" or  name="luc besson" or  name= "john woo";

select * from directors;

-- Find all directors with name starting with Steven.

select * from directors where name like 'Steven';

-- Count female directors.

SELECT count(*) FROM directors Where gender='0';

-- Find the name of the 10th first women directors?

SELECT name FROM directors Where gender='0' limit 10;



select count(*)as Female_Directors from  directors where gender="0" ;
select *  from  directors where gender="0" limit 10 ;

-- What are the 3 most popular movies?

SELECT * FROM movies order by popularity desc limit 3;

-- What are the 3 most bankable movies?

SELECT * FROM movies order by revenue desc limit 3;

-- What is the most awarded average vote since the January 1st, 2000?
SELECT vote_average FROM movies where release_date > '2000-01-01' ORDER by vote_average DESC limit 1;


-- Which movie(s) were directed by Brenda Chapman?
SELECT m.original_title FROM movies m Join directors d ON m.director_id=d.id where name = 'Brenda Chapman';
    
    -- Whose director made the most movies?
    SELECT name, COUNT(director_id) FROM movies JOIN directors ON directors.id = movies.director_id GROUP BY director_id ORDER BY COUNT(director_id) DESC LIMIT 1;
    
    -- Whose director is the most bankable?
    SELECT name, SUM(revenue) FROM movies JOIN directors ON directors.id  = movies.director_id GROUP BY director_id ORDER BY SUM(revenue) DESC LIMIT 1;    
    
  