-- Downloaded dataset and opened it on Excel
-- Sort A—>Z player_name while expanding the selection
-- Double check if age is in order for players
-- Remove duplicates under player_name column while expanding the selection
-- Now, I have all the players’ data when they first entered the league whether they were drafted or undrafted (aside from the older veterans who were drafted before 1996 since this dataset accounts stats from the 1996 season to the 2020 season)
-- Imported spreadsheet onto SQL

SELECT *
FROM PortfolioProject..nbaplayers_1st

-- I added a new column copying the values from the draft_year column and updating the 'NULL's

ALTER TABLE PortfolioProject..nbaplayers_1st
ADD draftyear varchar(10)

UPDATE PortfolioProject..nbaplayers_1st
SET draftyear = CONVERT(varchar(10), draft_year)

SELECT draftyear, ISNULL(draftyear, 'Undrafted')
FROM PortfolioProject..nbaplayers_1st

UPDATE PortfolioProject..nbaplayers_1st
SET draftyear = ISNULL(draftyear, 'Undrafted')

-- Now going to do the same with draft_round and draft_number

ALTER TABLE PortfolioProject..nbaplayers_1st
ADD draftround varchar(10)

UPDATE PortfolioProject..nbaplayers_1st
SET draftround = CONVERT(varchar(10), draft_round)

SELECT draftround, ISNULL(draftround, 'Undrafted')
FROM PortfolioProject..nbaplayers_1st

UPDATE PortfolioProject..nbaplayers_1st
SET draftround = ISNULL(draftround, 'Undrafted')

ALTER TABLE PortfolioProject..nbaplayers_1st
ADD draftnumber varchar(10)

UPDATE PortfolioProject..nbaplayers_1st
SET draftnumber = CONVERT(varchar(10), draft_number)

SELECT draftnumber, ISNULL(draftnumber, 'Undrafted')
FROM PortfolioProject..nbaplayers_1st

UPDATE PortfolioProject..nbaplayers_1st
SET draftnumber = ISNULL(draftnumber, 'Undrafted')

-- I see that player_height is in cm and that player_weight is in kg, so I'm going to change both of these measurements into feet and pounds respesctively.

SELECT (player_height*0.032808) AS playerheight_ft
FROM PortfolioProject..nbaplayers_1st

ALTER TABLE PortfolioProject..nbaplayers_1st
ADD playerheight_ft float

UPDATE PortfolioProject..nbaplayers_1st
SET playerheight_ft = (player_height*0.032808)

SELECT (player_weight*2.20462262185) AS playerweight_lbs
FROM PortfolioProject..nbaplayers_1st

ALTER TABLE PortfolioProject..nbaplayers_1st
ADD playerweight_lbs float

UPDATE PortfolioProject..nbaplayers_1st
SET playerweight_lbs = (player_weight*2.20462262185)

-- I noticed that some players who were undrafted had a year listed for them under draft_year indicating the year they got undrafted. So, I'll update this in the new columns and account for this when doing my data exploration/analysis

SELECT *, draftyear = 'Undrafted'
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year IS NOT NULL AND draft_round IS NULL AND draft_number IS NULL

UPDATE PortfolioProject..nbaplayers_1st
SET draftyear = 'Undrafted'
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year IS NOT NULL AND draft_round IS NULL AND draft_number IS NULL

-- Checking for repeats

SELECT player_name, college, country, draftyear, COUNT(*)
FROM PortfolioProject..nbaplayers_1st
GROUP BY player_name, college, country, draftyear
HAVING COUNT (*)>1

-- They're all unique names, but sometimes the names can be mistyped, so I'm going to check if there are any same values for draftyear, draftround, and draftnumber because there shouldn't be any duplicates there.

SELECT draft_year, draft_round, draft_number, COUNT(*)
FROM PortfolioProject..nbaplayers_1st
GROUP BY draft_year, draft_round, draft_number
HAVING COUNT (*)>1

SELECT draftyear, draftround, draftnumber, COUNT(*)
FROM PortfolioProject..nbaplayers_1st
GROUP BY draftyear, draftround, draftnumber
HAVING COUNT (*)>1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2006 AND draft_round = 2 AND draft_number = 35

-- P.J. Tucker is listed twice because there weren't periods after PJ in his rookie season. I'm going to remove row 10006 because I'm doing an analysis of players drafted and their first season playing in the NBA.

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE player_name = 'P.J. Tucker'

DELETE
FROM PortfolioProject..nbaplayers_1st
WHERE player_name = 'P.J. Tucker'

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2011 AND draft_round = 1 AND draft_number = 14

-- Marcus Morris is listed twice because he started to don Marcus Morris Sr. later in his career. I'm going to remove row 9948 because I'm doing an analysis of players drafted and their first season playing in the NBA.

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE player_name = 'Marcus Morris Sr.'

DELETE
FROM PortfolioProject..nbaplayers_1st
WHERE player_name = 'Marcus Morris Sr.'

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2014 AND draft_round = 1 AND draft_number = 14

-- T.J. Warren is listed twice because there weren't periods after TJ in his rookie season. I'm going to remove row 9823 because I'm doing an analysis of players drafted and their first season playing in the NBA.

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE player_name = 'T.J. Warren'

DELETE
FROM PortfolioProject..nbaplayers_1st
WHERE player_name = 'T.J. Warren'

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2017 AND draft_round = 1 AND draft_number = 18

-- T.J. Leaf is listed twice because there weren't periods after TJ in his rookie season. I'm going to remove row 10924 because I'm doing an analysis of players drafted and their first season playing in the NBA.

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE player_name = 'T.J. Leaf'

DELETE
FROM PortfolioProject..nbaplayers_1st
WHERE player_name = 'T.J. Leaf'

-- Double checking now

SELECT draft_year, draft_round, draft_number, COUNT(*)
FROM PortfolioProject..nbaplayers_1st
GROUP BY draft_year, draft_round, draft_number
HAVING COUNT (*)>1

SELECT draftyear, draftround, draftnumber, COUNT(*)
FROM PortfolioProject..nbaplayers_1st
GROUP BY draftyear, draftround, draftnumber
HAVING COUNT (*)>1

SELECT player_name, age, COUNT(*)
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year > 1995
GROUP BY player_name, age
HAVING COUNT(*)>1

SELECT DISTINCT draft_year, draft_round, draft_number, draftyear, draftround, draftnumber, COUNT(*)
FROM PortfolioProject..nbaplayers_1st
GROUP BY draft_year, draft_round, draft_number, draftyear, draftround, draftnumber
HAVING COUNT(*)>1

SELECT DISTINCT player_name, COUNT(*)
FROM PortfolioProject..nbaplayers_1st
GROUP BY player_name
HAVING COUNT(*)>1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year > 1995 AND draftyear != 'Undrafted'
ORDER BY draft_round, draft_number

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year > 1995 AND draftyear != 'Undrafted' AND draft_round > 2
ORDER BY draft_round, draft_number

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year > 1995 AND draftyear != 'Undrafted' AND draft_number > 60
ORDER BY draft_round, draft_number

-- I noticed Mark Jones is listed as being drafted in the 4th round which isn't possible. I checked and he actually went undrafted so I"m going to fix this.

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE player_name = 'Mark Jones'

UPDATE PortfolioProject..nbaplayers_1st
SET draftyear = 'Undrafted', draftround = 'Undrafted', draftnumber = 'Undrafted'
FROM PortfolioProject..nbaplayers_1st
WHERE player_name = 'Mark Jones'

-- Now I can begin my data analysis/exploration

-- Averages of players drafted since 1996 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year > 1995 AND draftyear != 'Undrafted'
ORDER BY draft_round, draft_number

SELECT AVG(age) AS avg_age, AVG(playerheight_ft) AS avg_height, AVG(playerweight_lbs) AS avg_weight, AVG(gp) AS gp, AVG(pts) AS avg_pts, AVG(reb) AS avg_reb, AVG(ast) AS avg_ast, AVG(net_rating) AS net_rating, AVG(usg_pct) AS usg_pct, AVG(ts_pct) AS ts_pct, AVG(BMI) AS avg_bmi
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year > 1995 AND draftyear != 'Undrafted'

-- Averages of players drafted in 1996 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1996 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age1996, AVG(playerheight_ft) AS avg_height1996, AVG(playerweight_lbs) AS avg_weight1996, AVG(gp) AS gp1996, AVG(pts) AS avg_pts1996, AVG(reb) AS avg_reb1996, AVG(ast) AS avg_ast1996, AVG(net_rating) AS net_rating1996, AVG(usg_pct) AS usg_pct1996, AVG(ts_pct) AS ts_pct1996
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1996 AND draftyear != 'Undrafted'

-- Averages of players drafted in 1997 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1997 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age1997, AVG(playerheight_ft) AS avg_height1997, AVG(playerweight_lbs) AS avg_weight1997, AVG(gp) AS gp1997, AVG(pts) AS avg_pts1997, AVG(reb) AS avg_reb1997, AVG(ast) AS avg_ast1997, AVG(net_rating) AS net_rating1997, AVG(usg_pct) AS usg_pct1997, AVG(ts_pct) AS ts_pct1997
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1997 AND draftyear != 'Undrafted'

