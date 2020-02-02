using System;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;

namespace PigmyPlus
{
    public partial class WebForm6 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if (ChangePassword())
                {
                    lblMessage.ForeColor = System.Drawing.Color.Black;
                    lblMessage.Text = "<b> Password successfully changed </b> , Click <a href='Welcome.aspx'> Here </a>" + " to goto welcome screen";
                    btnChangePassword.Visible = false;
                }
                else
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "Invalid Current Password...";
                }
  
                DBClass.CloseConnection();
            }
        }

        private bool ChangePassword()
        {
            return Convert.ToBoolean(DBClass.Scalar("spChangePassword", CommandType.StoredProcedure, 
                                                    new SqlParameter("@UserName", User.Identity.Name), 
                                                    new SqlParameter("@CurrentPassword", txtCurrentPassword.Text.Trim()), 
                                                    new SqlParameter("@NewPassword", txtNewPassword.Text.Trim())
                                                    )
                                    );
        }
    }
}