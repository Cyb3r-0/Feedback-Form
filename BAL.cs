using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace test
{
    public class BAL
    {
       
        public static void NewFeedBack(Entity obj)
        {
            DAL.NewFeedbackDal(obj);
        }
        private DAL feedbackDAL = new DAL();

        public List<Entity> GetAllFeedbacks(int pageIndex, int pageSize, string searchCustomerName, int? searchRating)
        {
            return feedbackDAL.GetAllFeedbacks(pageIndex, pageSize, searchCustomerName, searchRating);
        }

        public Entity GetFeedbackById(int feedbackID)
        {
            DAL dal = new DAL(); 
            return dal.GetFeedbackById(feedbackID); 
        }
        public void UpdateFeedback(int feedbackID, string customerName, string email, string comment, int rating, DateTime submittedDate)
        {
            DAL dal = new DAL(); 
            dal.UpdateFeedback(feedbackID, customerName, email, comment, rating, submittedDate); 
        }

        public void DeleteFeedback(int feedbackID)
        {
            DAL dal = new DAL(); 
            dal.DeleteFeedbackById(feedbackID); 
        }
    }
}