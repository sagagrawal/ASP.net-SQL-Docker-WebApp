<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="ManageAccounts.aspx.cs" Inherits="PigmyPlus.ManageAccounts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadingContent" runat="server">
    <span class="fa fa-th-large fa-fw"></span>&nbsp Manage Accounts.
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ActionContentsButtons" runat="server">
    <div class="btn-group">
        <asp:LinkButton ID="lnkRemoveFilters" OnClick="lnkRemoveFilters_Click" runat="server" Text='<i style="color:White" class="fa fa-trash-o fa-lg"></i> Remove Filter' class="btn btn-primary btn-xs" Visible="true" />
    </div>
    <div class="btn-group">
        <asp:LinkButton ID="lnkRefresh" runat="server" Text='<i style="color:White" class="fa fa-refresh fa-lg"></i> Refresh' class="btn btn-primary btn-xs" OnClick="lnkRefresh_Click" />
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ActionContent" runat="server">
    <ul class="dropdown-menu pull-right" role="menu">
        <li><a href="#" data-toggle="modal" data-target="#myModal" onclick="JavaScript:showInsert();"><span class="fa fa-smile-o fa-fw"></span>New Account</a> </li>
        <li>
            <asp:LinkButton Visible="false" runat="server" ID="lnkFilter" OnClick="lnkFilter_Click"><span class="fa fa-filter fa-fw"></span>Filter</asp:LinkButton></li>
        <li><a href="ManageAccounts.aspx"><span class="fa fa-refresh fa-fw fa-spin"></span>Reload Page </a></li>
        <li class="divider"></li>
        <li><a href="Welcome.aspx"><span class="fa fa-home fa-lg"></span> Home </a></li>
    </ul>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        #divInsert {
            display: none;
        }

        #divDisplayAccounts {
            display: block;
        }
    </style>

    <!-- GridView to Display Accounts -->
    <div id="divDisplayAccounts" class="table-responsive">
        <asp:GridView DataKeyNames="AccountID" class="table table-striped table-bordered table-hover DataTable"
            ID="grdAccounts" DataSourceID="srcAccounts" runat="server" AutoGenerateColumns="false"
            OnDataBound="grdAccounts_DataBound">
            <EmptyDataTemplate>
                <h3>No Accounts Found!</h3>
            </EmptyDataTemplate>
            <Columns>
                <asp:BoundField HeaderText="AccountID" DataField="AccountID" Visible="false" />
                <asp:TemplateField HeaderText="Account No.">
                    <ItemTemplate>
                        <div class="btn-group">
                            <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                                <span class="fa fa-bell fa-fw"></span><span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu pull-left" role="menu">
                                <li>
                                    <asp:LinkButton ID="lnkView" runat="server"
                                        Text='<i class="fa fa-eye fa-fw"></i> View Record' OnClick="lnkView_Click"
                                        CommandName="Select" ToolTip="View Record" />
                                </li>
                                <li>
                                    <asp:LinkButton ID="lnkEditLink" runat="server"
                                        Text='<i class="fa fa-edit fa-fw"></i> Edit Account' OnClick="lnkEditLink_Click"
                                        CommandName="Select" ToolTip="Edit Record" />
                                </li>
                            </ul>
                        </div>
                        &nbsp;
                        <asp:Label runat="server" ID="lblAccNo" Text='<%# Eval("AccNo") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="CustomerID" ReadOnly="true" DataField="CustomerID" Visible="false" />
                <asp:BoundField HeaderText="Customer" ReadOnly="true" DataField="Name" />
                <asp:TemplateField HeaderText="Opening Date">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblOpeningDate" Text='<%# Eval("OpeningDate", "{0:dd-MMM-yyy}") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Closing Date">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblClosingDate" Text='<%# Eval("ClosingDate", "{0:dd-MMM-yyy}") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Daily Amount(Rs)">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblDailyAmt" Text='<%# Eval("DailyAmt", "{0:#.#}") + " /-" %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <%-- TotalAmountCollected --%>
                <asp:TemplateField HeaderText="Amount Collected">
                    <ItemTemplate>
                        <asp:Label Text='<%# GetTotalAmountCollected(Eval("AccountID").ToString()) %>' runat="server" ID="lblTotalAmountCollected" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Closed">
                    <ItemTemplate>
                        <div class="make-switch switch-small" data-on-label='Yes' data-off-label="No" data-on="success" data-off="danger">
                            <asp:CheckBox ID="IsClosed" Checked='<%# Eval("IsClosed") %>' runat="server" />
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <!-- GridView Ends..-->

    <!-- /New Account  modal -->
    <div id="divInsert">
        <asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager>

        <asp:FormView ID="frmAccounts" runat="server" Width="100%" DataSourceID="srcAccounts" DefaultMode="Insert">
            <InsertItemTemplate>
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <span style="color: White" class="fa fa-smile-o fa-lg"></span>&nbsp Register New Account.
                    </div>
                    <div class="panel-body">
                        <!-- Add 2 HTML Tables within a row inside panel body -->
                        <!-- Starts a row inside panel body -->
                        <div class="row">
                            <div class="col-lg-6" style='text-align: center'>
                                <table style="width: 100%; text-align: left;">
                                    <%--AccNo--%>
                                    <tr>
                                        <td style="width: 35%">
                                            <asp:Label ID="lblAccNo" runat="server" Text="Account No"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                                                <ContentTemplate>
                                                    <asp:TextBox Text='<%# Bind("AccNo") %>' runat="server" ID="txtAccNo" CssClass="form-control"
                                                        Height="30px" ToolTip="Enter Account No" AutoPostBack="true" OnTextChanged="txtAccNo_TextChanged"></asp:TextBox>
                                                    <asp:CustomValidator runat="server" ID="cvIsAccNoAvailable" Display="None"
                                                        ValidationGroup="InsertGroup" ForeColor="Red" ControlToValidate="txtAccNo" ErrorMessage="Account No. already exists.<br/>Please enter Unique Acc No to Submit form." OnServerValidate="ValidateAccNo">
                                                    </asp:CustomValidator>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                            <asp:RequiredFieldValidator ErrorMessage="Enter Account No" Display="None" Text="*" ForeColor="Red" ValidationGroup="InsertGroup"
                                                ControlToValidate="txtAccNo" runat="server" ID="reqAccNo"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <%-- Customer Name--%>
                                    <tr>
                                        <td style="width: 35%">
                                            <asp:Label ID="lblName" runat="server" Text="Name"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList CssClass="Select2Class" OnDataBound="ddlCustomers_DataBound" Width="100%" SelectedValue='<%# Bind("CustomerID") %>'
                                                runat="server" ID="ddlCustomers" Height="30px" DataSourceID="srcCustomers"
                                                DataTextField="Name" DataValueField="CustomerID">
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator InitialValue="-1" ErrorMessage="Select Customer" Display="None"
                                                ForeColor="Red" ValidationGroup="InsertGroup" Text="*" runat="server" ControlToValidate="ddlCustomers" ID="reqCustomerName"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <%-- Opening Date --%>
                                    <tr>
                                        <td style="width: 35%">
                                            <asp:Label ID="lblOpeningDate" runat="server" Text="Opening Date"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox runat="server" Text='<%# Bind("OpeningDate") %>' ID="txtOpeningDate" CssClass="form-control DateInput" Height="30px"></asp:TextBox>
                                            <asp:RequiredFieldValidator Display="None" ID="reqOpeningDate" ValidationGroup="InsertGroup" ErrorMessage="Enter Opening Date" ControlToValidate="txtOpeningDate" runat="server"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <%-- Daily Amt--%>
                                    <tr>
                                        <td style="width: 35%">
                                            <asp:Label ID="lblDailyAmt" runat="server" Text="Daily Amount"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("DailyAmt") %>' runat="server" ID="txtDailyAmt" CssClass="form-control"
                                                Height="30px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ErrorMessage="Enter Daily Amount" Display="None" Text="*" ForeColor="Red" ValidationGroup="InsertGroup"
                                                ControlToValidate="txtDailyAmt" runat="server" ID="reqDailyAmt"></asp:RequiredFieldValidator>
                                            <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                                                <ContentTemplate>
                                                    <asp:ValidationSummary runat="server" ForeColor="Red" HeaderText="Errors" DisplayMode="BulletList" ID="vgInsertGroup" ValidationGroup="InsertGroup" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                    <%--Buttons--%>
                                    <tr>
                                        <td></td>
                                        <td>
                                            <br />
                                            <asp:UpdatePanel runat="server">
                                                <ContentTemplate>
                                                    <asp:LinkButton ID="lnkSave" Width="30%" CommandName="Insert" ValidationGroup="InsertGroup"
                                                        CausesValidation="True" runat="server" Text='<i style="color:White" class="fa fa-floppy-o fa-fw"></i> Save'
                                                        class="btn btn-default btn-success btn-fw" />
                                                    <button type="button" style="width: 30%" class="btn btn-default btn-success btn-fw" onclick="JavaScript:showDisplay();">
                                                        <span style="color: White" class="fa fa-undo fa-fw"></span>Close
                                                    </button>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <!-- Ends a row inside panel body -->
                    </div>
                </div>
            </InsertItemTemplate>
        </asp:FormView>
    </div>
    <!-- /New Account modal ends -->

    <!-- Edit Panel -->
    <div>
        <asp:FormView Visible="false" ID="frmEditAccount" runat="server" Width="100%" DataSourceID="srcAccounts" DefaultMode="Edit">
            <EditItemTemplate>
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <span style="color: White" class="fa fa-smile-o fa-lg"></span>&nbsp Edit Account.
                    </div>
                    <div class="panel-body">
                        <!-- Add 2 HTML Tables within a row inside panel body -->
                        <!-- Starts a row inside panel body -->
                        <div class="row">
                            <div class="col-lg-6" style='text-align: center'>
                                <table style="width: 100%; text-align: left;">
                                    <%--AccNo--%>
                                    <tr>
                                        <td style="width: 35%">
                                            <asp:Label ID="lblEditAccNo" runat="server" Text="Account No"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("AccNo") %>' Enabled="false" runat="server" ID="txtEditAccNo" CssClass="form-control"
                                                Height="30px" ToolTip="Enter Account No"></asp:TextBox>
                                            <%--                                                    <asp:CustomValidator runat="server" ID="cvEditIsAccNoAvailable" Display="None"
                                                        ValidationGroup="EditGroup" ForeColor="Red" ControlToValidate="txtEditAccNo" ErrorMessage="Account No. already exists" OnServerValidate="ValidateAcctNo">
                                                    </asp:CustomValidator>
                                                    <asp:RequiredFieldValidator ErrorMessage="Enter Account No" Display="None" Text="*" ForeColor="Red" ValidationGroup="EditGroup"
                                                        ControlToValidate="txtEditAccNo" runat="server" ID="reqEditAccNo"></asp:RequiredFieldValidator>--%>
                                        </td>
                                    </tr>
                                    <%-- Customer Name--%>
                                    <tr>
                                        <td style="width: 35%">
                                            <asp:Label ID="lblEditName" runat="server" Text="Name"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList CssClass="Select2Class" OnDataBound="ddlEditCustomers_DataBound" Width="100%" SelectedValue='<%# Bind("CustomerID") %>'
                                                runat="server" ID="ddlEditCustomers" Height="30px" DataSourceID="srcCustomers"
                                                DataTextField="Name" DataValueField="CustomerID">
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator InitialValue="-1" ErrorMessage="Select Customer" Display="None"
                                                ForeColor="Red" ValidationGroup="EditGroup" Text="*" runat="server" ControlToValidate="ddlEditCustomers" ID="reqEditCustomerName"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <%-- Opening Date --%>
                                    <tr>
                                        <td style="width: 35%">
                                            <asp:Label ID="lblEditOpeningDate" runat="server" Text="Opening Date"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox runat="server" Text='<%# Bind("OpeningDate", "{0:dd-MMM-yyyy}") %>' ID="txtEditOpeningDate" CssClass="form-control DateInput" Height="30px"></asp:TextBox>
                                            <asp:RequiredFieldValidator Display="None" ID="reqEditOpeningDate" ValidationGroup="EditGroup" ErrorMessage="Enter Opening Date" ControlToValidate="txtEditOpeningDate" runat="server"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <%-- Daily Amt--%>
                                    <tr>
                                        <td style="width: 35%">
                                            <asp:Label ID="lblEditDailyAmt" runat="server" Text="Daily Amount"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("DailyAmt", "{0:#.##}") %>' runat="server" ID="txtEditDailyAmt" CssClass="form-control"
                                                Height="30px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ErrorMessage="Enter Daily Amount" Display="None" Text="*" ForeColor="Red" ValidationGroup="EditGroup"
                                                ControlToValidate="txtEditDailyAmt" runat="server" ID="reqEditDailyAmt"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <%-- Checkbox for IsClosed --%>
                                    <tr>
                                        <td></td>
                                        <td style="width: 35%">
                                            <asp:UpdatePanel runat="server">
                                                <ContentTemplate>
                                                    <asp:CheckBox AutoPostBack="true" runat="server" ID="cbClosedAccount" CssClass="checkbox-inline" Checked='<%# Bind("IsClosed") %>' Text="Closed" OnCheckedChanged="cbClosedAccount_CheckedChanged" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                    <%-- Closing Date --%>
                                    <tr>
                                        <td style="width: 35%">
                                            <asp:Label ID="lblClosingDate" runat="server" Text="Closing Date"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:UpdatePanel runat="server">
                                                <ContentTemplate>
                                                    <asp:TextBox Enabled='<%# ((CheckBox)frmEditAccount.FindControl("cbClosedAccount")).Checked %>' Text='<%# Bind("ClosingDate", "{0:dd-MMM-yyyy}") %>' runat="server" ID="txtClosingDate"
                                                        CssClass="form-control DateInput"
                                                        Height="30px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="reqEditClosingDate" Enabled='<%# ((CheckBox)frmEditAccount.FindControl("cbClosedAccount")).Checked %>' ErrorMessage="Choose Closing Date of Account" ControlToValidate="txtClosingDate" runat="server"
                                                        Display="None" Text="*" ForeColor="Red" ValidationGroup="EditGroup" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                            <asp:ValidationSummary runat="server" ForeColor="Red" HeaderText="Errors" DisplayMode="BulletList" ID="vgInsertGroup" ValidationGroup="EditGroup" />
                                        </td>
                                    </tr>
                                    <%--Buttons--%>
                                    <tr>
                                        <td></td>
                                        <td>
                                            <br />
                                            <asp:LinkButton ID="lnkSave" Width="30%" CommandName="Update" ValidationGroup="EditGroup"
                                                CausesValidation="True" runat="server" Text='<i style="color:White" class="fa fa-floppy-o fa-fw"></i> Save'
                                                class="btn btn-default btn-success btn-fw" />

                                            <asp:LinkButton runat="server" ID="lnkCancelEdit" Text='<i style="color:White" class="fa fa-undo fa-fw"></i> Cancel '
                                                OnClick="lnkCancelEdit_Click" Style="width: 30%" class="btn btn-default btn-success btn-fw">
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <!-- Ends a row inside panel body -->
                    </div>
                </div>
            </EditItemTemplate>
        </asp:FormView>
    </div>
    <!-- Edit Panel Ends -->

    <!-- Display Panel and View Record -->
    <div class="col-lg-12">
        <!-- Panel for Displaying Account Information in a FormView -->
        <asp:Panel ID="DisplayPanel" runat="server" CssClass="col-lg-12 col-md-12 col-sm-12">
            <asp:FormView Visible="false" ID="frmDisplayPersonalDetails" runat="server" OnDataBound="frmDisplayPersonalDetails_DataBound" Width="100%"
                DataSourceID="srcGetCustomerDetails" DefaultMode="ReadOnly">
                <EmptyDataTemplate>
                    <h3>No Personal Details Found !</h3>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <span style="color: White" class="fa fa-smile-o fa-lg"></span>&nbsp;View Customer Data.
                        </div>
                        <div class="panel-body">
                            <!-- Add 2 HTML Tables within a row inside panel body -->
                            <!-- Starts a row inside panel body -->
                            <div class="row">
                                <div class="col-lg-12" style='text-align: center'>
                                    <table style="width: 100%; text-align: left;" class="table-responsive">
                                        <!-- Account No, Opening Date, Name, Gender -->
                                        <tr>
                                            <%--Account No--%>
                                            <td style="width: 10%">
                                                <asp:Label Font-Bold="true" ID="lblAccNo" runat="server" Text="Account No"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ForeColor="Red" Font-Bold="true" Font-Size="Large" ID="txtAccNo" runat="server" Height="30px" Text='<%# Eval("AccNo") %>' />
                                            </td>
                                            <%--Opening Date--%>
                                            <td style="width: 10%">
                                                <asp:Label Font-Bold="true" ID="lblOpeningDate" runat="server" Text="Opening Date"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label Font-Size="Medium" ForeColor="Blue" ID="txtOpeningDate" runat="server" Height="30px" Text='<%# Eval("OpeningDate", "{0:dd-MMM-yyyy}") %>' />
                                            </td>
                                            <%--Name--%>
                                            <td style="width: 10%">
                                                <asp:Label Font-Bold="true" ID="lblName" runat="server" Text="Customer Name"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label Font-Size="Medium" ForeColor="Blue" ID="txtName" runat="server" Height="30px" Text='<%# Eval("Name") %>' />
                                            </td>
                                            <%--Gender--%>
                                            <td style="width: 10%">
                                                <asp:Label Font-Bold="true" ID="lblGender" runat="server" Text="Gender"></asp:Label>
                                            </td>
                                            <td style="width: 10%">
                                                <asp:Label Font-Size="Medium" ForeColor="Blue" ID="txtGender" runat="server" Height="30px" Text='<%# Eval("Gender") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="8">
                                                <hr />
                                            </td>
                                        </tr>
                                        <!-- UID, Pan ID, Election ID-->
                                        <tr>
                                            <td style="width: 10%">
                                                <asp:Label Font-Bold="true" ID="lblUID" runat="server" Text="Aadhar Card No"></asp:Label>
                                            </td>
                                            <td style="width: 10%">
                                                <asp:Label Font-Size="Medium" ForeColor="Blue" ID="txtUID" runat="server" Height="30px" Text='<%# Eval("CustomerUID") %>' />
                                            </td>
                                            <td style="width: 10%">
                                                <asp:Label Font-Bold="true" ID="lblPanID" runat="server" Text="Pan Card No"></asp:Label>
                                            </td>
                                            <td style="width: 10%">
                                                <asp:Label Font-Size="Medium" ForeColor="Blue" ID="txtPanID" Width="100%" Text='<%# Eval("CustomerPanID") %>' Height="30px" runat="server" />
                                            </td>
                                            <td style="width: 10%">
                                                <asp:Label Font-Bold="true" ID="lblElectionID" runat="server" Text="Election card No"></asp:Label>
                                            </td>
                                            <td style="width: 10%">
                                                <asp:Label Font-Size="Medium" ForeColor="Blue" ID="txtElectionID" runat="server" Height="30px" Text='<%# Eval("CustomerElectionID") %>' />
                                            </td>
                                            <td style="width: 10%">
                                                <asp:Label Height="30px" Font-Bold="true" ID="lblIsDiscontinued" runat="server" Text="Customer Discontinue Status"></asp:Label>
                                            </td>
                                            <td style="width: 10%">
                                                <div class="make-switch switch-small" data-on-label='Yes' data-off-label="No" data-on="success" data-off="danger">
                                                    <asp:CheckBox ID="IsDiscontinued" Checked='<%# Eval("IsDiscontinued") %>' runat="server" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="8">
                                                <hr />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 10%">
                                                <asp:Label Font-Bold="true" ID="lblTotalAmountCollected" runat="server" Text="Total Amount Collected"></asp:Label>
                                            </td>
                                            <td style="width: 10%">
                                                <asp:Label CssClass="btn btn-primary" Font-Bold="true" Font-Size="Medium" ID="txtTotalAmountCollected" runat="server" Height="35px" Text="Rs. " />
                                            </td>
                                            <td style="width: 10%">
                                                <asp:Label Font-Bold="true" ID="lblLastTransactionDate" runat="server" Text="Last Transaction Made on"></asp:Label>
                                            </td>
                                            <td style="width: 10%">
                                                <asp:Label Font-Size="Medium" ForeColor="Blue" ID="txtLastTransactionDate" runat="server" Height="30px" />
                                            </td>
                                            <td style="width: 10%">
                                                <asp:Label Height="30px" Font-Bold="true" ID="Label1" runat="server" Text="Account Discontinue Status"></asp:Label>
                                            </td>
                                            <td style="width: 10%">
                                                <div class="make-switch switch-small" data-on-label='Yes' data-off-label="No" data-on="success" data-off="danger">
                                                    <asp:CheckBox ID="CheckBox1" Checked='<%# Eval("IsClosed") %>' runat="server" />
                                                </div>
                                            </td>
                                            <td colspan="2">
                                                <asp:LinkButton ID="lnkBack" Width="40%" OnClick="lnkBack_Click"
                                                    runat="server" Text='<i style="color:White" class="fa fa-arrow-circle-left fa-fw"></i> Back'
                                                    class="btn btn-default btn-success btn-fw" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <!-- Ends a row inside panel body -->
                        </div>
                    </div>
                </ItemTemplate>
            </asp:FormView>
        </asp:Panel>
        <!-- Panel for Editing Employees in a FormView Ends -->
    </div>
    <!-- Display Panel and View Record Ends -->

    <!-- GridView to Display Daily Transactions -->
    <div id="divDisplayAccountDetails" class="table-responsive col-lg-7">
        <asp:GridView Visible="false" DataKeyNames="TransactionID" class="table table-striped table-bordered table-hover DataTable"
            ID="grdAccountDetails" DataSourceID="srcAccountDetails" runat="server" AutoGenerateColumns="false"
            OnDataBound="grdAccountDetails_DataBound">
            <EmptyDataTemplate>
                <h3>No Transactions made yet !</h3>
            </EmptyDataTemplate>
            <Columns>
                <%--TransactionID--%>
                <asp:TemplateField HeaderText="Transaction ID">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblTransactionID" Text='<%# Eval("TransactionID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <%--Transaction Date--%>
                <asp:TemplateField HeaderText="Transaction Date">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblTransactionDate" Text='<%# String.Format("{0:dd-MMM-yyyy}", Eval("TransactionDate")) %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <%--Amount--%>
                <asp:TemplateField HeaderText="Amount">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblAmount" Text='<%# String.Format("{0:#.##}", Eval("Amount")) %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <!-- GridView Ends..-->

    <!-- SqlDataSources -->
    <asp:SqlDataSource runat="server" ID="srcAccountDetails" ConnectionString='<%$ connectionStrings:DBCS %>'
        SelectCommand="spGetDailyTransactions" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter Name="AccountID" ControlID="grdAccounts" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="srcGetCustomerDetails" ConnectionString='<%$ connectionStrings:DBCS %>'
        SelectCommand="spGetAccounts" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter Name="AccountID" ControlID="grdAccounts" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="srcAccounts" ConnectionString='<%$ connectionStrings:DBCS %>'
        SelectCommand="spGetAccounts" SelectCommandType="StoredProcedure"
        UpdateCommand="spAccounts" UpdateCommandType="StoredProcedure" OnUpdated="srcAccounts_Updated"
        InsertCommand="spAccounts" InsertCommandType="StoredProcedure" OnInserted="srcAccounts_Inserted">
        <InsertParameters>
            <asp:ControlParameter ControlID="__Page" PropertyName="UserName" Name="UserName" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="__Page" PropertyName="UserName" Name="UserName" />
            <asp:ControlParameter ControlID="grdAccounts" Name="AccountID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="srcCustomers" ConnectionString='<%$ connectionStrings:DBCS %>'
        SelectCommand="Select * from Customers">
    </asp:SqlDataSource>
    <!-- SqlDataSources Ends -->

    <!-- Java Scripts -->
    <script type="text/javascript">
        function showInsert() {
            var divInsert = document.getElementById('divInsert');
            var divDisplay = document.getElementById('divDisplayAccounts');

            divInsert.style.display = 'block';
            divDisplay.style.display = 'none';
        }

        function showDisplay() {
            var divInsert = document.getElementById('divInsert');
            var divDisplay = document.getElementById('divDisplayAccounts');

            divInsert.style.display = 'none';
            divDisplay.style.display = 'block';
        }
    </script>
    <!-- Java Scripts Ends -->
</asp:Content>
