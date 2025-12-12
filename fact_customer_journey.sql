-- Common Table Expression (CTE) to identify and tag duplicate records

WITH DuplicateRecords AS (
 SELECT
   JourneyID,
   CustomerID,
   ProductID,
   VisitDate,
   Stage,
   Action,
   Duration,
   ROW_NUMBER() OVER (
          PARTITION BY CustomerID,ProductID,VisitDate,Stage,Action
          ORDER BY JourneyID
   ) as row_num
 FROM
  dbo.customer_journey
)

-- Select all records from the cte where row_num > 1 . which include duplicate entries

SELECT *
FROM DuplicateRecords
-- WHERE row_num > 1
ORDER BY JourneyID;

-- Outer query selects the final cleaned and standardized data
SELECT 
   JourneyID,
   CustomerID,
   ProductID,
   VisitDate,
   Stage,
   Action,
   COALESCE(Duration,avg_duration) as Duration
FROM
 (
 -- subquery to process and clean the data
   SELECT 
    JourneyID,
    CustomerID,
    ProductID,
    VisitDate,
    Stage,
    Action,
    Duration,
    AVG(Duration) OVER (PARTITION BY VisitDate) as avg_duration,
    ROW_NUMBER() OVER (
        PARTITION BY CustomerID,ProductID,VisitDate,UPPER(Stage),Action
        ORDER BY JourneyID
        ) as row_num
    FROM
     dbo.customer_journey
     ) as subquery
    WHERE
     row_num = 1;

    
 




