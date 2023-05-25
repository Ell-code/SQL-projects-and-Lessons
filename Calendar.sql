DECLARE @start_date DATE = '2017-01-01';
DECLARE @end_date DATE = '2024-01-01';

WITH calendar AS
(
	SELECT @start_date AS [date]
	UNION ALL
	SELECT DATEADD(dd, 1, [date])
	FROM calendar
	WHERE DATEADD(dd, 1, [date]) <= @end_date
),
full_calender AS
(
	SELECT 
		[date],
		DATENAME(yyyy, [date]) AS [Year],
		DATENAME(mm, [date]) AS [Month],
		DATEPART(day, [date]) AS dayss,
		DATENAME(DW, [date]) AS [WeekDay],
		DATENAME(DAYOFYEAR, [date]) AS [DayOfYear],
		DATENAME(WEEK, [date]) AS [Week],
		DATEPART(WEEKDAY, [Date]) AS [Weekday2],
		CASE
			WHEN DATENAME(mm, [date]) = 'April' AND DATEPART(day, [date]) = 18
				THEN 'Good Friday'
			WHEN DATENAME(mm, [date]) = 'April' AND DATEPART(day, [date]) = 21
				THEN 'Ester Monday'
			WHEN DATENAME(mm, [date]) = 'December' AND DATEPART(day, [date]) = 26
				THEN 'Boxing Day'
			WHEN DATENAME(mm, [date]) = 'December' AND DATEPART(day, [date]) = 25
				THEN 'Christmas Day'
			WHEN DATENAME(mm, [date]) = 'January' AND DATEPART(day, [date]) = 01
				THEN 'New Year'
			WHEN DATENAME(mm, [date]) = 'October' AND DATEPART(day, [date]) = 01
				THEN 'Nigeria Independence Day'
			WHEN DATENAME(mm, [date]) = 'June' AND DATEPART(day, [date]) = 12
				THEN 'Nigeria Democracy Day'
			WHEN DATENAME(mm, [date]) = 'February' AND DATEPART(day, [date]) = 014
				THEN 'Val Day'
			WHEN DATENAME(mm, [date]) = 'May' AND DATEPART(WEEK, [date]) = 2 AND DATEPART(WEEKDAY, [Date]) = 1
				THEN 'Mothers Day'
			ELSE NULL
			END AS Holiday
	FROM calendar
)

SELECT *
FROM full_calender
OPTION (MAXRECURSION 9000);
