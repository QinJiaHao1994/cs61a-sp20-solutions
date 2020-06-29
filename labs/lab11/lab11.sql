.read sp20data.sql

CREATE TABLE obedience AS
  SELECT seven AS obedience, instructor FROM students;

CREATE TABLE smallest_int AS
  SELECT time, smallest FROM students WHERE smallest > 2 ORDER BY smallest LIMIT 20;

CREATE TABLE matchmaker AS
  SELECT a.pet AS pet, a.song as song, a.color AS color1, b.color AS color2  FROM students as a, students as b WHERE a.pet == b.pet AND a.song == b.song AND a.time < b.time;

CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;

-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE stacks_helper(dogs, stack_height, last_height);

-- Add your INSERT INTOs here
INSERT INTO stacks_helper SELECT name, height, height FROM dogs;
INSERT INTO stacks_helper(dogs, stack_height, last_height) SELECT a.dogs || ", " || b.dogs as dogs, a.stack_height + b.last_height as stack_height, b.last_height as last_height FROM stacks_helper AS a, stacks_helper AS b WHERE a.last_height < b.last_height;
INSERT INTO stacks_helper(dogs, stack_height, last_height) SELECT a.dogs || ", " || b.dogs as dogs, a.stack_height + b.last_height as stack_height, b.last_height as last_height FROM stacks_helper AS a, stacks_helper AS b WHERE a.last_height < b.last_height AND a.stack_height > a.last_height AND b.stack_height == b.last_height;
INSERT INTO stacks_helper(dogs, stack_height, last_height) SELECT a.dogs || ", " || b.dogs as dogs, a.stack_height + b.last_height as stack_height, b.last_height as last_height FROM stacks_helper AS a, stacks_helper AS b WHERE a.last_height < b.last_height AND a.stack_height > a.last_height AND b.stack_height == b.last_height;

CREATE TABLE stacks AS
  SELECT dogs, stack_height from stacks_helper WHERE stack_height > 170 ORDER BY stack_height;

CREATE TABLE smallest_int_having AS
  SELECT time, smallest FROM students GROUP BY smallest HAVING COUNT(smallest) == 1 and MIN(smallest);

CREATE TABLE sp20favpets AS
  SELECT pet, COUNT(*) AS count FROM students GROUP BY pet  ORDER BY count DESC LIMIT 10;

CREATE TABLE sp20dog AS
  SELECT pet, count FROM sp20favpets WHERE pet == "dog";


CREATE TABLE obedienceimages AS
  SELECT seven, instructor, count(*) AS count FROM students WHERE seven == "7" GROUP BY instructor;