-- Averages of players drafted in 1998 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1998 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age1998, AVG(playerheight_ft) AS avg_height1998, AVG(playerweight_lbs) AS avg_weight1998, AVG(gp) AS gp1998, AVG(pts) AS avg_pts1998, AVG(reb) AS avg_reb1998, AVG(ast) AS avg_ast1998, AVG(net_rating) AS net_rating1998, AVG(usg_pct) AS usg_pct1998, AVG(ts_pct) AS ts_pct1998
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1998 AND draftyear != 'Undrafted'

-- Averages of players drafted in 1999 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1999 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age1999, AVG(playerheight_ft) AS avg_height1999, AVG(playerweight_lbs) AS avg_weight1999, AVG(gp) AS gp1999, AVG(pts) AS avg_pts1999, AVG(reb) AS avg_reb1999, AVG(ast) AS avg_ast1999, AVG(net_rating) AS net_rating1999, AVG(usg_pct) AS usg_pct1999, AVG(ts_pct) AS ts_pct1999
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1999 AND draftyear != 'Undrafted'

-- Averages of players drafted in 2000 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2000 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age2000, AVG(playerheight_ft) AS avg_height2000, AVG(playerweight_lbs) AS avg_weight2000, AVG(gp) AS gp2000, AVG(pts) AS avg_pts2000, AVG(reb) AS avg_reb2000, AVG(ast) AS avg_ast2000, AVG(net_rating) AS net_rating2000, AVG(usg_pct) AS usg_pct2000, AVG(ts_pct) AS ts_pct2000
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2000 AND draftyear != 'Undrafted'

-- Averages of players drafted in 2001 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2001 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age2001, AVG(playerheight_ft) AS avg_height2001, AVG(playerweight_lbs) AS avg_weight2001, AVG(gp) AS gp2001, AVG(pts) AS avg_pts2001, AVG(reb) AS avg_reb2001, AVG(ast) AS avg_ast2001, AVG(net_rating) AS net_rating2001, AVG(usg_pct) AS usg_pct2001, AVG(ts_pct) AS ts_pct2001
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2001 AND draftyear != 'Undrafted'

-- Averages of players drafted in 2002 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2002 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age2002, AVG(playerheight_ft) AS avg_height2002, AVG(playerweight_lbs) AS avg_weight2002, AVG(gp) AS gp2002, AVG(pts) AS avg_pts2002, AVG(reb) AS avg_reb2002, AVG(ast) AS avg_ast2002, AVG(net_rating) AS net_rating2002, AVG(usg_pct) AS usg_pct2002, AVG(ts_pct) AS ts_pct2002
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2002 AND draftyear != 'Undrafted'

-- Averages of players drafted in 2003 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2003 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age2003, AVG(playerheight_ft) AS avg_height2003, AVG(playerweight_lbs) AS avg_weight2003, AVG(gp) AS gp2003, AVG(pts) AS avg_pts2003, AVG(reb) AS avg_reb2003, AVG(ast) AS avg_ast2003, AVG(net_rating) AS net_rating2003, AVG(usg_pct) AS usg_pct2003, AVG(ts_pct) AS ts_pct2003
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2003 AND draftyear != 'Undrafted'

-- Averages of players drafted in 2004 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2004 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age2004, AVG(playerheight_ft) AS avg_height2004, AVG(playerweight_lbs) AS avg_weight2004, AVG(gp) AS gp2004, AVG(pts) AS avg_pts2004, AVG(reb) AS avg_reb2004, AVG(ast) AS avg_ast2004, AVG(net_rating) AS net_rating2004, AVG(usg_pct) AS usg_pct2004, AVG(ts_pct) AS ts_pct2004
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2004 AND draftyear != 'Undrafted'

-- Averages of players drafted in 2005 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2005 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age2005, AVG(playerheight_ft) AS avg_height2005, AVG(playerweight_lbs) AS avg_weight2005, AVG(gp) AS gp2005, AVG(pts) AS avg_pts2005, AVG(reb) AS avg_reb2005, AVG(ast) AS avg_ast2005, AVG(net_rating) AS net_rating2005, AVG(usg_pct) AS usg_pct2005, AVG(ts_pct) AS ts_pct2005
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2005 AND draftyear != 'Undrafted'

-- Averages of players drafted in 2006 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2006 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age2006, AVG(playerheight_ft) AS avg_height2006, AVG(playerweight_lbs) AS avg_weight2006, AVG(gp) AS gp2006, AVG(pts) AS avg_pts2006, AVG(reb) AS avg_reb2006, AVG(ast) AS avg_ast2006, AVG(net_rating) AS net_rating2006, AVG(usg_pct) AS usg_pct2006, AVG(ts_pct) AS ts_pct2006
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2006 AND draftyear != 'Undrafted'

-- Averages of players drafted in 2007 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2007 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age2007, AVG(playerheight_ft) AS avg_height2007, AVG(playerweight_lbs) AS avg_weight2007, AVG(gp) AS gp2007, AVG(pts) AS avg_pts2007, AVG(reb) AS avg_reb2007, AVG(ast) AS avg_ast2007, AVG(net_rating) AS net_rating2007, AVG(usg_pct) AS usg_pct2007, AVG(ts_pct) AS ts_pct2007
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2007 AND draftyear != 'Undrafted'

-- Averages of players drafted in 2008 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2008 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age2008, AVG(playerheight_ft) AS avg_height2008, AVG(playerweight_lbs) AS avg_weight2008, AVG(gp) AS gp2008, AVG(pts) AS avg_pts2008, AVG(reb) AS avg_reb2008, AVG(ast) AS avg_ast2008, AVG(net_rating) AS net_rating2008, AVG(usg_pct) AS usg_pct2008, AVG(ts_pct) AS ts_pct2008
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2008 AND draftyear != 'Undrafted'

-- Averages of players drafted in 2009 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2009 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age2009, AVG(playerheight_ft) AS avg_height2009, AVG(playerweight_lbs) AS avg_weight2009, AVG(gp) AS gp2009, AVG(pts) AS avg_pts2009, AVG(reb) AS avg_reb2009, AVG(ast) AS avg_ast2009, AVG(net_rating) AS net_rating2009, AVG(usg_pct) AS usg_pct2009, AVG(ts_pct) AS ts_pct2009
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2009 AND draftyear != 'Undrafted'

-- Averages of players drafted in 2010 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2010 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age2010, AVG(playerheight_ft) AS avg_height2010, AVG(playerweight_lbs) AS avg_weight2010, AVG(gp) AS gp2010, AVG(pts) AS avg_pts2010, AVG(reb) AS avg_reb2010, AVG(ast) AS avg_ast2010, AVG(net_rating) AS net_rating2010, AVG(usg_pct) AS usg_pct2010, AVG(ts_pct) AS ts_pct2010
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2010 AND draftyear != 'Undrafted'

-- Averages of players drafted in 2011 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2011 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age2011, AVG(playerheight_ft) AS avg_height2011, AVG(playerweight_lbs) AS avg_weight2011, AVG(gp) AS gp2011, AVG(pts) AS avg_pts2011, AVG(reb) AS avg_reb2011, AVG(ast) AS avg_ast2011, AVG(net_rating) AS net_rating2011, AVG(usg_pct) AS usg_pct2011, AVG(ts_pct) AS ts_pct2011
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2011 AND draftyear != 'Undrafted'

-- Averages of players drafted in 2012 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2012 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age2012, AVG(playerheight_ft) AS avg_height2012, AVG(playerweight_lbs) AS avg_weight2012, AVG(gp) AS gp2012, AVG(pts) AS avg_pts2012, AVG(reb) AS avg_reb2012, AVG(ast) AS avg_ast2012, AVG(net_rating) AS net_rating2012, AVG(usg_pct) AS usg_pct2012, AVG(ts_pct) AS ts_pct2012
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2012 AND draftyear != 'Undrafted'

-- Averages of players drafted in 2013 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2013 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age2013, AVG(playerheight_ft) AS avg_height2013, AVG(playerweight_lbs) AS avg_weight2013, AVG(gp) AS gp2013, AVG(pts) AS avg_pts2013, AVG(reb) AS avg_reb2013, AVG(ast) AS avg_ast2013, AVG(net_rating) AS net_rating2013, AVG(usg_pct) AS usg_pct2013, AVG(ts_pct) AS ts_pct2013
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2013 AND draftyear != 'Undrafted'

-- Averages of players drafted in 2014 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2014 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age2014, AVG(playerheight_ft) AS avg_height2014, AVG(playerweight_lbs) AS avg_weight2014, AVG(gp) AS gp2014, AVG(pts) AS avg_pts2014, AVG(reb) AS avg_reb2014, AVG(ast) AS avg_ast2014, AVG(net_rating) AS net_rating2014, AVG(usg_pct) AS usg_pct2014, AVG(ts_pct) AS ts_pct2014
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2014 AND draftyear != 'Undrafted'

-- Averages of players drafted in 2015 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2015 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age2015, AVG(playerheight_ft) AS avg_height2015, AVG(playerweight_lbs) AS avg_weight2015, AVG(gp) AS gp2015, AVG(pts) AS avg_pts2015, AVG(reb) AS avg_reb2015, AVG(ast) AS avg_ast2015, AVG(net_rating) AS net_rating2015, AVG(usg_pct) AS usg_pct2015, AVG(ts_pct) AS ts_pct2015
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2015 AND draftyear != 'Undrafted'

