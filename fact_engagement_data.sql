-- Query to clean and normalize the engagement_data table

SELECT
   EngagementID,
   ContentID,
   CampaignID,
   ProductID,
   UPPER(REPLACE(ContentType,'Socialmedia','Social Media')) as ContentType,
   LEFT(ViewsClicksCombined,CHARINDEX('-',ViewsClicksCombined) -1) as Views,
   RIGHT(ViewsClicksCombined, LEN(ViewsClicksCombined) - CHARINDEX('-',ViewsClicksCombined) -1) as Clicks,
   Likes,
   FORMAT(CONVERT(DATE,EngagementDate),'dd.MM.yyyy') as EngagementDate
FROM
   dbo.engagement_data
WHERE
   ContentType != 'Newsletter';

