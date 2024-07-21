-- =============================================
-- Author:		<Author,,Tarun>
-- Create date: <21/07/2024,,>
-- Description:	<For Feedback Form,,>
-- =============================================
ALTER PROCEDURE [dbo].[GetFeedbacksPagedAndFiltered]
    @PageIndex INT,
    @PageSize INT,
    @CustomerName NVARCHAR(100) = '',
    @Rating INT = -1
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartRow INT, @EndRow INT;
    SET @StartRow = (@PageIndex - 1) * @PageSize + 1;
    SET @EndRow = @PageIndex * @PageSize;

    WITH OrderedFeedbacks AS (
        SELECT 
            FeedbackID,
            CustomerName,
            Email,
            Comments,
            Rating,
            DateSubmitted,
            ROW_NUMBER() OVER (ORDER BY FeedbackID) AS RowNum
        FROM 
            Feedbacks
        WHERE
            (@CustomerName = '' OR CustomerName LIKE '%' + @CustomerName + '%')
            AND (@Rating = -1 OR Rating = @Rating)
    )
    SELECT
        FeedbackID,
        CustomerName,
        Email,
        Comments,
        Rating,
        DateSubmitted
    FROM
        OrderedFeedbacks
    WHERE
        RowNum BETWEEN @StartRow AND @EndRow;
END