-- Averages of players drafted in 2016 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2016 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age2016, AVG(playerheight_ft) AS avg_height2016, AVG(playerweight_lbs) AS avg_weight2016, AVG(gp) AS gp2016, AVG(pts) AS avg_pts2016, AVG(reb) AS avg_reb2016, AVG(ast) AS avg_ast2016, AVG(net_rating) AS net_rating2016, AVG(usg_pct) AS usg_pct2016, AVG(ts_pct) AS ts_pct2016
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2016 AND draftyear != 'Undrafted'

-- Averages of players drafted in 2016 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2016 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age2016, AVG(playerheight_ft) AS avg_height2016, AVG(playerweight_lbs) AS avg_weight2016, AVG(gp) AS gp2016, AVG(pts) AS avg_pts2016, AVG(reb) AS avg_reb2016, AVG(ast) AS avg_ast2016, AVG(net_rating) AS net_rating2016, AVG(usg_pct) AS usg_pct2016, AVG(ts_pct) AS ts_pct2016
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2016 AND draftyear != 'Undrafted'

-- Averages of players drafted in 2017 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2017 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age2017, AVG(playerheight_ft) AS avg_height2017, AVG(playerweight_lbs) AS avg_weight2017, AVG(gp) AS gp2017, AVG(pts) AS avg_pts2017, AVG(reb) AS avg_reb2017, AVG(ast) AS avg_ast2017, AVG(net_rating) AS net_rating2017, AVG(usg_pct) AS usg_pct2017, AVG(ts_pct) AS ts_pct2017
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2017 AND draftyear != 'Undrafted'

-- Averages of players drafted in 2018 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2018 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age2018, AVG(playerheight_ft) AS avg_height2018, AVG(playerweight_lbs) AS avg_weight2018, AVG(gp) AS gp2018, AVG(pts) AS avg_pts2018, AVG(reb) AS avg_reb2018, AVG(ast) AS avg_ast2018, AVG(net_rating) AS net_rating2018, AVG(usg_pct) AS usg_pct2018, AVG(ts_pct) AS ts_pct2018
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2018 AND draftyear != 'Undrafted'

-- Averages of players drafted in 2019 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2019 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age2019, AVG(playerheight_ft) AS avg_height2019, AVG(playerweight_lbs) AS avg_weight2019, AVG(gp) AS gp2019, AVG(pts) AS avg_pts2019, AVG(reb) AS avg_reb2019, AVG(ast) AS avg_ast2019, AVG(net_rating) AS net_rating2019, AVG(usg_pct) AS usg_pct2019, AVG(ts_pct) AS ts_pct2019
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2019 AND draftyear != 'Undrafted'

-- Averages of players drafted in 2020 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2020 AND draftyear != 'Undrafted'

SELECT AVG(age) AS avg_age2020, AVG(playerheight_ft) AS avg_height2020, AVG(playerweight_lbs) AS avg_weight2020, AVG(gp) AS gp2020, AVG(pts) AS avg_pts2020, AVG(reb) AS avg_reb2020, AVG(ast) AS avg_ast2020, AVG(net_rating) AS net_rating2020, AVG(usg_pct) AS usg_pct2020, AVG(ts_pct) AS ts_pct2020
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2020 AND draftyear != 'Undrafted'

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks since 1996 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year > 1995 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st, AVG(playerheight_ft) AS avg_height_1st, AVG(playerweight_lbs) AS avg_weight_1st, AVG(gp) AS gp_1st, AVG(pts) AS avg_pts_1st, AVG(reb) AS avg_reb_1st, AVG(ast) AS avg_ast_1st, AVG(net_rating) AS net_rating_1st, AVG(usg_pct) AS usg_pct_1st, AVG(ts_pct) AS ts_pct_1st, AVG(BMI) AS BMI_1st
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year > 1995 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year > 1995 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd, AVG(playerheight_ft) AS avg_height_2nd, AVG(playerweight_lbs) AS avg_weight_2nd, AVG(gp) AS gp_2nd, AVG(pts) AS avg_pts_2nd, AVG(reb) AS avg_reb_2nd, AVG(ast) AS avg_ast_2nd, AVG(net_rating) AS net_rating_2nd, AVG(usg_pct) AS usg_pct_2nd, AVG(ts_pct) AS ts_pct_2nd, AVG(BMI) AS BMI_2nd
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year > 1995 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year > 1995 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto, AVG(playerheight_ft) AS avg_height_lotto, AVG(playerweight_lbs) AS avg_weight_lotto, AVG(gp) AS gp_lotto, AVG(pts) AS avg_pts_lotto, AVG(reb) AS avg_reb_lotto, AVG(ast) AS avg_ast_lotto, AVG(net_rating) AS net_rating_lotto, AVG(usg_pct) AS usg_pct_lotto, AVG(ts_pct) AS ts_pct_lotto, AVG(BMI) AS BMI_lotto
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year > 1995 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15


-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 1996 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1996 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st1996, AVG(playerheight_ft) AS avg_height_1st1996, AVG(playerweight_lbs) AS avg_weight_1st1996, AVG(gp) AS gp_1st1996, AVG(pts) AS avg_pts_1st1996, AVG(reb) AS avg_reb_1st1996, AVG(ast) AS avg_ast_1st1996, AVG(net_rating) AS net_rating_1st1996, AVG(usg_pct) AS usg_pct_1st1996, AVG(ts_pct) AS ts_pct_1st1996, AVG(BMI) AS BMI_1st1996
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1996 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1996 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd1996, AVG(playerheight_ft) AS avg_height_2nd1996, AVG(playerweight_lbs) AS avg_weight_2nd1996, AVG(gp) AS gp_2nd1996, AVG(pts) AS avg_pts_2nd1996, AVG(reb) AS avg_reb_2nd1996, AVG(ast) AS avg_ast_2nd1996, AVG(net_rating) AS net_rating_2nd1996, AVG(usg_pct) AS usg_pct_2nd1996, AVG(ts_pct) AS ts_pct_2nd1996, AVG(BMI) AS BMI_2nd1996
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1996 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1996 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto1996, AVG(playerheight_ft) AS avg_height_lotto1996, AVG(playerweight_lbs) AS avg_weight_lotto1996, AVG(gp) AS gp_lotto1996, AVG(pts) AS avg_pts_lotto1996, AVG(reb) AS avg_reb_lotto1996, AVG(ast) AS avg_ast_lotto1996, AVG(net_rating) AS net_rating_lotto1996, AVG(usg_pct) AS usg_pct_lotto1996, AVG(ts_pct) AS ts_pct_lotto1996, AVG(BMI) AS BMI_lotto1996
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1996 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 1997 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1997 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st1997, AVG(playerheight_ft) AS avg_height_1st1997, AVG(playerweight_lbs) AS avg_weight_1st1997, AVG(gp) AS gp_1st1997, AVG(pts) AS avg_pts_1st1997, AVG(reb) AS avg_reb_1st1997, AVG(ast) AS avg_ast_1st1997, AVG(net_rating) AS net_rating_1st1997, AVG(usg_pct) AS usg_pct_1st1997, AVG(ts_pct) AS ts_pct_1st1997, AVG(BMI) AS BMI_1st1997
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1997 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1997 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd1997, AVG(playerheight_ft) AS avg_height_2nd1997, AVG(playerweight_lbs) AS avg_weight_2nd1997, AVG(gp) AS gp_2nd1997, AVG(pts) AS avg_pts_2nd1997, AVG(reb) AS avg_reb_2nd1997, AVG(ast) AS avg_ast_2nd1997, AVG(net_rating) AS net_rating_2nd1997, AVG(usg_pct) AS usg_pct_2nd1997, AVG(ts_pct) AS ts_pct_2nd1997, AVG(BMI) AS BMI_2nd1997
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1997 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1997 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto1997, AVG(playerheight_ft) AS avg_height_lotto1997, AVG(playerweight_lbs) AS avg_weight_lotto1997, AVG(gp) AS gp_lotto1997, AVG(pts) AS avg_pts_lotto1997, AVG(reb) AS avg_reb_lotto1997, AVG(ast) AS avg_ast_lotto1997, AVG(net_rating) AS net_rating_lotto1997, AVG(usg_pct) AS usg_pct_lotto1997, AVG(ts_pct) AS ts_pct_lotto1997, AVG(BMI) AS BMI_lotto1997
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1997 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 1998 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1998 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st1998, AVG(playerheight_ft) AS avg_height_1st1998, AVG(playerweight_lbs) AS avg_weight_1st1998, AVG(gp) AS gp_1st1998, AVG(pts) AS avg_pts_1st1998, AVG(reb) AS avg_reb_1st1998, AVG(ast) AS avg_ast_1st1998, AVG(net_rating) AS net_rating_1st1998, AVG(usg_pct) AS usg_pct_1st1998, AVG(ts_pct) AS ts_pct_1st1998, AVG(BMI) AS BMI_1st1998
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1998 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1998 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd1998, AVG(playerheight_ft) AS avg_height_2nd1998, AVG(playerweight_lbs) AS avg_weight_2nd1998, AVG(gp) AS gp_2nd1998, AVG(pts) AS avg_pts_2nd1998, AVG(reb) AS avg_reb_2nd1998, AVG(ast) AS avg_ast_2nd1998, AVG(net_rating) AS net_rating_2nd1998, AVG(usg_pct) AS usg_pct_2nd1998, AVG(ts_pct) AS ts_pct_2nd1998, AVG(BMI) AS BMI_2nd1998
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1998 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1998 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto1998, AVG(playerheight_ft) AS avg_height_lotto1998, AVG(playerweight_lbs) AS avg_weight_lotto1998, AVG(gp) AS gp_lotto1998, AVG(pts) AS avg_pts_lotto1998, AVG(reb) AS avg_reb_lotto1998, AVG(ast) AS avg_ast_lotto1998, AVG(net_rating) AS net_rating_lotto1998, AVG(usg_pct) AS usg_pct_lotto1998, AVG(ts_pct) AS ts_pct_lotto1998, AVG(BMI) AS BMI_lotto1998
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1998 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15


