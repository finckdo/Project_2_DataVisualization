
-- Drop table position

-- position table

Select
	ROW_NUMBER() OVER (ORDER BY "position") AS positionid,
	position,
	Case
		When "position"='LS' Then 'Left Striker'
		When "position"='ST' Then 'Striker'
		When "position"='RS' Then 'Right Striker'
		When "position"='LW' Then 'Left Wing'
		When "position"='LF' Then 'Left Forward'
		When "position"='CF' Then 'Center Forward'
		WHen "position"='RF' Then 'Right Forward'
		WHen "position"='RW' Then 'Right Wing'
		When "position"='LAM' Then 'Left Attack Mid'
		When "position"='CAM' Then 'Center Attack Mid'
		WHen "position"='RAM' THen 'Right Attack Mid'
		When "position"='LM' Then 'Left Mid'
		When "position"='LCM' Then 'Left Center Mid'
		When "position"='CM' Then 'Center Mid'
		WHen "position"='RCM' Then 'Right Center Mid'
		WHen "position"='RM' Then 'Right Mid'
		When "position"='LWB' Then 'Left Wing Back'
		When "position"='LDM' Then 'Left Defense Mid'
		When "position"='CDM' Then 'Center Defense Mid'
		WHen "position"='RDM' THen 'Right Defense Mid'
		When "position"='RWB' Then 'Right Wing Back'
		When "position"='LB' Then 'Left Back'
		When "position"='LCB' Then 'Left Center Back'
		When "position"='CB' Then 'Center Back'
		When "position"='RCB' Then 'Right Center Back'
		WHen "position"='RB' Then 'Right Back'
		WHen "position"='GK' Then 'Goal Keeper'
		End as name,
	NULL as type
Into position
From (
		Select Distinct
			"Position" as position
		From staging_fifa_data
	) a;


-- limit 150
	
Update position
Set type='Offense'
Where
	"name" like '%attack%'
	OR
	"name" like '%forward%'
	OR
	"name" like '%striker%'
	OR
	"name" like '%wing%'
	OR
	"name" = 'centermid'
	OR
	"name" = 'leftcentermid'
	OR
	"name" = 'rightcentermid'
	OR
	"name" = 'leftmid'
	OR
	"name" = 'rightmid';
	
	
	
Update position
Set type='Defense'
Where
	"name" like '%back%'
	OR
	"name" like '%defense%'
	OR
	"name" like '%goal%';



-- Select Distinct
-- 	*
-- From position
-- Order By
-- 	1

-- *********************************************************


-- Drop table country

-- country Table
select --Distinct 
	ROW_NUMBER() OVER (ORDER BY "Nationality") AS countryid,
	"Nationality" as name,
	"Flag" as flag
INTO country 
from 
	(
	Select DISTINCT
		"Nationality",
		"Flag"
	From staging_fifa_data
	) a;
	
-- limit 10

-- Select * from country order by 1

-- ****************************************************************

-- Drop table club

-- club Table
select Distinct 
	ROW_NUMBER() OVER (ORDER BY "Club") AS clubid,
	"Club" as name,
	"Club Logo" as logo
INTO club 
from 
	(
	Select DISTINCT
		"Club",
		"Club Logo"
	From staging_fifa_data
	) a;
	
-- limit 10

-- Select * from club order by 1

-- ****************************************************************

-- Drop Table player

-- Player Table
select Distinct 
	--ROW_NUMBER() OVER (ORDER BY "Name") AS id,
	"ID" as playerid,
	cl."clubid",
	co."countryid",
	po."positionid",
	"Name" as name,
	"Age" as age,
	"Preferred Foot" as preferredfoot,
	"Photo" as photo,
	"Value" as value,
	"Wage" as wage,
	"Special" as special,
	"Body Type" as bodytype,
	"Real Face" as realface,
	"Jersey Number" as jersey,
	"Joined" as joineddate,
	"Loaned From" as loanedfrom,
	"Contract Valid Until" as contractenddate,
	"Height" as height,
	"Weight" as weight
INTO player
from staging_fifa_data sfd
	left join club cl on
		sfd."Club"=cl."name"
	left join country co on
		sfd."Nationality"=co."name"
	left join position po on
		sfd."Position"=po."position"
Where
-- 	sfd."Club"='AC Horsens'
-- 	sfd."Nationality"='Afghanistan'
	cl."clubid" is not null and co."countryid" is not null
Order By
	1;
	
-- limit 50

-- Select * from player
-- ****************************************************************

-- Drop table rating

-- rating Table
select Distinct 
	ROW_NUMBER() OVER (ORDER BY "Overall") AS ratingid,
	"ID" as playerid,
	po."positionid",
	"Overall" as overall,
	"Potential" as potential,
	"International Reputation" as internationalreputation,
	"Weak Foot" as weakfoot,
	"Skill Moves" as skillmoves,
	"Work Rate" as workrate,
	"Crossing" as crossing,
	"Finishing" as finishing,
	"HeadingAccuracy" as headingaccuracy,
	"ShortPassing" as shortpassing,
	"Volleys" as volleys,
	"Dribbling" as dribbling,
	"Curve" as curve,
	"FKAccuracy" as fkaccuracy,
	"LongPassing" as longpassing,
	"BallControl" as ballcontrol,
	"Acceleration" as acceleration,
	"SprintSpeed" as sprintspeed,
	"Agility" as agility,
	"Reactions" as reactions,
	"Balance" as balance,
	"ShotPower" as shotpower,
	"Jumping" as jumping,
	"Stamina" as stamina,
	"Strength" as strength,
	"LongShots" as longshots,
	"Aggression" as aggression,
	"Interceptions" as interceptions,
	"Positioning" as positioning,
	"Vision" as vision,
	"Penalties" as penalties,
	"Composure" as composure,
	"Marking" as marking,
	"StandingTackle" as standingtackle,
	"SlidingTackle" as slidingtackle,
	"GKDiving" as gkdiving,
	"GKHandling" as gkhandling,
	"GKKicking" as gkkicking,
	"GKPositioning" as gkpositioning,
	"GKReflexes" as gkreflexes,
	"Release Clause" as releaseclause
INTO rating 
from staging_fifa_data sfd
	left join position po on
		sfd."Position"=po."position"
Order By
	1;
	
-- limit 10

-- Select * from rating

-- *************************************************


