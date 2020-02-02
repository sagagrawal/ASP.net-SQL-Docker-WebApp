using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PigmyPlus.ReportForms
{
    public partial class rptfrmTransactionByDate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnGetReport_Click(object sender, EventArgs e)
        {
            Button btn = ((Button)frmTransactionReport.FindControl("btnGetReport"));
            TextBox txt = ((TextBox)frmTransactionReport.FindControl("txtTransactionDate"));
            btn.Visible = false;
            rptViewer.Reset();

            rptViewer.LocalReport.ReportPath = @"C:\Users\Megha\Desktop\PigmyPlus\PigmyPlus\PigmyPlus\Reports\TransactionByDate.rdlc";

            ReportDataSource dsc = new ReportDataSource("TransactionByDateDataSet", DBClass.getDataTable("spGetCurrentDateTransactions", "DailyTransactions", System.Data.CommandType.StoredProcedure,
                new SqlParameter("@TransactionDate", txt.Text)));

            rptViewer.LocalReport.DataSources.Add(dsc);
            rptViewer.LocalReport.SetParameters(new ReportParameter("TransactionDate", txt.Text));
            rptViewer.LocalReport.Refresh();
            btn.Visible = true;
        }
    }
}