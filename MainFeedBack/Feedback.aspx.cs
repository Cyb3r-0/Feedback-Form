using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace test.MainFeedBack
{
    public partial class Feedback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindFeedbackData(1);
            }
        }

        protected void btnSubmitted_Click(object sender, EventArgs e)
        {
            if(Page.IsValid){ 
            Entity obj = new Entity();
            obj.CustomerName = txtCustomerName.Text;
            obj.Email = txtEmail.Text;
            obj.Comment = txtComment.Text;
            obj.Rating = Convert.ToInt32(txtRating.Text);
            obj.SubmittedDate = Convert.ToDateTime(txtSubmittedDate.Text);
            BAL.NewFeedBack(obj);
            ClearFormFields();
            BindFeedbackData(1);
            }
            
            
        }

        public void BindFeedbackData(int pageIndex)
        {
            int pageSize = 10; 
            string searchCustomerName = txtSearchCustomerName.Text.Trim();
            int? searchRating = null;
            if (!string.IsNullOrEmpty(ddlSearchRating.SelectedValue))
            {
                searchRating = Convert.ToInt32(ddlSearchRating.SelectedValue);
            }

            BAL objbal = new BAL();
            List<Entity> feedbacks = objbal.GetAllFeedbacks(pageIndex, pageSize, searchCustomerName, searchRating);
            rptFeedback.DataSource = feedbacks;
            rptFeedback.DataBind();
            UpdatePaginationControls(pageIndex);
        }

        protected void rptFeedback_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int feedbackID = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Edit")
            {

                BAL bal = new BAL();
                Entity feedback = bal.GetFeedbackById(feedbackID);

                txtCustomerName.Text = feedback.CustomerName;
                txtEmail.Text = feedback.Email;
                txtComment.Text = feedback.Comment;
                txtRating.Text = feedback.Rating.ToString();
                txtSubmittedDate.Text = feedback.SubmittedDate.ToString("yyyy-MM-dd");

                hdnFeedbackID.Value = feedbackID.ToString();
                btnSubmitted.Visible = false;
                btnUpdate.Visible= true;
            }
            else if (e.CommandName == "Delete")
            {

                BAL bal = new BAL();
                bal.DeleteFeedback(feedbackID);

                BindFeedbackData(1);
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if(Page.IsValid){
                int feedbackID = Convert.ToInt32(hdnFeedbackID.Value);
                string customerName = txtCustomerName.Text;
                string email = txtEmail.Text;
                string comment = txtComment.Text;
                int rating = Convert.ToInt32(txtRating.Text);
                DateTime submittedDate = Convert.ToDateTime(txtSubmittedDate.Text);

                BAL bal = new BAL();
                bal.UpdateFeedback(feedbackID, customerName, email, comment, rating, submittedDate);

                ClearFormFields();
                BindFeedbackData(1);
                btnSubmitted.Visible = true;
                btnUpdate.Visible = false;
            }
        }

        private void ClearFormFields()
        {
            txtCustomerName.Text = "";
            txtEmail.Text = "";
            txtComment.Text = "";
            txtRating.Text = "";
            txtSubmittedDate.Text = "";

            hdnFeedbackID.Value = "";
        }

        [WebMethod]
        public static string SaveData(string customerName, string comment)
        {
            return "Data saved successfully!";
        }

        protected void rptPagination_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int pageIndex = Convert.ToInt32(e.CommandArgument);
            BindFeedbackData(pageIndex);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindFeedbackData(1);
        }
        protected void UpdatePaginationControls(int currentPage)
        {
            int totalRecords = GetTotalFeedbackCount(); 

            int pageSize = 10; 
            int totalPages = (int)Math.Ceiling((double)totalRecords / pageSize);

            rptPagination.DataSource = Enumerable.Range(1, totalPages);
            rptPagination.DataBind();
        }
        private int GetTotalFeedbackCount()
        {
            return 30; 
        }
    }
}