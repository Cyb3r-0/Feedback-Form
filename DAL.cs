using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace test
{

    public class DAL
    {
        public static void NewFeedbackDal(Entity obj)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectinString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("InsertFeedback", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@CustomerName", obj.CustomerName);
                cmd.Parameters.AddWithValue("@Email", obj.Email);
                cmd.Parameters.AddWithValue("@Rating", obj.Rating);
                cmd.Parameters.AddWithValue("@Comment", obj.Comment);
                cmd.Parameters.AddWithValue("@SubmittedDate", obj.SubmittedDate);

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error: " + ex.Message);
                }
            }
        }

        public List<Entity> GetAllFeedbacks(int pageIndex, int pageSize, string searchCustomerName, int? searchRating)
        {
            List<Entity> feedbacks = new List<Entity>();
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectinString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetFeedbacksPagedAndFiltered", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
                cmd.Parameters.AddWithValue("@PageSize", pageSize);

                cmd.Parameters.AddWithValue("@CustomerName", searchCustomerName ?? "");
                cmd.Parameters.AddWithValue("@Rating", searchRating ?? -1);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    Entity feedback = new Entity();
                    feedback.FeedbackID = Convert.ToInt32(reader["FeedbackID"]);
                    feedback.CustomerName = reader["CustomerName"].ToString();
                    feedback.Email = reader["Email"].ToString();
                    feedback.Comment = reader["Comments"].ToString();
                    feedback.Rating = Convert.ToInt32(reader["Rating"]);
                    feedback.SubmittedDate = Convert.ToDateTime(reader["DateSubmitted"]);

                    feedbacks.Add(feedback);
                }

                reader.Close();
            }

            return feedbacks;
        }
        public Entity GetFeedbackById(int feedbackID)
        {
            Entity feedback = new Entity();
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectinString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("GetORDeleteFeedback", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Action", "GetFeedbackById");
                    cmd.Parameters.AddWithValue("@FeedbackID", feedbackID);

                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        feedback.FeedbackID = Convert.ToInt32(reader["FeedbackID"]);
                        feedback.CustomerName = reader["CustomerName"].ToString();
                        feedback.Email = reader["Email"].ToString();
                        feedback.Comment = reader["Comments"].ToString();
                        feedback.Rating = Convert.ToInt32(reader["Rating"]);
                        feedback.SubmittedDate = Convert.ToDateTime(reader["DateSubmitted"]);
                    }

                    reader.Close();
                }
            }

            return feedback;
        }

        public void DeleteFeedbackById(int feedbackID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectinString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("GetORDeleteFeedback", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Action", "Delete");
                    cmd.Parameters.AddWithValue("@FeedbackID", feedbackID);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }


        public void UpdateFeedback(int feedbackID, string customerName, string email, string comment, int rating, DateTime submittedDate)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectinString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("UpdateFeedback", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@FeedbackID", feedbackID);
                    cmd.Parameters.AddWithValue("@CustomerName", customerName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Comment", comment);
                    cmd.Parameters.AddWithValue("@Rating", rating);
                    cmd.Parameters.AddWithValue("@SubmittedDate", submittedDate);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

    }
}
