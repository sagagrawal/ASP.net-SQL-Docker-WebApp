using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PigmyPlus
{
    public partial class CustomizeCustomerGrid : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            Server.Transfer("~/Settings.aspx", false);
        }

        protected void srcCustomerCofiguration_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            frmVisibility.Visible = false;
            lblHomePageText.Visible = true;
            lblSettingsUpdated.Visible = true;
            hlHomePage.Visible = true;
        }
    }
}