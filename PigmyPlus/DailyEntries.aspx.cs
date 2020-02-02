using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PigmyPlus
{
    public partial class DailyEntries : BasePage
    {
        private static SqlDataReader AllActiveAccounts;
        private static long TotalCollectedAmount;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAllActiveAccounts();
                DailyEntries.TotalCollectedAmount = GetTotalAmountCollected();
                //Gonna Change below 2 lines of Code
                srcTransactions.SelectParameters.Clear();
                srcTransactions.SelectParameters.Add("TransactionDate", GetSystemDate);
            }
            if (DailyEntries.TotalCollectedAmount == 0)
                lblTotalCollectedAmount.Text = "Total Collected Amount<br/>Rs. " + "0";
            else
                lblTotalCollectedAmount.Text = "Total Collected Amount<br/>Rs. " + DailyEntries.TotalCollectedAmount;
        }

        protected void lnkRefresh_Click(object sender, EventArgs e)
        {
            srcTransactions.SelectParameters.Clear();
            srcTransactions.SelectParameters.Add("TransactionDate", GetSystemDate);
            grdTransactions.DataBind();
            if (grdTransactions.Rows.Count > 0)
                grdTransactions.HeaderRow.TableSection = TableRowSection.TableHeader;
            TotalCollectedAmount = GetTotalAmountCollected();
            Page_Load(sender, e);
        }

        protected void grdTransactions_DataBound(object sender, EventArgs e)
        {
            if (grdTransactions.Rows.Count > 0)
                grdTransactions.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void lnkChangeSystemDate_Click(object sender, EventArgs e)
        {
            //BasePage.GetSystemDate = ((TextBox) dtlSystemDate.FindControl("txtSystemDate")).Text;
            //lnkRefresh_Click(sender, e);
            //DailyEntries.TotalCollectedAmount = GetTotalAmountCollected();
            //Page_Load(sender, e);
            //LoadAllActiveAccounts();
        }

        private long GetTotalAmountCollected()
        {
            long AmountOfTheDay = 0;
            string FormattedAmount = String.Format("{0:#.#}", DBClass.Scalar("Select sum(Amount) as Total from DailyTransactions where TransactionDate=@TransactionDate", System.Data.CommandType.Text,
                    new SqlParameter("@TransactionDate", GetSystemDate)));
            long.TryParse(FormattedAmount, out AmountOfTheDay);
            return AmountOfTheDay;
        }

        private void LoadAllActiveAccounts()
        {
            DailyEntries.AllActiveAccounts = DBClass.Reader("Select * from Accounts where IsClosed=0 and OpeningDate<@OpeningDate and AccountID not in(Select DailyTransactions.AccountID from DailyTransactions where DailyTransactions.TransactionDate=@TransactionDate)",
                System.Data.CommandType.Text, new SqlParameter("@TransactionDate", BasePage.GetSystemDate),
                new SqlParameter("@OpeningDate", GetSystemDate));
            LoadNextActiveAccount();
        }

        private void LoadNextActiveAccount()
        {
            if (AllActiveAccounts == null)
            {
                ((Label)frmDailyEntries.FindControl("lblNotifyUser")).Visible = true;
            }
            else if (AllActiveAccounts.Read())
            {
                ((TextBox)frmDailyEntries.FindControl("txtAccNo")).Text = AllActiveAccounts["AccNo"].ToString();
                ((TextBox)frmDailyEntries.FindControl("txtAmount")).Focus();

                ((TextBox)frmDailyEntries.FindControl("txtAmount")).Enabled = true;
                ((Label)frmDailyEntries.FindControl("lblNotifyUser")).Visible = false;
                ((LinkButton)frmDailyEntries.FindControl("lnkSave")).Visible = true;
                ((LinkButton)frmDailyEntries.FindControl("lnkSkip")).Visible = true;
                ((ValidationSummary)frmDailyEntries.FindControl("ValidationSummaryMakeTransaction")).Enabled = true;
            }
            else
            {
                ((TextBox)frmDailyEntries.FindControl("txtAmount")).Enabled = false;
                ((Label)frmDailyEntries.FindControl("lblNotifyUser")).Visible = true;
                ((LinkButton)frmDailyEntries.FindControl("lnkSave")).Visible = false;
                ((LinkButton)frmDailyEntries.FindControl("lnkSkip")).Visible = false;
                ((ValidationSummary)frmDailyEntries.FindControl("ValidationSummaryMakeTransaction")).Enabled = false;
            }
            ((TextBox)frmDailyEntries.FindControl("txtTransactionDate")).Text = GetSystemDate;
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                DBClass.NonQuery("spDailyTransactions", System.Data.CommandType.StoredProcedure,
                    new SqlParameter("@AccountID", DBClass.Scalar("Select AccountID from Accounts where AccNo=@AccNo", System.Data.CommandType.Text, new SqlParameter("@AccNo", ((TextBox)frmDailyEntries.FindControl("txtAccNo")).Text))),
                    new SqlParameter("@TransactionDate", GetSystemDate),
                    new SqlParameter("@Amount", ((TextBox)frmDailyEntries.FindControl("txtAmount")).Text),
                    new SqlParameter("@UserName", UserName));
                DailyEntries.TotalCollectedAmount = GetTotalAmountCollected();
                lnkRefresh_Click(sender, e);
                Page_Load(sender, e);
                LoadNextActiveAccount();
                ((TextBox)frmDailyEntries.FindControl("txtAmount")).Text = "";
            }
        }

        protected void lnkView_Click(object sender, EventArgs e)
        {
            grdTransactions.Visible = false;
            EditPanel.Visible = true;
            frmEditTransaction.Visible = true;
            frmEditTransaction.ChangeMode(FormViewMode.ReadOnly);
            frmEditTransaction.DataBind();
        }

        protected void lnkEdit_Click(object sender, EventArgs e)
        {
            grdTransactions.Visible = false;
            EditPanel.Visible = true;
            frmEditTransaction.Visible = true;
            frmEditTransaction.ChangeMode(FormViewMode.Edit);
            frmEditTransaction.DataBind();
        }

        protected void lnkBack_Click(object sender, EventArgs e)
        {
            grdTransactions.Visible = true;
            EditPanel.Visible = false;
            frmEditTransaction.Visible = false;
            lnkRefresh_Click(sender, e);
        }

        protected void srcTransactionsOperations_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            frmEditTransaction.Visible = false;
            grdTransactions.Visible = true;
            lnkRefresh_Click(sender, e);
        }

        //protected void txtEditAccNo_TextChanged(object sender, EventArgs e)
        //{
        //    int AccNo;
        //    if (int.TryParse(((TextBox)frmEditTransaction.FindControl("txtEditAccNo")).Text, out AccNo))
        //    {
        //        string name = DBClass.Scalar("Select Name from Customers where CustomerID=(Select CustomerID from Accounts where AccNo=@AccNo)", System.Data.CommandType.Text,
        //            new SqlParameter("@AccNo", AccNo)).ToString();
        //        Label lbl = ((Label)frmEditTransaction.FindControl("lblCustomerName"));
        //        lbl.Text = "Customer: " + name;
        //        lbl.Visible = true;
        //        Label AccID = ((Label)frmEditTransaction.FindControl("lblEditAccountID"));
        //        AccID.Text = DBClass.Scalar("Select AccountID from Accounts where AccNo=@AccNo", System.Data.CommandType.Text,
        //            new SqlParameter("@AccNo", AccNo)).ToString();
        //    }
        //}

        protected void srcTransactions_Deleted(object sender, SqlDataSourceStatusEventArgs e)
        {
            DailyEntries.TotalCollectedAmount = GetTotalAmountCollected();
            LoadAllActiveAccounts();
            Page_Load(sender, e);
        }

        protected void lnkSkip_Click(object sender, EventArgs e)
        {
            LoadNextActiveAccount();
            grdTransactions_DataBound(sender, e);
        }
    }
}