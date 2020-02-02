using System;
using System.Web.UI.WebControls;

namespace PigmyPlus
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoggedInTime"] != null)
                txtLoggedInText.Text = String.Format("{0:t}", Session["LoggedInTime"]);
            else
                Response.Redirect("~/Login.aspx");
            lblSystemDate.Text = BasePage.GetSystemDate;
        }

        protected void lnkChangeSystemDate_Click(object sender, EventArgs e)
        {
            BasePage.GetSystemDate = ((TextBox)dtlSystemDate.FindControl("txtSystemDate")).Text;
            Page_Load(sender, e);
            Server.Transfer(Request.Url.AbsolutePath, false);            
        }
    }
}