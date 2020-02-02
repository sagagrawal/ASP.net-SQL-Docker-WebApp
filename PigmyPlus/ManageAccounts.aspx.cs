using System;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace PigmyPlus
{
    public partial class ManageAccounts : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void grdAccounts_DataBound(object sender, EventArgs e)
        {
            if (grdAccounts.Rows.Count > 0)
                grdAccounts.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            srcAccounts.SelectParameters.Clear();
            lnkRemoveFilters.Visible = true;
            lnkFilter.Visible = false;
            RefreshGridAccounts();
        }

        protected void lnkRefresh_Click(object sender, EventArgs e)
        {
            RefreshGridAccounts();
            RefreshGridAccountDetails();
        }

        protected void ddlCustomers_DataBound(object sender, EventArgs e)
        {
            DropDownList ddl = ((DropDownList)frmAccounts.FindControl("ddlCustomers"));
            if (ddl != null)
                if (ddl.Items.Count > 0)
                    ddl.Items.Insert(0, new ListItem("Select Customer", "-1"));
        }

        protected void lnkEditLink_Click(object sender, EventArgs e)
        {
            grdAccounts.Visible = false;
            frmEditAccount.Visible = true;
            lnkRemoveFilters.Visible = false;
        }

        protected void RefreshGridAccounts()
        {
            grdAccounts.DataBind();
            if (grdAccounts.Rows.Count > 0)
                grdAccounts.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void RefreshGridAccountDetails()
        {
            grdAccountDetails.DataBind();
            if (grdAccountDetails.Rows.Count > 0)
                grdAccounts.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void srcAccounts_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            RefreshGridAccounts();
            Response.Redirect("~/ManageAccounts.aspx"); //Update Panel affecting postback of the page when clicked on Save Link
        }

        protected void lnkRemoveFilters_Click(object sender, EventArgs e)
        {
            srcAccounts.SelectParameters.Add("Filter", "0");
            lnkRemoveFilters.Visible = false;
            lnkFilter.Visible = true;
            RefreshGridAccounts();
        }

        protected void ddlEditCustomers_DataBound(object sender, EventArgs e)
        {
            DropDownList ddl = ((DropDownList)frmEditAccount.FindControl("ddlEditCustomers"));
            if (ddl != null)
                if (ddl.Items.Count > 0)
                    ddl.Items.Insert(0, new ListItem("Select Customer", "-1"));
        }

        protected void srcAccounts_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            RefreshGridAccounts();
            Response.Redirect("~/ManageAccounts.aspx");
        }

        protected void lnkCancelEdit_Click(object sender, EventArgs e)
        {
            RefreshGridAccounts();
            Response.Redirect("~/ManageAccounts.aspx");
        }

        protected void txtAccNo_TextChanged(object sender, EventArgs e)
        {
            int IsAvailable = ((int)DBClass.Scalar("IsAccNoAvailable", System.Data.CommandType.StoredProcedure,
                   new SqlParameter("AccNo", ((TextBox)frmAccounts.FindControl("txtAccNo")).Text)));

            if (IsAvailable == 0)
            {
                ((CustomValidator)frmAccounts.FindControl("cvIsAccNoAvailable")).IsValid = false;
                ((LinkButton)frmAccounts.FindControl("lnkSave")).Enabled = false;
                ((TextBox)frmAccounts.FindControl("txtAccNo")).Focus();
            }
            else
            {
                ((LinkButton)frmAccounts.FindControl("lnkSave")).Enabled = true;
                ((CustomValidator)frmAccounts.FindControl("cvIsAccNoAvailable")).IsValid = true;
            }
        }

        protected void lnkView_Click(object sender, EventArgs e)
        {
            grdAccounts.Visible = false;
            grdAccountDetails.Visible = true;
            frmDisplayPersonalDetails.Visible = true;
            lnkRemoveFilters.Visible = false;
            RefreshGridAccountDetails();
        }

        protected void frmDisplayPersonalDetails_DataBound(object sender, EventArgs e)
        {
            int AccountID;
            if (grdAccounts.SelectedDataKey != null)
            {
                int.TryParse(grdAccounts.SelectedDataKey.Value.ToString(), out AccountID);
                string txt = ((Label)frmDisplayPersonalDetails.FindControl("txtTotalAmountCollected")).Text;

                txt = txt + String.Format("{0:#.##}", DBClass.Scalar("Select sum(Amount) from DailyTransactions where AccountID=@AccountID", System.Data.CommandType.Text,
                    new SqlParameter("@AccountID", AccountID)));

                ((Label)frmDisplayPersonalDetails.FindControl("txtTotalAmountCollected")).Text = txt;

                txt = ((Label)frmDisplayPersonalDetails.FindControl("txtLastTransactionDate")).Text;

                SqlDataReader dr = DBClass.Reader("Select TransactionDate from DailyTransactions where AccountID=@AccountID order by TransactionDate DESC", System.Data.CommandType.Text,
                    new SqlParameter("@AccountID", AccountID));

                if (dr.Read())
                    txt = txt + String.Format("{0:dd-MMM-yyyy}", dr[0]);
                ((Label)frmDisplayPersonalDetails.FindControl("txtLastTransactionDate")).Text = txt;
                dr.Close();
            }
            else
            {
                Response.Redirect("~/SomethingWentWrong.aspx");
            }
        }

        protected void grdAccountDetails_DataBound(object sender, EventArgs e)
        {
            if (grdAccountDetails.Rows.Count > 0)
                grdAccountDetails.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void lnkBack_Click(object sender, EventArgs e)
        {
            grdAccounts.Visible = true;
            grdAccountDetails.Visible = false;
            frmDisplayPersonalDetails.Visible = false;
            lnkRemoveFilters.Visible = !lnkFilter.Visible;
            RefreshGridAccounts();
        }

        protected void ValidateAccNo(object source, ServerValidateEventArgs args)
        {
            
        }

        protected void cbClosedAccount_CheckedChanged(object sender, EventArgs e)
        {
            TextBox tbClosingDate = ((TextBox)frmEditAccount.FindControl("txtClosingDate"));
            CheckBox cbAccountStatus = ((CheckBox)frmEditAccount.FindControl("cbClosedAccount"));
            RequiredFieldValidator rfv = ((RequiredFieldValidator)frmEditAccount.FindControl("reqEditClosingDate"));
            tbClosingDate.Text = "";
            tbClosingDate.Enabled = cbAccountStatus.Checked;
            rfv.Enabled = cbAccountStatus.Checked;
        }

        protected string GetTotalAmountCollected(string AccountID)
        {
            int GrandAmount = 0;
            int.TryParse(String.Format("{0:#.#}", DBClass.Scalar("Select sum(DailyTransactions.Amount) from DailyTransactions where DailyTransactions.AccountID = @AccountID", System.Data.CommandType.Text,
                new SqlParameter("@AccountID", AccountID))), out GrandAmount);
            return GrandAmount.ToString();
        }
    }
}