-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 1999 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1999 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st1999, AVG(playerheight_ft) AS avg_height_1st1999, AVG(playerweight_lbs) AS avg_weight_1st1999, AVG(gp) AS gp_1st1999, AVG(pts) AS avg_pts_1st1999, AVG(reb) AS avg_reb_1st1999, AVG(ast) AS avg_ast_1st1999, AVG(net_rating) AS net_rating_1st1999, AVG(usg_pct) AS usg_pct_1st1999, AVG(ts_pct) AS ts_pct_1st1999, AVG(BMI) AS BMI_1st1999
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1999 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1999 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd1999, AVG(playerheight_ft) AS avg_height_2nd1999, AVG(playerweight_lbs) AS avg_weight_2nd1999, AVG(gp) AS gp_2nd1999, AVG(pts) AS avg_pts_2nd1999, AVG(reb) AS avg_reb_2nd1999, AVG(ast) AS avg_ast_2nd1999, AVG(net_rating) AS net_rating_2nd1999, AVG(usg_pct) AS usg_pct_2nd1999, AVG(ts_pct) AS ts_pct_2nd1999, AVG(BMI) AS BMI_2nd1999
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1999 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1999 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto1999, AVG(playerheight_ft) AS avg_height_lotto1999, AVG(playerweight_lbs) AS avg_weight_lotto1999, AVG(gp) AS gp_lotto1999, AVG(pts) AS avg_pts_lotto1999, AVG(reb) AS avg_reb_lotto1999, AVG(ast) AS avg_ast_lotto1999, AVG(net_rating) AS net_rating_lotto1999, AVG(usg_pct) AS usg_pct_lotto1999, AVG(ts_pct) AS ts_pct_lotto1999, AVG(BMI) AS BMI_lotto1999
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1999 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 2000 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2000 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st2000, AVG(playerheight_ft) AS avg_height_1st2000, AVG(playerweight_lbs) AS avg_weight_1st2000, AVG(gp) AS gp_1st2000, AVG(pts) AS avg_pts_1st2000, AVG(reb) AS avg_reb_1st2000, AVG(ast) AS avg_ast_1st2000, AVG(net_rating) AS net_rating_1st2000, AVG(usg_pct) AS usg_pct_1st2000, AVG(ts_pct) AS ts_pct_1st2000, AVG(BMI) AS BMI_1st2000
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2000 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2000 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd2000, AVG(playerheight_ft) AS avg_height_2nd2000, AVG(playerweight_lbs) AS avg_weight_2nd2000, AVG(gp) AS gp_2nd2000, AVG(pts) AS avg_pts_2nd2000, AVG(reb) AS avg_reb_2nd2000, AVG(ast) AS avg_ast_2nd2000, AVG(net_rating) AS net_rating_2nd2000, AVG(usg_pct) AS usg_pct_2nd2000, AVG(ts_pct) AS ts_pct_2nd2000, AVG(BMI) AS BMI_2nd2000
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2000 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2000 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto2000, AVG(playerheight_ft) AS avg_height_lotto2000, AVG(playerweight_lbs) AS avg_weight_lotto2000, AVG(gp) AS gp_lotto2000, AVG(pts) AS avg_pts_lotto2000, AVG(reb) AS avg_reb_lotto2000, AVG(ast) AS avg_ast_lotto2000, AVG(net_rating) AS net_rating_lotto2000, AVG(usg_pct) AS usg_pct_lotto2000, AVG(ts_pct) AS ts_pct_lotto2000, AVG(BMI) AS BMI_lotto2000
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2000 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 2001 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2001 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st2001, AVG(playerheight_ft) AS avg_height_1st2001, AVG(playerweight_lbs) AS avg_weight_1st2001, AVG(gp) AS gp_1st2001, AVG(pts) AS avg_pts_1st2001, AVG(reb) AS avg_reb_1st2001, AVG(ast) AS avg_ast_1st2001, AVG(net_rating) AS net_rating_1st2001, AVG(usg_pct) AS usg_pct_1st2001, AVG(ts_pct) AS ts_pct_1st2001, AVG(BMI) AS BMI_1st2001
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2001 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2001 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd2001, AVG(playerheight_ft) AS avg_height_2nd2001, AVG(playerweight_lbs) AS avg_weight_2nd2001, AVG(gp) AS gp_2nd2001, AVG(pts) AS avg_pts_2nd2001, AVG(reb) AS avg_reb_2nd2001, AVG(ast) AS avg_ast_2nd2001, AVG(net_rating) AS net_rating_2nd2001, AVG(usg_pct) AS usg_pct_2nd2001, AVG(ts_pct) AS ts_pct_2nd2001, AVG(BMI) AS BMI_2nd2001
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2001 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2001 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto2001, AVG(playerheight_ft) AS avg_height_lotto2001, AVG(playerweight_lbs) AS avg_weight_lotto2001, AVG(gp) AS gp_lotto2001, AVG(pts) AS avg_pts_lotto2001, AVG(reb) AS avg_reb_lotto2001, AVG(ast) AS avg_ast_lotto2001, AVG(net_rating) AS net_rating_lotto2001, AVG(usg_pct) AS usg_pct_lotto2001, AVG(ts_pct) AS ts_pct_lotto2001, AVG(BMI) AS BMI_lotto2001
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2001 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 2002 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2002 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st2002, AVG(playerheight_ft) AS avg_height_1st2002, AVG(playerweight_lbs) AS avg_weight_1st2002, AVG(gp) AS gp_1st2002, AVG(pts) AS avg_pts_1st2002, AVG(reb) AS avg_reb_1st2002, AVG(ast) AS avg_ast_1st2002, AVG(net_rating) AS net_rating_1st2002, AVG(usg_pct) AS usg_pct_1st2002, AVG(ts_pct) AS ts_pct_1st2002, AVG(BMI) AS BMI_1st2002
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2002 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2002 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd2002, AVG(playerheight_ft) AS avg_height_2nd2002, AVG(playerweight_lbs) AS avg_weight_2nd2002, AVG(gp) AS gp_2nd2002, AVG(pts) AS avg_pts_2nd2002, AVG(reb) AS avg_reb_2nd2002, AVG(ast) AS avg_ast_2nd2002, AVG(net_rating) AS net_rating_2nd2002, AVG(usg_pct) AS usg_pct_2nd2002, AVG(ts_pct) AS ts_pct_2nd2002, AVG(BMI) AS BMI_2nd2002
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2002 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2002 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto2002, AVG(playerheight_ft) AS avg_height_lotto2002, AVG(playerweight_lbs) AS avg_weight_lotto2002, AVG(gp) AS gp_lotto2002, AVG(pts) AS avg_pts_lotto2002, AVG(reb) AS avg_reb_lotto2002, AVG(ast) AS avg_ast_lotto2002, AVG(net_rating) AS net_rating_lotto2002, AVG(usg_pct) AS usg_pct_lotto2002, AVG(ts_pct) AS ts_pct_lotto2002, AVG(BMI) AS BMI_lotto2002
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2002 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 2003 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2003 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st2003, AVG(playerheight_ft) AS avg_height_1st2003, AVG(playerweight_lbs) AS avg_weight_1st2003, AVG(gp) AS gp_1st2003, AVG(pts) AS avg_pts_1st2003, AVG(reb) AS avg_reb_1st2003, AVG(ast) AS avg_ast_1st2003, AVG(net_rating) AS net_rating_1st2003, AVG(usg_pct) AS usg_pct_1st2003, AVG(ts_pct) AS ts_pct_1st2003, AVG(BMI) AS BMI_1st2003
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2003 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2003 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd2003, AVG(playerheight_ft) AS avg_height_2nd2003, AVG(playerweight_lbs) AS avg_weight_2nd2003, AVG(gp) AS gp_2nd2003, AVG(pts) AS avg_pts_2nd2003, AVG(reb) AS avg_reb_2nd2003, AVG(ast) AS avg_ast_2nd2003, AVG(net_rating) AS net_rating_2nd2003, AVG(usg_pct) AS usg_pct_2nd2003, AVG(ts_pct) AS ts_pct_2nd2003, AVG(BMI) AS BMI_2nd2003
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2003 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2003 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto2003, AVG(playerheight_ft) AS avg_height_lotto2003, AVG(playerweight_lbs) AS avg_weight_lotto2003, AVG(gp) AS gp_lotto2003, AVG(pts) AS avg_pts_lotto2003, AVG(reb) AS avg_reb_lotto2003, AVG(ast) AS avg_ast_lotto2003, AVG(net_rating) AS net_rating_lotto2003, AVG(usg_pct) AS usg_pct_lotto2003, AVG(ts_pct) AS ts_pct_lotto2003, AVG(BMI) AS BMI_lotto2003
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2003 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 2004 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2004 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st2004, AVG(playerheight_ft) AS avg_height_1st2004, AVG(playerweight_lbs) AS avg_weight_1st2004, AVG(gp) AS gp_1st2004, AVG(pts) AS avg_pts_1st2004, AVG(reb) AS avg_reb_1st2004, AVG(ast) AS avg_ast_1st2004, AVG(net_rating) AS net_rating_1st2004, AVG(usg_pct) AS usg_pct_1st2004, AVG(ts_pct) AS ts_pct_1st2004, AVG(BMI) AS BMI_1st2004
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2004 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2004 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd2004, AVG(playerheight_ft) AS avg_height_2nd2004, AVG(playerweight_lbs) AS avg_weight_2nd2004, AVG(gp) AS gp_2nd2004, AVG(pts) AS avg_pts_2nd2004, AVG(reb) AS avg_reb_2nd2004, AVG(ast) AS avg_ast_2nd2004, AVG(net_rating) AS net_rating_2nd2004, AVG(usg_pct) AS usg_pct_2nd2004, AVG(ts_pct) AS ts_pct_2nd2004, AVG(BMI) AS BMI_2nd2004
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2004 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2004 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto2004, AVG(playerheight_ft) AS avg_height_lotto2004, AVG(playerweight_lbs) AS avg_weight_lotto2004, AVG(gp) AS gp_lotto2004, AVG(pts) AS avg_pts_lotto2004, AVG(reb) AS avg_reb_lotto2004, AVG(ast) AS avg_ast_lotto2004, AVG(net_rating) AS net_rating_lotto2004, AVG(usg_pct) AS usg_pct_lotto2004, AVG(ts_pct) AS ts_pct_lotto2004, AVG(BMI) AS BMI_lotto2004
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2004 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 2005 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2005 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st2005, AVG(playerheight_ft) AS avg_height_1st2005, AVG(playerweight_lbs) AS avg_weight_1st2005, AVG(gp) AS gp_1st2005, AVG(pts) AS avg_pts_1st2005, AVG(reb) AS avg_reb_1st2005, AVG(ast) AS avg_ast_1st2005, AVG(net_rating) AS net_rating_1st2005, AVG(usg_pct) AS usg_pct_1st2005, AVG(ts_pct) AS ts_pct_1st2005, AVG(BMI) AS BMI_1st2005
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2005 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2005 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd2005, AVG(playerheight_ft) AS avg_height_2nd2005, AVG(playerweight_lbs) AS avg_weight_2nd2005, AVG(gp) AS gp_2nd2005, AVG(pts) AS avg_pts_2nd2005, AVG(reb) AS avg_reb_2nd2005, AVG(ast) AS avg_ast_2nd2005, AVG(net_rating) AS net_rating_2nd2005, AVG(usg_pct) AS usg_pct_2nd2005, AVG(ts_pct) AS ts_pct_2nd2005, AVG(BMI) AS BMI_2nd2005
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2005 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2005 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto2005, AVG(playerheight_ft) AS avg_height_lotto2005, AVG(playerweight_lbs) AS avg_weight_lotto2005, AVG(gp) AS gp_lotto2005, AVG(pts) AS avg_pts_lotto2005, AVG(reb) AS avg_reb_lotto2005, AVG(ast) AS avg_ast_lotto2005, AVG(net_rating) AS net_rating_lotto2005, AVG(usg_pct) AS usg_pct_lotto2005, AVG(ts_pct) AS ts_pct_lotto2005, AVG(BMI) AS BMI_lotto2005
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2005 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 2006 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2006 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st2006, AVG(playerheight_ft) AS avg_height_1st2006, AVG(playerweight_lbs) AS avg_weight_1st2006, AVG(gp) AS gp_1st2006, AVG(pts) AS avg_pts_1st2006, AVG(reb) AS avg_reb_1st2006, AVG(ast) AS avg_ast_1st2006, AVG(net_rating) AS net_rating_1st2006, AVG(usg_pct) AS usg_pct_1st2006, AVG(ts_pct) AS ts_pct_1st2006, AVG(BMI) AS BMI_1st2006
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2006 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2006 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd2006, AVG(playerheight_ft) AS avg_height_2nd2006, AVG(playerweight_lbs) AS avg_weight_2nd2006, AVG(gp) AS gp_2nd2006, AVG(pts) AS avg_pts_2nd2006, AVG(reb) AS avg_reb_2nd2006, AVG(ast) AS avg_ast_2nd2006, AVG(net_rating) AS net_rating_2nd2006, AVG(usg_pct) AS usg_pct_2nd2006, AVG(ts_pct) AS ts_pct_2nd2006, AVG(BMI) AS BMI_2nd2006
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2006 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2006 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto2006, AVG(playerheight_ft) AS avg_height_lotto2006, AVG(playerweight_lbs) AS avg_weight_lotto2006, AVG(gp) AS gp_lotto2006, AVG(pts) AS avg_pts_lotto2006, AVG(reb) AS avg_reb_lotto2006, AVG(ast) AS avg_ast_lotto2006, AVG(net_rating) AS net_rating_lotto2006, AVG(usg_pct) AS usg_pct_lotto2006, AVG(ts_pct) AS ts_pct_lotto2006, AVG(BMI) AS BMI_lotto2006
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2006 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 2007 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2007 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st2007, AVG(playerheight_ft) AS avg_height_1st2007, AVG(playerweight_lbs) AS avg_weight_1st2007, AVG(gp) AS gp_1st2007, AVG(pts) AS avg_pts_1st2007, AVG(reb) AS avg_reb_1st2007, AVG(ast) AS avg_ast_1st2007, AVG(net_rating) AS net_rating_1st2007, AVG(usg_pct) AS usg_pct_1st2007, AVG(ts_pct) AS ts_pct_1st2007, AVG(BMI) AS BMI_1st2007
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2007 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2007 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd2007, AVG(playerheight_ft) AS avg_height_2nd2007, AVG(playerweight_lbs) AS avg_weight_2nd2007, AVG(gp) AS gp_2nd2007, AVG(pts) AS avg_pts_2nd2007, AVG(reb) AS avg_reb_2nd2007, AVG(ast) AS avg_ast_2nd2007, AVG(net_rating) AS net_rating_2nd2007, AVG(usg_pct) AS usg_pct_2nd2007, AVG(ts_pct) AS ts_pct_2nd2007, AVG(BMI) AS BMI_2nd2007
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2007 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2007 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto2007, AVG(playerheight_ft) AS avg_height_lotto2007, AVG(playerweight_lbs) AS avg_weight_lotto2007, AVG(gp) AS gp_lotto2007, AVG(pts) AS avg_pts_lotto2007, AVG(reb) AS avg_reb_lotto2007, AVG(ast) AS avg_ast_lotto2007, AVG(net_rating) AS net_rating_lotto2007, AVG(usg_pct) AS usg_pct_lotto2007, AVG(ts_pct) AS ts_pct_lotto2007, AVG(BMI) AS BMI_lotto2007
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2007 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 2008 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2008 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st2008, AVG(playerheight_ft) AS avg_height_1st2008, AVG(playerweight_lbs) AS avg_weight_1st2008, AVG(gp) AS gp_1st2008, AVG(pts) AS avg_pts_1st2008, AVG(reb) AS avg_reb_1st2008, AVG(ast) AS avg_ast_1st2008, AVG(net_rating) AS net_rating_1st2008, AVG(usg_pct) AS usg_pct_1st2008, AVG(ts_pct) AS ts_pct_1st2008, AVG(BMI) AS BMI_1st2008
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2008 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2008 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd2008, AVG(playerheight_ft) AS avg_height_2nd2008, AVG(playerweight_lbs) AS avg_weight_2nd2008, AVG(gp) AS gp_2nd2008, AVG(pts) AS avg_pts_2nd2008, AVG(reb) AS avg_reb_2nd2008, AVG(ast) AS avg_ast_2nd2008, AVG(net_rating) AS net_rating_2nd2008, AVG(usg_pct) AS usg_pct_2nd2008, AVG(ts_pct) AS ts_pct_2nd2008, AVG(BMI) AS BMI_2nd2008
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2008 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2008 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto2008, AVG(playerheight_ft) AS avg_height_lotto2008, AVG(playerweight_lbs) AS avg_weight_lotto2008, AVG(gp) AS gp_lotto2008, AVG(pts) AS avg_pts_lotto2008, AVG(reb) AS avg_reb_lotto2008, AVG(ast) AS avg_ast_lotto2008, AVG(net_rating) AS net_rating_lotto2008, AVG(usg_pct) AS usg_pct_lotto2008, AVG(ts_pct) AS ts_pct_lotto2008, AVG(BMI) AS BMI_lotto2008
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2008 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 2009 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2009 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st2009, AVG(playerheight_ft) AS avg_height_1st2009, AVG(playerweight_lbs) AS avg_weight_1st2009, AVG(gp) AS gp_1st2009, AVG(pts) AS avg_pts_1st2009, AVG(reb) AS avg_reb_1st2009, AVG(ast) AS avg_ast_1st2009, AVG(net_rating) AS net_rating_1st2009, AVG(usg_pct) AS usg_pct_1st2009, AVG(ts_pct) AS ts_pct_1st2009, AVG(BMI) AS BMI_1st2009
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2009 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2009 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd2009, AVG(playerheight_ft) AS avg_height_2nd2009, AVG(playerweight_lbs) AS avg_weight_2nd2009, AVG(gp) AS gp_2nd2009, AVG(pts) AS avg_pts_2nd2009, AVG(reb) AS avg_reb_2nd2009, AVG(ast) AS avg_ast_2nd2009, AVG(net_rating) AS net_rating_2nd2009, AVG(usg_pct) AS usg_pct_2nd2009, AVG(ts_pct) AS ts_pct_2nd2009, AVG(BMI) AS BMI_2nd2009
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2009 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2009 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto2009, AVG(playerheight_ft) AS avg_height_lotto2009, AVG(playerweight_lbs) AS avg_weight_lotto2009, AVG(gp) AS gp_lotto2009, AVG(pts) AS avg_pts_lotto2009, AVG(reb) AS avg_reb_lotto2009, AVG(ast) AS avg_ast_lotto2009, AVG(net_rating) AS net_rating_lotto2009, AVG(usg_pct) AS usg_pct_lotto2009, AVG(ts_pct) AS ts_pct_lotto2009, AVG(BMI) AS BMI_lotto2009
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2009 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 2010 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2010 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st2010, AVG(playerheight_ft) AS avg_height_1st2010, AVG(playerweight_lbs) AS avg_weight_1st2010, AVG(gp) AS gp_1st2010, AVG(pts) AS avg_pts_1st2010, AVG(reb) AS avg_reb_1st2010, AVG(ast) AS avg_ast_1st2010, AVG(net_rating) AS net_rating_1st2010, AVG(usg_pct) AS usg_pct_1st2010, AVG(ts_pct) AS ts_pct_1st2010, AVG(BMI) AS BMI_1st2010
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2010 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2010 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd2010, AVG(playerheight_ft) AS avg_height_2nd2010, AVG(playerweight_lbs) AS avg_weight_2nd2010, AVG(gp) AS gp_2nd2010, AVG(pts) AS avg_pts_2nd2010, AVG(reb) AS avg_reb_2nd2010, AVG(ast) AS avg_ast_2nd2010, AVG(net_rating) AS net_rating_2nd2010, AVG(usg_pct) AS usg_pct_2nd2010, AVG(ts_pct) AS ts_pct_2nd2010, AVG(BMI) AS BMI_2nd2010
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2010 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2010 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto2010, AVG(playerheight_ft) AS avg_height_lotto2010, AVG(playerweight_lbs) AS avg_weight_lotto2010, AVG(gp) AS gp_lotto2010, AVG(pts) AS avg_pts_lotto2010, AVG(reb) AS avg_reb_lotto2010, AVG(ast) AS avg_ast_lotto2010, AVG(net_rating) AS net_rating_lotto2010, AVG(usg_pct) AS usg_pct_lotto2010, AVG(ts_pct) AS ts_pct_lotto2010, AVG(BMI) AS BMI_lotto2010
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2010 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 2011 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2011 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st2011, AVG(playerheight_ft) AS avg_height_1st2011, AVG(playerweight_lbs) AS avg_weight_1st2011, AVG(gp) AS gp_1st2011, AVG(pts) AS avg_pts_1st2011, AVG(reb) AS avg_reb_1st2011, AVG(ast) AS avg_ast_1st2011, AVG(net_rating) AS net_rating_1st2011, AVG(usg_pct) AS usg_pct_1st2011, AVG(ts_pct) AS ts_pct_1st2011, AVG(BMI) AS BMI_1st2011
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2011 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2011 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd2011, AVG(playerheight_ft) AS avg_height_2nd2011, AVG(playerweight_lbs) AS avg_weight_2nd2011, AVG(gp) AS gp_2nd2011, AVG(pts) AS avg_pts_2nd2011, AVG(reb) AS avg_reb_2nd2011, AVG(ast) AS avg_ast_2nd2011, AVG(net_rating) AS net_rating_2nd2011, AVG(usg_pct) AS usg_pct_2nd2011, AVG(ts_pct) AS ts_pct_2nd2011, AVG(BMI) AS BMI_2nd2011
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2011 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2011 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto2011, AVG(playerheight_ft) AS avg_height_lotto2011, AVG(playerweight_lbs) AS avg_weight_lotto2011, AVG(gp) AS gp_lotto2011, AVG(pts) AS avg_pts_lotto2011, AVG(reb) AS avg_reb_lotto2011, AVG(ast) AS avg_ast_lotto2011, AVG(net_rating) AS net_rating_lotto2011, AVG(usg_pct) AS usg_pct_lotto2011, AVG(ts_pct) AS ts_pct_lotto2011, AVG(BMI) AS BMI_lotto2011
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2011 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 2012 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2012 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st2012, AVG(playerheight_ft) AS avg_height_1st2012, AVG(playerweight_lbs) AS avg_weight_1st2012, AVG(gp) AS gp_1st2012, AVG(pts) AS avg_pts_1st2012, AVG(reb) AS avg_reb_1st2012, AVG(ast) AS avg_ast_1st2012, AVG(net_rating) AS net_rating_1st2012, AVG(usg_pct) AS usg_pct_1st2012, AVG(ts_pct) AS ts_pct_1st2012, AVG(BMI) AS BMI_1st2012
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2012 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2012 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd2012, AVG(playerheight_ft) AS avg_height_2nd2012, AVG(playerweight_lbs) AS avg_weight_2nd2012, AVG(gp) AS gp_2nd2012, AVG(pts) AS avg_pts_2nd2012, AVG(reb) AS avg_reb_2nd2012, AVG(ast) AS avg_ast_2nd2012, AVG(net_rating) AS net_rating_2nd2012, AVG(usg_pct) AS usg_pct_2nd2012, AVG(ts_pct) AS ts_pct_2nd2012, AVG(BMI) AS BMI_2nd2012
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2012 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2012 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto2012, AVG(playerheight_ft) AS avg_height_lotto2012, AVG(playerweight_lbs) AS avg_weight_lotto2012, AVG(gp) AS gp_lotto2012, AVG(pts) AS avg_pts_lotto2012, AVG(reb) AS avg_reb_lotto2012, AVG(ast) AS avg_ast_lotto2012, AVG(net_rating) AS net_rating_lotto2012, AVG(usg_pct) AS usg_pct_lotto2012, AVG(ts_pct) AS ts_pct_lotto2012, AVG(BMI) AS BMI_lotto2012
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2012 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 2013 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2013 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st2013, AVG(playerheight_ft) AS avg_height_1st2013, AVG(playerweight_lbs) AS avg_weight_1st2013, AVG(gp) AS gp_1st2013, AVG(pts) AS avg_pts_1st2013, AVG(reb) AS avg_reb_1st2013, AVG(ast) AS avg_ast_1st2013, AVG(net_rating) AS net_rating_1st2013, AVG(usg_pct) AS usg_pct_1st2013, AVG(ts_pct) AS ts_pct_1st2013, AVG(BMI) AS BMI_1st2013
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2013 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2013 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd2013, AVG(playerheight_ft) AS avg_height_2nd2013, AVG(playerweight_lbs) AS avg_weight_2nd2013, AVG(gp) AS gp_2nd2013, AVG(pts) AS avg_pts_2nd2013, AVG(reb) AS avg_reb_2nd2013, AVG(ast) AS avg_ast_2nd2013, AVG(net_rating) AS net_rating_2nd2013, AVG(usg_pct) AS usg_pct_2nd2013, AVG(ts_pct) AS ts_pct_2nd2013, AVG(BMI) AS BMI_2nd2013
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2013 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2013 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto2013, AVG(playerheight_ft) AS avg_height_lotto2013, AVG(playerweight_lbs) AS avg_weight_lotto2013, AVG(gp) AS gp_lotto2013, AVG(pts) AS avg_pts_lotto2013, AVG(reb) AS avg_reb_lotto2013, AVG(ast) AS avg_ast_lotto2013, AVG(net_rating) AS net_rating_lotto2013, AVG(usg_pct) AS usg_pct_lotto2013, AVG(ts_pct) AS ts_pct_lotto2013, AVG(BMI) AS BMI_lotto2013
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2013 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 2014 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2014 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st2014, AVG(playerheight_ft) AS avg_height_1st2014, AVG(playerweight_lbs) AS avg_weight_1st2014, AVG(gp) AS gp_1st2014, AVG(pts) AS avg_pts_1st2014, AVG(reb) AS avg_reb_1st2014, AVG(ast) AS avg_ast_1st2014, AVG(net_rating) AS net_rating_1st2014, AVG(usg_pct) AS usg_pct_1st2014, AVG(ts_pct) AS ts_pct_1st2014, AVG(BMI) AS BMI_1st2014
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2014 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2014 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd2014, AVG(playerheight_ft) AS avg_height_2nd2014, AVG(playerweight_lbs) AS avg_weight_2nd2014, AVG(gp) AS gp_2nd2014, AVG(pts) AS avg_pts_2nd2014, AVG(reb) AS avg_reb_2nd2014, AVG(ast) AS avg_ast_2nd2014, AVG(net_rating) AS net_rating_2nd2014, AVG(usg_pct) AS usg_pct_2nd2014, AVG(ts_pct) AS ts_pct_2nd2014, AVG(BMI) AS BMI_2nd2014
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2014 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2014 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto2014, AVG(playerheight_ft) AS avg_height_lotto2014, AVG(playerweight_lbs) AS avg_weight_lotto2014, AVG(gp) AS gp_lotto2014, AVG(pts) AS avg_pts_lotto2014, AVG(reb) AS avg_reb_lotto2014, AVG(ast) AS avg_ast_lotto2014, AVG(net_rating) AS net_rating_lotto2014, AVG(usg_pct) AS usg_pct_lotto2014, AVG(ts_pct) AS ts_pct_lotto2014, AVG(BMI) AS BMI_lotto2014
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2014 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 2015 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2015 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st2015, AVG(playerheight_ft) AS avg_height_1st2015, AVG(playerweight_lbs) AS avg_weight_1st2015, AVG(gp) AS gp_1st2015, AVG(pts) AS avg_pts_1st2015, AVG(reb) AS avg_reb_1st2015, AVG(ast) AS avg_ast_1st2015, AVG(net_rating) AS net_rating_1st2015, AVG(usg_pct) AS usg_pct_1st2015, AVG(ts_pct) AS ts_pct_1st2015, AVG(BMI) AS BMI_1st2015
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2015 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2015 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd2015, AVG(playerheight_ft) AS avg_height_2nd2015, AVG(playerweight_lbs) AS avg_weight_2nd2015, AVG(gp) AS gp_2nd2015, AVG(pts) AS avg_pts_2nd2015, AVG(reb) AS avg_reb_2nd2015, AVG(ast) AS avg_ast_2nd2015, AVG(net_rating) AS net_rating_2nd2015, AVG(usg_pct) AS usg_pct_2nd2015, AVG(ts_pct) AS ts_pct_2nd2015, AVG(BMI) AS BMI_2nd2015
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2015 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2015 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto2015, AVG(playerheight_ft) AS avg_height_lotto2015, AVG(playerweight_lbs) AS avg_weight_lotto2015, AVG(gp) AS gp_lotto2015, AVG(pts) AS avg_pts_lotto2015, AVG(reb) AS avg_reb_lotto2015, AVG(ast) AS avg_ast_lotto2015, AVG(net_rating) AS net_rating_lotto2015, AVG(usg_pct) AS usg_pct_lotto2015, AVG(ts_pct) AS ts_pct_lotto2015, AVG(BMI) AS BMI_lotto2015
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2015 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 2016 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2016 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st2016, AVG(playerheight_ft) AS avg_height_1st2016, AVG(playerweight_lbs) AS avg_weight_1st2016, AVG(gp) AS gp_1st2016, AVG(pts) AS avg_pts_1st2016, AVG(reb) AS avg_reb_1st2016, AVG(ast) AS avg_ast_1st2016, AVG(net_rating) AS net_rating_1st2016, AVG(usg_pct) AS usg_pct_1st2016, AVG(ts_pct) AS ts_pct_1st2016, AVG(BMI) AS BMI_1st2016
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2016 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2016 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd2016, AVG(playerheight_ft) AS avg_height_2nd2016, AVG(playerweight_lbs) AS avg_weight_2nd2016, AVG(gp) AS gp_2nd2016, AVG(pts) AS avg_pts_2nd2016, AVG(reb) AS avg_reb_2nd2016, AVG(ast) AS avg_ast_2nd2016, AVG(net_rating) AS net_rating_2nd2016, AVG(usg_pct) AS usg_pct_2nd2016, AVG(ts_pct) AS ts_pct_2nd2016, AVG(BMI) AS BMI_2nd2016
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2016 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2016 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto2016, AVG(playerheight_ft) AS avg_height_lotto2016, AVG(playerweight_lbs) AS avg_weight_lotto2016, AVG(gp) AS gp_lotto2016, AVG(pts) AS avg_pts_lotto2016, AVG(reb) AS avg_reb_lotto2016, AVG(ast) AS avg_ast_lotto2016, AVG(net_rating) AS net_rating_lotto2016, AVG(usg_pct) AS usg_pct_lotto2016, AVG(ts_pct) AS ts_pct_lotto2016, AVG(BMI) AS BMI_lotto2016
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2016 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 2017 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2017 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st2017, AVG(playerheight_ft) AS avg_height_1st2017, AVG(playerweight_lbs) AS avg_weight_1st2017, AVG(gp) AS gp_1st2017, AVG(pts) AS avg_pts_1st2017, AVG(reb) AS avg_reb_1st2017, AVG(ast) AS avg_ast_1st2017, AVG(net_rating) AS net_rating_1st2017, AVG(usg_pct) AS usg_pct_1st2017, AVG(ts_pct) AS ts_pct_1st2017, AVG(BMI) AS BMI_1st2017
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2017 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2017 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd2017, AVG(playerheight_ft) AS avg_height_2nd2017, AVG(playerweight_lbs) AS avg_weight_2nd2017, AVG(gp) AS gp_2nd2017, AVG(pts) AS avg_pts_2nd2017, AVG(reb) AS avg_reb_2nd2017, AVG(ast) AS avg_ast_2nd2017, AVG(net_rating) AS net_rating_2nd2017, AVG(usg_pct) AS usg_pct_2nd2017, AVG(ts_pct) AS ts_pct_2nd2017, AVG(BMI) AS BMI_2nd2017
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2017 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2017 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto2017, AVG(playerheight_ft) AS avg_height_lotto2017, AVG(playerweight_lbs) AS avg_weight_lotto2017, AVG(gp) AS gp_lotto2017, AVG(pts) AS avg_pts_lotto2017, AVG(reb) AS avg_reb_lotto2017, AVG(ast) AS avg_ast_lotto2017, AVG(net_rating) AS net_rating_lotto2017, AVG(usg_pct) AS usg_pct_lotto2017, AVG(ts_pct) AS ts_pct_lotto2017, AVG(BMI) AS BMI_lotto2017
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2017 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 2018 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2018 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st2018, AVG(playerheight_ft) AS avg_height_1st2018, AVG(playerweight_lbs) AS avg_weight_1st2018, AVG(gp) AS gp_1st2018, AVG(pts) AS avg_pts_1st2018, AVG(reb) AS avg_reb_1st2018, AVG(ast) AS avg_ast_1st2018, AVG(net_rating) AS net_rating_1st2018, AVG(usg_pct) AS usg_pct_1st2018, AVG(ts_pct) AS ts_pct_1st2018, AVG(BMI) AS BMI_1st2018
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2018 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2018 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd2018, AVG(playerheight_ft) AS avg_height_2nd2018, AVG(playerweight_lbs) AS avg_weight_2nd2018, AVG(gp) AS gp_2nd2018, AVG(pts) AS avg_pts_2nd2018, AVG(reb) AS avg_reb_2nd2018, AVG(ast) AS avg_ast_2nd2018, AVG(net_rating) AS net_rating_2nd2018, AVG(usg_pct) AS usg_pct_2nd2018, AVG(ts_pct) AS ts_pct_2nd2018, AVG(BMI) AS BMI_2nd2018
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2018 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2018 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto2018, AVG(playerheight_ft) AS avg_height_lotto2018, AVG(playerweight_lbs) AS avg_weight_lotto2018, AVG(gp) AS gp_lotto2018, AVG(pts) AS avg_pts_lotto2018, AVG(reb) AS avg_reb_lotto2018, AVG(ast) AS avg_ast_lotto2018, AVG(net_rating) AS net_rating_lotto2018, AVG(usg_pct) AS usg_pct_lotto2018, AVG(ts_pct) AS ts_pct_lotto2018, AVG(BMI) AS BMI_lotto2018
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2018 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 2019 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2019 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st2019, AVG(playerheight_ft) AS avg_height_1st2019, AVG(playerweight_lbs) AS avg_weight_1st2019, AVG(gp) AS gp_1st2019, AVG(pts) AS avg_pts_1st2019, AVG(reb) AS avg_reb_1st2019, AVG(ast) AS avg_ast_1st2019, AVG(net_rating) AS net_rating_1st2019, AVG(usg_pct) AS usg_pct_1st2019, AVG(ts_pct) AS ts_pct_1st2019, AVG(BMI) AS BMI_1st2019
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2019 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2019 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd2019, AVG(playerheight_ft) AS avg_height_2nd2019, AVG(playerweight_lbs) AS avg_weight_2nd2019, AVG(gp) AS gp_2nd2019, AVG(pts) AS avg_pts_2nd2019, AVG(reb) AS avg_reb_2nd2019, AVG(ast) AS avg_ast_2nd2019, AVG(net_rating) AS net_rating_2nd2019, AVG(usg_pct) AS usg_pct_2nd2019, AVG(ts_pct) AS ts_pct_2nd2019, AVG(BMI) AS BMI_2nd2019
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2019 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2019 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto2019, AVG(playerheight_ft) AS avg_height_lotto2019, AVG(playerweight_lbs) AS avg_weight_lotto2019, AVG(gp) AS gp_lotto2019, AVG(pts) AS avg_pts_lotto2019, AVG(reb) AS avg_reb_lotto2019, AVG(ast) AS avg_ast_lotto2019, AVG(net_rating) AS net_rating_lotto2019, AVG(usg_pct) AS usg_pct_lotto2019, AVG(ts_pct) AS ts_pct_lotto2019, AVG(BMI) AS BMI_lotto2019
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2019 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Averages of players drafted in the 1st round, 2nd round, and lottery picks in 2020 and played in a game (Stats are from their first season playing in the NBA)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2020 AND draftyear != 'Undrafted' AND draft_round = 1
ORDER BY draft_number

