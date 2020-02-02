using System;

namespace PigmyPlus
{
    public class BasePage : System.Web.UI.Page
    {
        private static string SystemDateTime;

        public static string GetSystemDate
        {
            get
            {
                return BasePage.SystemDateTime;
            }
            set
            {
                BasePage.SystemDateTime = String.Format("{0:dd-MMM-yyyy}", value);
            }
        }

        public string UserName
        {
            get
            {
                return User.Identity.Name;
            }
        }
    }
}