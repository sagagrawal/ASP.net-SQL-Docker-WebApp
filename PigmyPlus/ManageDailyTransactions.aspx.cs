using System;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace PigmyPlus
{
    public partial class ManageDailyTransactions : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblGroundAmount.Text = "Grand Amount: Rs. " + GetGrandTotal();
        }

        protected void grdDailyTransactions_DataBound(object sender, EventArgs e)
        {
            if (grdDailyTransactions.Rows.Count > 0)
                grdDailyTransactions.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void lnkRefresh_Click(object sender, EventArgs e)
        {
            RefreshGridView();
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {

        }

        protected void lnkView_Click(object sender, EventArgs e)
        {
            grdDailyTransactions.Visible = false;
            EditPanel.Visible = true;
            frmEditTransaction.Visible = true;
            frmEditTransaction.ChangeMode(FormViewMode.ReadOnly);
            frmEditTransaction.DataBind();
        }

        protected void lnkEditLink_Click(object sender, EventArgs e)
        {
            grdDailyTransactions.Visible = false;
            EditPanel.Visible = true;
            frmEditTransaction.Visible = true;
            frmEditTransaction.ChangeMode(FormViewMode.Edit);
            frmEditTransaction.DataBind();
        }

        protected void lnkBack_Click(object sender, EventArgs e)
        {
            grdDailyTransactions.Visible = true;
            EditPanel.Visible = false;
            frmEditTransaction.Visible = false;
            RefreshGridView();
        }

        protected void RefreshGridView()
        {
            grdDailyTransactions.DataBind();
            if (grdDailyTransactions.Rows.Count > 0)
                grdDailyTransactions.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            lnkBack_Click(sender, e);
        }

        protected void lnkUpdate_Click(object sender, EventArgs e)
        {
            lnkBack_Click(sender, e);
        }

        protected void srcTransactionsOperations_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            RefreshGridView();
        }

        protected void txtEditAccNo_TextChanged(object sender, EventArgs e)
        {
            int AccNo;
            if (int.TryParse(((TextBox)frmEditTransaction.FindControl("txtEditAccNo")).Text, out AccNo))
            {
                string name = DBClass.Scalar("Select Name from Customers where CustomerID=(Select CustomerID from Accounts where AccNo=@AccNo)", System.Data.CommandType.Text,
                    new SqlParameter("@AccNo", AccNo)).ToString();
                Label lbl = ((Label)frmEditTransaction.FindControl("lblCustomerName"));
                lbl.Text = "Customer: " + name;
                lbl.Visible = true;
                Label AccID = ((Label)frmEditTransaction.FindControl("lblEditAccountID"));
                AccID.Text = DBClass.Scalar("Select AccountID from Accounts where AccNo=@AccNo", System.Data.CommandType.Text,
                    new SqlParameter("@AccNo", AccNo)).ToString();
            }
        }

        protected string GetGrandTotal()
        {
            string result = String.Format("{0:#.#}", DBClass.Scalar("Select sum(Amount) from DailyTransactions"));
            return result;
        }
    }
}