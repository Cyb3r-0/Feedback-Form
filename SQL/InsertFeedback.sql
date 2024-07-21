-- =============================================
-- Author:		<Author,,Tarun>
-- Create date: <21/07/2024,,>
-- Description:	<For Feedback Form,,>
-- =============================================
ALTER PROCEDURE [dbo].[InsertFeedback] 
	@CustomerName nvarchar(100),
	@Email nvarchar(100),
	@Comment nvarchar(500),
	@Rating int,
	@SubmittedDate DateTime
AS
BEGIN
	SET NOCOUNT ON;

    Insert into Feedbacks(CustomerName,Email,Comments,Rating,DateSubmitted)
	Values(@CustomerName,@Email,@comment,@Rating,@SubmittedDate);
END