SELECT AVG(age) AS avg_age_1st2020, AVG(playerheight_ft) AS avg_height_1st2020, AVG(playerweight_lbs) AS avg_weight_1st2020, AVG(gp) AS gp_1st2020, AVG(pts) AS avg_pts_1st2020, AVG(reb) AS avg_reb_1st2020, AVG(ast) AS avg_ast_1st2020, AVG(net_rating) AS net_rating_1st2020, AVG(usg_pct) AS usg_pct_1st2020, AVG(ts_pct) AS ts_pct_1st2020, AVG(BMI) AS BMI_1st2020
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2020 AND draftyear != 'Undrafted' AND draft_round = 1

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2020 AND draftyear != 'Undrafted' AND draft_round = 2
ORDER BY draft_number

SELECT AVG(age) AS avg_age_2nd2020, AVG(playerheight_ft) AS avg_height_2nd2020, AVG(playerweight_lbs) AS avg_weight_2nd2020, AVG(gp) AS gp_2nd2020, AVG(pts) AS avg_pts_2nd2020, AVG(reb) AS avg_reb_2nd2020, AVG(ast) AS avg_ast_2nd2020, AVG(net_rating) AS net_rating_2nd2020, AVG(usg_pct) AS usg_pct_2nd2020, AVG(ts_pct) AS ts_pct_2nd2020, AVG(BMI) AS BMI_2nd2020
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2020 AND draftyear != 'Undrafted' AND draft_round = 2

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2020 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15
ORDER BY draft_number

