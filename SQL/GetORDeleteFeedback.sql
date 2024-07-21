-- =============================================
-- Author:		<Author,,Tarun>
-- Create date: <21/07/2024,,>
-- Description:	<For Feedback Form,,>
-- =============================================
ALTER PROCEDURE [dbo].[GetORDeleteFeedback]
    @Action NVARCHAR(20),
    @FeedbackID INT
AS
BEGIN
    SET NOCOUNT ON;

    IF @Action = 'GetFeedbackById'
    BEGIN
        SELECT FeedbackID, CustomerName, Email, Comments, Rating, DateSubmitted
        FROM Feedbacks
        WHERE FeedbackID = @FeedbackID;
    END
    ELSE IF @Action = 'Delete'
    BEGIN
        DELETE FROM Feedbacks
        WHERE FeedbackID = @FeedbackID;
    END
END
