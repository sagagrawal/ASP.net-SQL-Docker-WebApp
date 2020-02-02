using System;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace PigmyPlus
{
    public partial class ManageCustomers : BasePage
    {
        private static SqlDataReader dr;

        public static SqlDataReader GetConfigurations
        {
            get
            {
                //dr = DBClass.Reader("Select * from CustomerConfigurations");
                return null;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void grdCustomers_DataBound(object sender, EventArgs e)
        {
            if (grdCustomers.Rows.Count > 0)
                grdCustomers.HeaderRow.TableSection = TableRowSection.TableHeader;
            //GetVisibilityStatus();
        }

        protected void lnkRefresh_Click(object sender, EventArgs e)
        {
            RefreshgrdCustomers();
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            EditPanel.Visible = false;
            frmCustomer.Visible = false;
            grdCustomers.Visible = true;
            lnkRemoveFilters.Visible = !(lnkFilter.Visible);
        }

        protected void lnkView_Click(object sender, EventArgs e)
        {
            EditPanel.Visible = true;
            grdCustomers.Visible = false;
            frmEditCustomer.ChangeMode(FormViewMode.ReadOnly);
            frmEditCustomer.DataBind();
            lnkRemoveFilters.Visible = false;
        }

        protected void lnkEditLink_Click(object sender, EventArgs e)
        {
            EditPanel.Visible = true;
            grdCustomers.Visible = false;
            frmEditCustomer.ChangeMode(FormViewMode.Edit);
            frmEditCustomer.DataBind();
            lnkRemoveFilters.Visible = false;
        }

        protected void lnkRemoveFilters_Click(object sender, EventArgs e)
        {
            lnkRemoveFilters.Visible = false;
            lnkFilter.Visible = true;
            srcgrdCustomers.SelectParameters.Add("Filter", System.Data.DbType.Byte, "0");
            RefreshgrdCustomers();
        }

        protected void lnkFilter_Click(object sender, EventArgs e)
        {
            lnkFilter.Visible = false;
            lnkRemoveFilters.Visible = true;
            srcgrdCustomers.SelectParameters.Clear();
            RefreshgrdCustomers();
        }

        protected void lnkBack_Click(object sender, EventArgs e)
        {
            EditPanel.Visible = false;
            grdCustomers.Visible = true;
            lnkRefresh_Click(sender, e);
            lnkRemoveFilters.Visible = !(lnkFilter.Visible);
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            EditPanel.Visible = false;
            grdCustomers.Visible = true;
            RefreshgrdCustomers();
            lnkRemoveFilters.Visible = !(lnkFilter.Visible);
        }

        protected void RefreshgrdCustomers()
        {
            grdCustomers.DataBind();
            if (grdCustomers.Rows.Count > 0)
                grdCustomers.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void srcCustomers_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            RefreshgrdCustomers();
        }

        protected void srcCustomers_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            RefreshgrdCustomers();
        }

        protected void reqID_ServerValidate(object sender, CommandEventArgs e)
        {
            if (((TextBox)frmCustomer.FindControl("txtUID")).Text == "" && ((TextBox)frmCustomer.FindControl("txtPanID")).Text == "" && ((TextBox)frmCustomer.FindControl("txtElectionID")).Text == "")
                ((CustomValidator)frmCustomer.FindControl("reqID")).IsValid = false;
        }

        protected string GetNoOfLinkedAccounts(string CustomerID)
        {
            int Count = 0;

            Count = Convert.ToInt32(DBClass.Scalar("Select count(*) from Accounts where Accounts.CustomerID=@CustomerID", System.Data.CommandType.Text,
                new SqlParameter("@CustomerID", CustomerID)));

            return Count.ToString();
        }

        private void GetVisibilityStatus()
        {
            SqlDataReader dr = DBClass.Reader("SELECT Name, NoOfAccountsLinked, Address, PhoneNo, MobileNo, Age, DOB, CustomerUID, CustomerPanID, CustomerElectionID, Gender, CreatedOn, ModifiedOn, IsDiscontinued, DiscontinuedOn FROM CustomerConfigurations");
            int index = 0;
            if (dr != null)
            {
                if (dr.Read())
                {
                    foreach (DataControlField c in grdCustomers.Columns)
                    {
                        if (c.HeaderText == "Name" || c.HeaderText == "No. of <br/>Accounts Linked" || c.HeaderText == "Address" || c.HeaderText == "Phone No" || c.HeaderText == "Mobile No" || c.HeaderText == "Age" || c.HeaderText == "Date of Birth" || c.HeaderText == "Aadhar-card No" || c.HeaderText == "Pan-card No" || c.HeaderText == "Election-card No" || c.HeaderText == "Gender" || c.HeaderText == "Created On" || c.HeaderText == "Modified On" || c.HeaderText == "Discontinue" || c.HeaderText == "Discontinued On")
                        {
                            string value = dr[index++].ToString();
                            if (value == "False")
                                c.Visible = false;
                            else
                                c.Visible = true;
                        }
                    }
                }
            }
        }

        protected static bool GetRequired(string Attribute)
        {
            SqlDataReader dr = GetConfigurations;
            if (dr != null)
            {
                if (dr.Read())
                {
                    return Convert.ToBoolean(dr[Attribute]);
                }
            }
            return false;
        }
    }
}