SELECT AVG(age) AS avg_age_lotto2020, AVG(playerheight_ft) AS avg_height_lotto2020, AVG(playerweight_lbs) AS avg_weight_lotto2020, AVG(gp) AS gp_lotto2020, AVG(pts) AS avg_pts_lotto2020, AVG(reb) AS avg_reb_lotto2020, AVG(ast) AS avg_ast_lotto2020, AVG(net_rating) AS net_rating_lotto2020, AVG(usg_pct) AS usg_pct_lotto2020, AVG(ts_pct) AS ts_pct_lotto2020, AVG(BMI) AS BMI_lotto2020
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2020 AND draftyear != 'Undrafted' AND draft_round = 1 AND draft_number < 15

-- Seeing the different colleges and how many players came from each college

SELECT DISTINCT player_name, college, COUNT(*)
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year > 1995 AND college != 'None' AND draftyear != 'Undrafted'
GROUP BY player_name, college

SELECT DISTINCT college
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year > 1995 AND college != 'None' AND draftyear!= 'Undrafted'

-- I noticed there's a blank spot under Jay Scrubb by accident, so I'm going to insert his college

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year > 1995 AND college = '' AND draftyear!= 'Undrafted'

UPDATE PortfolioProject..nbaplayers_1st
SET college = 'John A. Logan'
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year > 1995 AND college = '' AND draftyear!= 'Undrafted'

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE player_name = 'Jay Scrubb'

