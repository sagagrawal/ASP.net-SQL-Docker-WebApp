using System;
using System.Web.UI;
using System.Data.SqlClient;
using System.Data;
using System.Web.Security;

namespace PigmyPlus
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                txtUserName.Text = Microsoft.VisualBasic.Strings.StrConv(txtUserName.Text, Microsoft.VisualBasic.VbStrConv.ProperCase);
                AuthenticateUser(txtUserName.Text.Trim(), txtPassword.Text.Trim());
            }
        }

        private void AuthenticateUser(String Username, String Password)
        {
            int authenticate = Convert.ToInt32(DBClass.Scalar("spAuthenticate", CommandType.StoredProcedure,
                new SqlParameter("@UserName", Username),
                new SqlParameter("@Password", Password)));
            if (authenticate == 1)
            {
                Session["LoggedInTime"] = String.Format("{0:t}", DateTime.Now);
                FormsAuthentication.RedirectFromLoginPage(Username, false);
            }
            else
                lblMsg.Text = "Invalid Username or Password ! Try Again";
        }
    }
}