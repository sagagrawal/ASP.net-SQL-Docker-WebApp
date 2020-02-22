<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="DailyEntries.aspx.cs" Inherits="PigmyPlus.DailyEntries" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadingContent" runat="server">
    <span class="fa fa-th-large fa-fw"></span>&nbsp Manage Today's Entries.
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ActionContentsButtons" runat="server">
    <div class="btn-group">
        <asp:LinkButton ID="lnkRefresh" runat="server" Text='<i style="color:White" class="fa fa-refresh fa-lg"></i> Refresh' class="btn btn-primary btn-xs" OnClick="lnkRefresh_Click" />
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ActionContent" runat="server">
    <ul class="dropdown-menu pull-right" role="menu">
        <li><a href="DailyEntries.aspx"><span class="fa fa-refresh fa-fw fa-spin"></span>Reload Page </a></li>
        <li class="divider"></li>
        <li><a href="Welcome.aspx"><span class="fa fa-home fa-lg"></span> Home </a></li>
    </ul>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager runat="server" />
    <div class="col-lg-12">
        <div class="col-lg-6">
            <%-- FormView to Input Transaction Details --%>
            <asp:FormView ID="frmDailyEntries" runat="server" Width="100%" DefaultMode="Insert">
                <InsertItemTemplate>
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <span style="color: White" class="fa fa-smile-o fa-lg"></span>&nbsp New Transaction
                        </div>
                        <div class="panel-body">
                            <!-- Add 2 HTML Tables within a row inside panel body -->
                            <!-- Starts a row inside panel body -->
                            <div class="row">
                                <div class="col-lg-12" style='text-align: center'>
                                    <table style="width: 100%; text-align: left;">
                                        <%--AccNo--%>
                                        <tr>
                                            <td style="width: 30%">
                                                <asp:Label ID="lblAccNo" runat="server" Text="Account No"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox Enabled="false" runat="server" ID="txtAccNo" CssClass="form-control"
                                                    Height="30px" ToolTip="Enter Account No" placeholder="Enter Account No"></asp:TextBox>
                                                <asp:RequiredFieldValidator ErrorMessage="Enter Account No" Display="None" Text="*" ForeColor="Red" ValidationGroup="InsertGroup"
                                                    ControlToValidate="txtAccNo" runat="server" ID="reqAccNo"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <%-- TransactionDate --%>
                                        <tr>
                                            <td style="width: 30%">
                                                <asp:Label ID="lnlTransactionDate" runat="server" Text="Transaction Date"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox Enabled="false" runat="server" ID="txtTransactionDate" CssClass="form-control"
                                                    Height="30px" ToolTip="Transaction Date" placeholder="Choose Transaction Date"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <%-- Amount --%>
                                        <tr>
                                            <td style="width: 30%">
                                                <asp:Label ID="lblAmount" runat="server" Text="Amount"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox runat="server" ID="txtAmount" CssClass="form-control"
                                                    Height="30px" ToolTip="Enter Amount" placeholder="Enter Amount"></asp:TextBox>
                                                <asp:RequiredFieldValidator ErrorMessage="Enter Amount" Display="None" Text="*" ForeColor="Red" ValidationGroup="InsertGroup"
                                                    ControlToValidate="txtAmount" runat="server" ID="reqAmount"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <%-- Validation Summary --%>
                                        <tr>
                                            <td style="width: 30%"></td>
                                            <td>
                                                <asp:ValidationSummary runat="server" ID="ValidationSummaryMakeTransaction"
                                                    DisplayMode="BulletList" ValidationGroup="InsertGroup" ForeColor="Red" HeaderText="Errors" />
                                                <asp:Label ID="lblNotifyUser" Visible="false" Text="All the Active Account have been sucessfully Updated." ForeColor="Green"
                                                    Height="30px" Font-Bold="true" runat="server" />
                                            </td>
                                        </tr>
                                        <%--Buttons--%>
                                        <tr>
                                            <td style="width: 30%"></td>
                                            <td>
                                                <br />
                                                <asp:LinkButton ID="lnkSave" Width="45%" OnClick="lnkSave_Click" ValidationGroup="InsertGroup"
                                                    CausesValidation="True" runat="server" Text='<i style="color:White" class="fa fa-floppy-o fa-fw"></i> Save & Next'
                                                    class="btn btn-default btn-success btn-fw" />
                                                <asp:LinkButton ID="lnkSkip" Width="45%" OnClick="lnkSkip_Click" 
                                                    CausesValidation="false" runat="server" Text='<i style="color:White" class="fa fa-undo fa-fw"></i> Skip'
                                                    class="btn btn-default btn-success btn-fw" />
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
            <%-- FormView Ends --%>
        </div>
        <div class="col-lg-3 col-lg-offset-3">
            <asp:Label runat="server" Font-Bold="true" Font-Size="Large" ID="lblTotalCollectedAmount" CssClass="btn btn-block btn-primary"></asp:Label>
        </div>
    </div>

    <!-- GridView to Display Today's Transactions -->
    <div id="divDisplay" class="table-responsive col-lg-7">
        <asp:GridView DataKeyNames="TransactionID" class="table table-striped table-bordered table-hover DataTable"
            ID="grdTransactions" DataSourceID="srcTransactions" runat="server" AutoGenerateColumns="false"
            OnDataBound="grdTransactions_DataBound">
            <EmptyDataTemplate>
                <h3>No Transactions made yet on Current System Date!</h3>
            </EmptyDataTemplate>
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <div class="btn-group">
                            <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                                <span class="fa fa-bell fa-fw"></span><span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu pull-left" role="menu">
                                <li>
                                    <asp:LinkButton ID="lnkView" runat="server" Text='<i class="fa fa-eye fa-fw"></i> View Record'
                                        OnClick="lnkView_Click" CommandName="Select" ToolTip="View Details" /></li>
                                <li>
                                    <asp:LinkButton ID="lnkEditLink" runat="server"
                                        Text='<i class="fa fa-edit fa-fw"></i> Edit Transaction' OnClick="lnkEdit_Click"
                                        CommandName="Select" ToolTip="Edit Record" />
                                </li>
                                <li>
                                    <asp:LinkButton ID="lnkDeleteTransaction" runat="server" OnClientClick="return confirm('Are you sure you want delete this Transaction ?');"
                                        Text='<i class="fa fa-edit fa-fw"></i> Delete Transaction'
                                        CommandName="Delete" ToolTip="Delete Record" />
                                </li>
                            </ul>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
                <%--TransactionID--%>
                <asp:BoundField HeaderText="Transaction ID" DataField="TransactionID" />
                <%-- Account No --%>
                <asp:BoundField HeaderText="Account No" DataField="AccNo" />
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
                <asp:TemplateField HeaderText="Modified On">
                    <ItemTemplate>
                        <asp:Label Text='<%# String.Format("{0:dd-MMM-yyyy hh:mm tt}",  Eval("ModifiedOn")) %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>
    </div>
    <!-- GridView Ends..-->

    <!-- Edit Panel and View Record -->
    <div>
        <!-- Panel for Editing Transactions in a FormView -->
        <asp:Panel ID="EditPanel" runat="server" Visible="false">
            <asp:FormView ID="frmEditTransaction" runat="server" Width="100%" DataSourceID="srcTransactionsOperations" DefaultMode="Edit">
                <EmptyDataTemplate>
                    <h3>No Record Retrieved</h3>
                </EmptyDataTemplate>

                <EditItemTemplate>
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <span style="color: White" class="fa fa-smile-o fa-lg"></span>&nbsp Edit Transaction.
                        </div>
                        <div class="panel-body">
                            <!-- Add 2 HTML Tables within a row inside panel body -->
                            <!-- Starts a row inside panel body -->
                            <div class="row">
                                <div class="col-lg-6" style='text-align: center'>
                                    <table style="width: 100%; text-align: left;">
                                        <%-- TransactionID Invisible --%>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:Label Visible="false" ID="lblEditTransactionID" Text='<%# Bind("TransactionID") %>' runat="server" />
                                            </td>
                                        </tr>
                                        <!-- Account ID Invisible -->
                                        <tr>
                                            <td style="width: 35%"></td>
                                            <td>
                                                <asp:UpdatePanel runat="server">
                                                    <ContentTemplate>
                                                        <asp:Label Visible="false" ID="lblEditAccountID" runat="server" Text='<%# Bind("AccountID") %>'></asp:Label>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                        <!-- AccNo -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label ID="lblEditAccNo" runat="server" Text="Account No"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtEditAccNo" runat="server" CssClass="form-control" Height="30px"
                                                    Text='<%# Bind("AccNo") %>' Enabled="false" />
                                            </td>
                                            <td style="width: 5%">
                                                <asp:RequiredFieldValidator ID="reqEditAccNo" ValidationGroup="EditGroup" ControlToValidate="txtEditAccNo"
                                                    runat="server" Display="None" ErrorMessage="Enter Account No" Text="*" ForeColor="Red" />
                                            </td>
                                        </tr>
                                        <%-- Label Customer Name --%>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:UpdatePanel runat="server">
                                                    <ContentTemplate>
                                                        <asp:Label ID="lblCustomerName" Visible="false" runat="server" Font-Bold="true" ForeColor="Green" />
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                        <!-- Transaction Date -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label ID="lblTransactionDate" runat="server" Text="Transaction Date"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox CssClass="form-control DateInput" ID="txtEditTransactionDate" runat="server" Height="30px" Text='<%# Bind("TransactionDate", "{0:dd-MMM-yyyy}") %>' />
                                            </td>
                                            <td style="width: 5%">
                                                <asp:RequiredFieldValidator ID="reqEditTransactionDate" ValidationGroup="EditGroup" ControlToValidate="txtEditTransactionDate"
                                                    runat="server" Display="None" ErrorMessage="Choose Transaction Date" Text="*" ForeColor="Red" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                        </tr>
                                        <!-- Amount -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label ID="lblEditAmount" runat="server" Text="Amount (Rs)"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtEditAmount" runat="server" Height="30px" Text='<%# Bind("Amount", "{0:#.#}") %>' />
                                            </td>
                                            <td style="width: 5%">
                                                <asp:RequiredFieldValidator ID="reqEditAmount" ValidationGroup="EditGroup" ControlToValidate="txtEditAmount"
                                                    runat="server" Display="None" ErrorMessage="Enter Amount" Text="*" ForeColor="Red" />
                                            </td>
                                        </tr>
                                        <%-- Validation Summary --%>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:ValidationSummary runat="server" ForeColor="Red" DisplayMode="BulletList"
                                                    ValidationGroup="EditGroup" HeaderText="Errors" ID="ValidationSummaryEditTransaction" />
                                            </td>
                                        </tr>
                                        <!-- Buttons -->
                                        <tr>
                                            <td></td>
                                            <td colspan="2">
                                                <br />
                                                <asp:LinkButton ID="lnkUpdate" Width="30%" CommandName="Update" ValidationGroup="EditGroup"
                                                    CausesValidation="True" runat="server" Text='<i style="color:White" class="fa fa-floppy-o fa-fw"></i> Save'
                                                    class="btn btn-default btn-success btn-fw" />
                                                <asp:LinkButton ID="lnkCancel" Width="30%" OnClick="lnkBack_Click" CausesValidation="False" runat="server"
                                                    Text='<i style="color:White" class="fa fa-undo fa-fw"></i> Cancel' class="btn btn-default btn-success btn-fw" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-lg-6" style='text-align: center'>
                                    <table style="width: 100%; text-align: left;">
                                    </table>
                                </div>
                            </div>
                            <!-- Ends a row inside panel body -->
                        </div>
                    </div>
                </EditItemTemplate>

                <ItemTemplate>
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <span style="color: White" class="fa fa-smile-o fa-lg"></span>&nbsp;View Transaction Details.
                        </div>
                        <div class="panel-body">
                            <!-- Add 2 HTML Tables within a row inside panel body -->
                            <!-- Starts a row inside panel body -->
                            <div class="row">
                                <div class="col-lg-6" style='text-align: center'>
                                    <table style="width: 100%; text-align: left;">
                                        <!-- AccNo -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label Font-Bold="true" ID="lblAccNo" runat="server" Text="Acc No"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="txtAccNo" Font-Bold="true" Font-Size="Larger" runat="server" Height="30px" ForeColor="Red" Text='<%# Eval("AccNo") %>' />
                                            </td>
                                        </tr>
                                        <!-- Acc Opening Date -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label Font-Bold="true" ID="lblAccOpeningDate" runat="server" Text="Acc Opening Date"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="txtAccOpeningDate" runat="server" Height="30px" Text='<%# String.Format("{0:dd-MMM-yyyy}", Eval("OpeningDate")) %>' />
                                            </td>
                                        </tr>
                                        <!-- Customer Name -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label Font-Bold="true" ID="lblName" runat="server" Text="Customer Name"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="txtName" runat="server" Height="30px" Text='<%# Eval("Name") %>' />
                                            </td>
                                        </tr>
                                        <!-- Transaction Date -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label Font-Bold="true" ID="lblTransactionDate" runat="server" Text="Transaction Date"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="txtTransactionDate" runat="server" Height="30px" Text='<%# String.Format("{0:dd-MMM-yyyy}", Eval("TransactionDate")) %>' />
                                            </td>
                                        </tr>
                                        <!-- Amount -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label Font-Bold="true" ID="lblAmount" runat="server" Text="Amount"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="txtAmount" runat="server" Height="30px" Text='<%# "Rs. " + String.Format("{0:#.#}", Eval("Amount")) %>' />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-lg-5" style='text-align: center'>
                                    <table style="width: 100%; text-align: left;">
                                        <!-- Modified On -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label Font-Bold="true" ID="lblModifiedOn" runat="server" Text="Modified On"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="txtModifiedOn" runat="server" Height="30px" Text='<%# String.Format("{0:dd-MMM-yyyy}", Eval("ModifiedOn")) %>' />
                                            </td>
                                        </tr>
                                        <!-- Modified By -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label Font-Bold="true" ID="lblModifiedBy" runat="server" Text="Modified By"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="txtModifiedBy" runat="server" Height="30px" Text='<%# Eval("ModifiedBy") %>' />
                                            </td>
                                        </tr>
                                        <!-- Acc Closing Date -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label Font-Bold="true" ID="lblAccClosingDate" runat="server" Text="Acc Closing Date"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="txtAccClosingDate" runat="server" Height="30px" Text='<%# String.Format("{0:dd-MMM-yyyy}", Eval("ClosingDate")) %>' />
                                            </td>
                                        </tr>
                                        <!-- IsDiscontinued -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label Height="30px" Font-Bold="true" ID="lblIsClosed" runat="server" Text="Account Closing Status"></asp:Label>
                                            </td>
                                            <td style="width: 35%">
                                                <div class="make-switch switch-small" data-on-label='Yes' data-off-label="No" data-on="success" data-off="danger">
                                                    <asp:CheckBox ID="IsDiscontinued" Checked='<%# Eval("IsClosed") %>' runat="server" />
                                                </div>
                                            </td>
                                        </tr>
                                        <!-- Button -->
                                        <tr>
                                            <td></td>
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
        <!-- Panel for Editing Transactions in a FormView Ends -->
    </div>
    <!-- Edit Panel and View Record Ends -->

    <asp:SqlDataSource ID="srcTransactions" runat="server" ConnectionString='<%$ connectionStrings:DBCS %>'
        SelectCommand="spGetCurrentDateTransactions" SelectCommandType="StoredProcedure"
        DeleteCommand="Delete from DailyTransactions where TransactionID=@TransactionID"
        OnDeleted="srcTransactions_Deleted"></asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="srcTransactionsOperations" ConnectionString='<%$ connectionStrings:DBCS %>'
        SelectCommand="Select * from vwDailyTransactions where TransactionID=@TransactionID"
        UpdateCommand="Update DailyTransactions set AccountID=@AccountID, TransactionDate=@TransactionDate, Amount=@Amount, ModifiedOn=SYSDATETIME(), ModifiedBy=@UserName where TransactionID=@TransactionID"
        OnUpdated="srcTransactionsOperations_Updated">
        <SelectParameters>
            <asp:ControlParameter ControlID="grdTransactions" Name="TransactionID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="__Page" Name="UserName" PropertyName="UserName" />
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>
