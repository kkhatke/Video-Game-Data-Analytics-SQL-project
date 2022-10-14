--1.Write a SQL query to determine the year in which North America had highest video games sales.
SELECT 	games.release_year,
		SUM(sales.na_sales_in_millions) As NA_Sales 
FROM games 
JOIN sales 
ON sales.game_id = games.game_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

--2.Write a SQL query to determine the year in which the global sales was highest.
SELECT 	games.release_year,
		SUM(sales.global_sales_in_millions) As global_Sales 
FROM games 
JOIN sales 
ON sales.game_id = games.game_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

--3.Write a SQL query to determine the year in which the total shipped was highest.
SELECT 	games.release_year,
		SUM(sales.total_shipped_in_millions) As total_shipped 
FROM games 
JOIN sales 
ON sales.game_id = games.game_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

--4.Write a SQL query to determine the most popular video game console in North America.
SELECT console
FROM(	SELECT 	games.console_id,
				SUM (sales.na_sales_in_millions) As Console_sold_in_na
		FROM games
		JOIN sales ON sales.game_id = games.game_id
		GROUP BY 1
		ORDER BY 2 DESC
		LIMIT 1
	 ) t
JOIN console ON console.console_id = t.console_id

--5.Write a SQL query to determine the most popular video game console in PAL.
SELECT console
FROM(	SELECT 	games.console_id,
				SUM (sales.pal_sales_in_millions) As Console_sold_in_pal
		FROM games
		JOIN sales ON sales.game_id = games.game_id
		GROUP BY 1
		ORDER BY 2 DESC
		LIMIT 1
	 ) t
JOIN console ON console.console_id = t.console_id

--6.Write a SQL query to determine the most popular video game console in Japan.
SELECT console
FROM(	SELECT 	games.console_id,
				SUM (sales.japan_sales_in_millions) As Console_sold_in_japan
		FROM games
		JOIN sales ON sales.game_id = games.game_id
		GROUP BY 1
		ORDER BY 2 DESC
		LIMIT 1
	 ) t
JOIN console ON console.console_id = t.console_id

--7.Write a SQL query to determine the most popular video game console in Other regions.
SELECT console
FROM(	SELECT 	games.console_id,
				SUM (sales.other_sales_in_millions) As Console_sold_in_other
		FROM games
		JOIN sales ON sales.game_id = games.game_id
		GROUP BY 1
		ORDER BY 2 DESC
		LIMIT 1
	 ) t
JOIN console ON console.console_id = t.console_id

--8.Write a SQL query to determine the most popular video game console globally.
SELECT console
FROM(	SELECT 	games.console_id,
				SUM (sales.global_sales_in_millions) As Console_sold_in_global
		FROM games
		JOIN sales ON sales.game_id = games.game_id
		GROUP BY 1
		ORDER BY 2 DESC
		LIMIT 1
	 ) t
JOIN console ON console.console_id = t.console_id

--9.Write a SQL query to determine the most shipped video game console.
SELECT console
FROM(	SELECT 	games.console_id,
				SUM (sales.total_shipped_in_millions) As Console_shipped
		FROM games
		JOIN sales ON sales.game_id = games.game_id
		GROUP BY 1
		ORDER BY 2 DESC
		LIMIT 1
	 ) t
JOIN console ON console.console_id = t.console_id

--10.Write a SQL query to determine the most popular video game across various consoles.
SELECT *
FROM(		SELECT 	c.console, t.game_name,
				RANK() OVER (PARTITION BY c.console ORDER BY t.ttl_sales DESC) AS r
		FROM	(SELECT 	g.console_id,
						g.game_name,
						SUM(s.global_sales_in_millions) AS ttl_sales
				FROM	games g
				JOIN	sales s
				ON g.game_id = s.game_id
				GROUP BY 1,2) t
		JOIN console c
		ON c.console_id = t.console_id)t1
WHERE r=1

--11.Write a SQL query to determine the most popular video game across various genres.
SELECT *
FROM(	SELECT 	gn.genre, t.game_name,
				RANK() OVER (PARTITION BY gn.genre ORDER BY t.ttl_sales DESC) AS r
		FROM	(SELECT 	g.genre_id,
						g.game_name,
						SUM(s.global_sales_in_millions) AS ttl_sales
				FROM	games g
				JOIN	sales s
				ON g.game_id = s.game_id
				GROUP BY 1,2) t
		JOIN genre gn
		ON gn.genre_id = t.genre_id)t1
WHERE r=1