-- Different colleges players who played in the NBA were drafted from and the amount since 1996

SELECT college, COUNT(*) AS number_of_players
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year > 1995 AND college != 'None' AND draftyear!= 'Undrafted'
GROUP BY college
ORDER BY number_of_players DESC

-- Different countries players who played in the NBA were drafted from and the amount since 1996

SELECT country, COUNT(*) AS number_of_players
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year > 1995 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players DESC

-- I noticed Bosnia and Bosnia and Herzegovina is listed diffrently due to just listing as Bosnia as well as the use of 'and' and '&' so I'm going to fix it.

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE country LIKE '%Bosnia%'

-- I double checked online to make sure each player was from Bosnia and Herzegovina

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE player_name = 'Jusuf Nurkic'

UPDATE PortfolioProject..nbaplayers_1st
SET country = 'Bosnia and Herzegovina'
FROM PortfolioProject..nbaplayers_1st
WHERE player_name = 'Jusuf Nurkic'

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE player_name = 'Mirza Teletovic'

UPDATE PortfolioProject..nbaplayers_1st
SET country = 'Bosnia and Herzegovina'
FROM PortfolioProject..nbaplayers_1st
WHERE player_name = 'Mirza Teletovic'

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE player_name = 'Ognjen Kuzmic'

UPDATE PortfolioProject..nbaplayers_1st
SET country = 'Bosnia and Herzegovina'
FROM PortfolioProject..nbaplayers_1st
WHERE player_name = 'Ognjen Kuzmic'

