-- =============================================
-- Author:		<Author,,Tarun>
-- Create date: <21/07/2024,,>
-- Description:	<For Feedback Form,,>
-- =============================================
ALTER PROCEDURE [dbo].[UpdateFeedback]
    @FeedbackID INT,
    @CustomerName NVARCHAR(100),
    @Email NVARCHAR(100),
    @Comment NVARCHAR(500),
    @Rating INT,
    @SubmittedDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Feedbacks
    SET CustomerName = @CustomerName,
        Email = @Email,
        Comments = @Comment,
        Rating = @Rating,
        DateSubmitted = @SubmittedDate
    WHERE FeedbackID = @FeedbackID;
END
