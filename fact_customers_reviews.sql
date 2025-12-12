-- Query to clean whitespace issues in the ReviewText column

SELECT
    ReviewID,
    CustomerID,
    ProductID,
    ReviewDate,
    Rating,
    Replace(ReviewText,'  ',' ') as ReviewText
FROM
    dbo.customer_reviews;