-- Different countries players who played in the NBA were drafted from and the amount in 1996

SELECT country, COUNT(*) AS number_of_players1996
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1996 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players1996 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 1997

SELECT country, COUNT(*) AS number_of_players1997
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1997 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players1997 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 1998

SELECT country, COUNT(*) AS number_of_players1998
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1998 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players1998 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 1999

SELECT country, COUNT(*) AS number_of_players1999
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1999 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players1999 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 2000

SELECT country, COUNT(*) AS number_of_players2000
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2000 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players2000 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 2001

SELECT country, COUNT(*) AS number_of_players2001
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2001 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players2001 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 2002

SELECT country, COUNT(*) AS number_of_players2002
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2002 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players2002 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 2003

SELECT country, COUNT(*) AS number_of_players2003
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2003 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players2003 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 2004

SELECT country, COUNT(*) AS number_of_players2004
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2004 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players2004 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 2005

SELECT country, COUNT(*) AS number_of_players2005
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2005 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players2005 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 2006

SELECT country, COUNT(*) AS number_of_players2006
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2006 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players2006 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 2007

SELECT country, COUNT(*) AS number_of_players2007
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2007 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players2007 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 2008

SELECT country, COUNT(*) AS number_of_players2008
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2008 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players2008 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 2009

SELECT country, COUNT(*) AS number_of_players2009
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2009 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players2009 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 2010

SELECT country, COUNT(*) AS number_of_players2010
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2010 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players2010 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 2011

SELECT country, COUNT(*) AS number_of_players2011
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2011 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players2011 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 2012

SELECT country, COUNT(*) AS number_of_players2012
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2012 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players2012 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 2013

SELECT country, COUNT(*) AS number_of_players2013
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2013 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players2013 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 2014

SELECT country, COUNT(*) AS number_of_players2014
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2014 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players2014 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 2015

SELECT country, COUNT(*) AS number_of_players2015
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2015 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players2015 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 2016

SELECT country, COUNT(*) AS number_of_players2016
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2016 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players2016 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 2017

SELECT country, COUNT(*) AS number_of_players2017
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2017 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players2017 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 2018

SELECT country, COUNT(*) AS number_of_players2018
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2018 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players2018 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 2019

SELECT country, COUNT(*) AS number_of_players2019
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2019 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players2019 DESC

-- Different countries players who played in the NBA were drafted from and the amount in 2020

SELECT country, COUNT(*) AS number_of_players2020
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2020 AND draftyear != 'Undrafted'
GROUP BY country
ORDER BY number_of_players2020 DESC

-- I'm going to see BMI and the changes throughout the years. I already have the player's weights in kg, but I need to convert the player's heights to m and square it. I'm going to add a column for height in m and also BMI.

SELECT (player_height*0.01) AS playerheight_m
FROM PortfolioProject..nbaplayers_1st

ALTER TABLE PortfolioProject..nbaplayers_1st
ADD playerheight_m float

UPDATE PortfolioProject..nbaplayers_1st
SET playerheight_m = (player_height*0.01)

SELECT *
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year > 1995 AND draftyear != 'Undrafted'

SELECT (player_weight)/(SQUARE(playerheight_m)) AS BMI
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year > 1995 AND draftyear != 'Undrafted'

SELECT (player_weight)/(SQUARE(playerheight_m)) AS BMI
FROM PortfolioProject..nbaplayers_1st

ALTER TABLE PortfolioProject..nbaplayers_1st
ADD BMI float

UPDATE PortfolioProject..nbaplayers_1st
SET BMI = (player_weight)/(SQUARE(playerheight_m))

SELECT AVG((player_weight)/(SQUARE(playerheight_m))) AS BMI
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year > 1995 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year > 1995 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_1996
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1996 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_1997
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1997 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_1998
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1998 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_1999
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 1999 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_2000
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2000 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_2001
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2001 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_2002
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2002 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_2003
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2003 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_2004
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2004 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_2005
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2005 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_2006
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2006 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_2007
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2007 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_2008
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2008 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_2009
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2009 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_2010
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2010 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_2011
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2011 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_2012
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2012 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_2013
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2013 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_2014
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2014 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_2015
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2015 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_2016
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2016 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_2017
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2017 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_2018
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2018 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_2019
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2019 AND draftyear != 'Undrafted'

SELECT AVG(BMI) AS BMI_2020
FROM PortfolioProject..nbaplayers_1st
WHERE draft_year = 2020 AND draftyear != 'Undrafted'

-- For completeness, I'm going to calculate the BMI for 1st round, 2nd round, and lottery picks. I'm just going to add AVG(BMI) to the above queries and record the data.