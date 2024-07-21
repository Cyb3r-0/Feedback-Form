using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace test
{
    public class Entity
    {
        public int FeedbackID { get; set; }
        public string CustomerName { get; set; }
        public string Email { get; set; }
        public string Comment { get; set; }
        public int Rating { get; set; }
        public DateTime SubmittedDate { get; set; }
    }
}