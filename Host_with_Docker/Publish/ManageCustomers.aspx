<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="ManageCustomers.aspx.cs" Inherits="PigmyPlus.ManageCustomers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadingContent" runat="server">
    <span class="fa fa-th-large fa-fw"></span>&nbsp Manage Customers.
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
        <li><a href="#" data-toggle="modal" data-target="#myModal" onclick="JavaScript:showInsert();"><span class="fa fa-smile-o fa-fw"></span>New Customer</a> </li>
        <li>
            <asp:LinkButton Visible="false" runat="server" ID="lnkFilter" OnClick="lnkFilter_Click"><span class="fa fa-filter fa-fw"></span>Filter </asp:LinkButton></li>
        <li><a href="ManageCustomers.aspx"><span class="fa fa-refresh fa-fw fa-spin"></span>Reload Page </a></li>
        <li class="divider"></li>
        <li><a href="Welcome.aspx"><span class="fa fa-home fa-lg"></span>Home </a></li>
    </ul>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        #divInsert {
            display: none;
        }

        #divDisplay {
            display: block;
        }
    </style>
    <!-- GridView to Display Customers -->
    <div id="divDisplay" class="table-responsive">
        <asp:GridView DataKeyNames="CustomerID" class="table table-striped table-bordered table-hover DataTable"
            ID="grdCustomers" DataSourceID="srcgrdCustomers" runat="server" AutoGenerateColumns="false"
            OnDataBound="grdCustomers_DataBound">
            <EmptyDataTemplate>
                <h3>No Customers Found!</h3>
            </EmptyDataTemplate>
            <Columns>
                <%-- Customer ID --%>
                <asp:TemplateField Visible="false">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblCustomerID" Text='<%# Eval("CustomerID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <%-- Name --%>
                <asp:TemplateField HeaderText="Name">
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
                                        Text='<i class="fa fa-edit fa-fw"></i> Edit Customer' OnClick="lnkEditLink_Click"
                                        CommandName="Select" ToolTip="Edit Record" />
                                </li>
                            </ul>
                        </div>
                        &nbsp;
                        <asp:Label runat="server" ID="lblName" Text='<%# Eval("Name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <%-- No of Accounts Linked --%>
                <asp:TemplateField HeaderText="No. of <br/>Accounts Linked">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblNoOfAccountsLinked" Text='<%# GetNoOfLinkedAccounts(Eval("CustomerID").ToString()) %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <%-- Address --%>
                <asp:BoundField HeaderText="Address" Visible="false" DataField="Address" ReadOnly="true" />
                <%-- PhoneNo --%>
                <asp:BoundField HeaderText="Phone No" Visible="false" NullDisplayText="-" DataField="PhoneNo" ReadOnly="true" />
                <%-- MobileNo --%>
                <asp:BoundField HeaderText="Mobile No" Visible="false" NullDisplayText="-" DataField="MobileNo" ReadOnly="true" />
                <%-- Age --%>
                <asp:BoundField HeaderText="Age" Visible="false" NullDisplayText="-" DataField="Age" ReadOnly="true" />
                <%-- DOB --%>
                <asp:TemplateField Visible="false" HeaderText="Date of Birth">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0:dd-MMM-yyyy}", Eval("DOB")) %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <%-- UID --%>
                <asp:BoundField HeaderText="Aadhar-card No" NullDisplayText="-" DataField="CustomerUID" ReadOnly="true" />
                <%-- PanID --%>
                <asp:BoundField HeaderText="Pan-card No" NullDisplayText="-" DataField="CustomerPanID" ReadOnly="true" />
                <%-- ElectionID --%>
                <asp:BoundField HeaderText="Election-card No" NullDisplayText="-" DataField="CustomerElectionID" ReadOnly="true" />
                <%-- Gender --%>
                <asp:BoundField HeaderText="Gender" DataField="Gender" ReadOnly="true" />
                <%-- CreatedOn --%>
                <asp:TemplateField HeaderText="Created On">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0:dd-MMM-yyyy h:m tt}", Eval("CreatedOn")) %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <%-- ModifiedOn --%>
                <asp:TemplateField HeaderText="Modified On">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0:dd-MMM-yyyy h:m tt}", Eval("ModifiedOn")) %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <%-- IsDiscontinued --%>
                <asp:TemplateField HeaderText="Discontinue">
                    <ItemTemplate>
                        <div class="make-switch switch-small" data-on-label='Yes' data-off-label="No" data-on="success" data-off="danger">
                            <asp:CheckBox ID="IsDiscontinued" Checked='<%# Eval("IsDiscontinued") %>' runat="server" />
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
                <%-- Discontinued On --%>
                <asp:TemplateField Visible="false" HeaderText="Discontinued On">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# String.Format("{0:dd-MMM-yyyy h:m tt}", Eval("DiscontinuedOn")) %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <!-- GridView Ends..-->

    <!-- Edit Panel and View Record -->
    <div>
        <!-- Panel for Editing Customers in a FormView -->
        <asp:Panel ID="EditPanel" runat="server" Visible="false">
            <asp:FormView ID="frmEditCustomer" runat="server" Width="100%" DataSourceID="srcCustomers" DefaultMode="Edit">
                <EmptyDataTemplate>
                    <h3>No Record Retrieved</h3>
                </EmptyDataTemplate>

                <EditItemTemplate>
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <span style="color: White" class="fa fa-smile-o fa-lg"></span>&nbsp Edit Customer.
                        </div>
                        <div class="panel-body">
                            <!-- Add 2 HTML Tables within a row inside panel body -->
                            <!-- Starts a row inside panel body -->
                            <div class="row">
                                <div class="col-lg-6" style='text-align: center'>
                                    <table style="width: 100%; text-align: left;">
                                        <!-- Name -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label ID="lblEditName" runat="server" Text="Customer Name"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtEditName" runat="server" Height="30px"
                                                    Text='<%# Bind("Name") %>' />
                                            </td>
                                            <td style="width: 5%">
                                                <asp:RequiredFieldValidator ID="reqEditName" ValidationGroup="EditGroup" ControlToValidate="txtEditName"
                                                    runat="server" Display="Dynamic" ErrorMessage="Enter Customer Name" Text="*" ForeColor="Red" />
                                            </td>
                                        </tr>
                                        <!-- Address -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label ID="lblEditAddress" runat="server" Text="Address"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtEditAddress" runat="server" Height="30px"
                                                    Text='<%# Bind("Address") %>' />
                                            </td>
                                            <td style="width: 5%">
                                                <asp:RequiredFieldValidator ID="reqEditAddress" ValidationGroup="EditGroup" ControlToValidate="txtEditAddress"
                                                    runat="server" Display="Dynamic" ErrorMessage="Enter Customer Address" Text="*" ForeColor="Red" />
                                            </td>
                                        </tr>
                                        <!-- PhoneNo -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label ID="lblEditPhoneNo" runat="server" Text="Phone No"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtEditPhoneNo" runat="server" Height="30px"
                                                    Text='<%# Bind("PhoneNo") %>' />
                                            </td>
                                            <td style="width: 5%"></td>
                                        </tr>
                                        <!-- MobileNo -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label ID="lblEditMobileNo" runat="server" Text="Mobile No"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtEditMobileNo" runat="server" Height="30px"
                                                    Text='<%# Bind("MobileNo") %>' />
                                            </td>
                                            <td style="width: 5%"></td>
                                        </tr>
                                        <!-- EmailID -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label ID="lblEditEmailID" runat="server" Text="Email ID"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtEditEmailID" runat="server" TextMode="Email" Height="30px"
                                                    Text='<%# Bind("EmailID") %>' />
                                            </td>
                                            <td style="width: 5%"></td>
                                        </tr>
                                        <!-- Age -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label ID="lblEditAge" runat="server" Text="Age"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtEditAge" runat="server" Height="30px"
                                                    Text='<%# Bind("Age") %>' />
                                            </td>
                                            <td style="width: 5%"></td>
                                        </tr>
                                        <!-- DOB -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label ID="lblEditDateofBirth" runat="server" Text="Date of Birth"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtEditDateofBirth" runat="server" Height="30px" CssClass="DateInput form-control"
                                                    Text='<%# Bind("DOB", "{0:dd-MMM-yyyy}") %>' />
                                            </td>
                                            <td style="width: 5%"></td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-lg-6" style='text-align: center'>
                                    <table style="width: 100%; text-align: left;">
                                        <!-- Aaddhar Card No -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label ID="lblEditUID" runat="server" Text="Aadhar Card No"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtEditUID" runat="server" Height="30px"
                                                    Text='<%# Bind("CustomerUID") %>' />
                                            </td>
                                            <td style="width: 5%"></td>
                                        </tr>
                                        <!-- Pan ID -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label ID="lblEditPanID" runat="server" Text="Pan Card No"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtEditPanID" runat="server" Height="30px"
                                                    Text='<%# Bind("CustomerPanID") %>' />
                                            </td>
                                            <td style="width: 5%"></td>
                                        </tr>
                                        <!-- Election ID -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label ID="lblEditElectionID" runat="server" Text="Election Card No"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtEditElectionID" runat="server" Height="30px"
                                                    Text='<%# Bind("CustomerElectionID") %>' />
                                            </td>
                                            <td style="width: 5%"></td>
                                        </tr>
                                        <!-- Gender -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label ID="lblEditGender" runat="server" Text="Gender"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlEditGender" SelectedValue='<%# Bind("Gender") %>' Height="30px" Width="100%">
                                                    <asp:ListItem Text="Select Gender" Value="-1" Selected="True"></asp:ListItem>
                                                    <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                                                    <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                                                    <asp:ListItem Text="Not Available" Value="Not Available"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 5%">
                                                <asp:RequiredFieldValidator InitialValue="-1" ID="reqEditGender" ValidationGroup="EditGroup" ControlToValidate="ddlEditGender"
                                                    runat="server" Display="Dynamic" ErrorMessage="Select Gender" Text="*" ForeColor="Red" />
                                            </td>
                                        </tr>
                                        <!-- IsDisContinued -->
                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:CheckBox Text="Discontinue" runat="server" ID="cbDiscontinue" Checked='<%# Bind("IsDiscontinued") %>' />
                                            </td>
                                        </tr>
                                        <!-- Buttons -->
                                        <tr>
                                            <td></td>
                                            <td colspan="2">
                                                <br />
                                                <asp:LinkButton ID="lnkUpdate" Width="30%" CommandName="Update" ValidationGroup="EditGroup"
                                                    CausesValidation="True" OnClick="lnkSave_Click" runat="server" Text='<i style="color:White" class="fa fa-floppy-o fa-fw"></i> Save'
                                                    class="btn btn-default btn-success btn-fw" />
                                                <asp:LinkButton ID="lnkCancel" Width="30%" OnClick="lnkCancel_Click" CausesValidation="False" runat="server"
                                                    Text='<i style="color:White" class="fa fa-undo fa-fw"></i> Cancel' class="btn btn-default btn-success btn-fw" />
                                            </td>
                                        </tr>
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
                            <span style="color: White" class="fa fa-smile-o fa-lg"></span>&nbsp;View Customer Data.
                        </div>
                        <div class="panel-body">
                            <!-- Add 2 HTML Tables within a row inside panel body -->
                            <!-- Starts a row inside panel body -->
                            <div class="row">
                                <div class="col-lg-6" style='text-align: center'>
                                    <table style="width: 100%; text-align: left;">
                                        <!-- Name -->
                                        <tr>
                                            <td style="width: 35%">
                                                <asp:Label Font-Bold="true" ID="lblName" runat="server" Text="Customer Name"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="txtName" runat="server" Height="30px" Text='<%# Eval("Name") %>' />
                                            </td>
                                        </tr>
                                        <!-- Address -->
                                        <tr style="display: none">
                                            <td style="width: 35%">
                                                <asp:Label Font-Bold="true" ID="lblAddress" runat="server" Text="Address"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="txtAddress" runat="server" Height="30px" ReadOnly="true" Text='<%# Eval("Address") %>' />
                                            </td>
                                        </tr>
                                        <!-- PhoneNo -->
                                        <tr>
                                            <td>
                                                <asp:Label Font-Bold="true" ID="lblPhoneNo" runat="server" Text="Phone No"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="txtPhoneNo" runat="server" Height="30px" Text='<%# Eval("PhoneNo") %>' />
                                            </td>
                                        </tr>
                                        <!-- MobileNo -->
                                        <tr>
                                            <td>
                                                <asp:Label Font-Bold="true" ID="lblMobileNo" runat="server" Text="Mobile No"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="txtMobileNo" runat="server" Height="30px" Text='<%# Eval("MobileNo") %>' />
                                            </td>
                                        </tr>
                                        <!-- EmailID -->
                                        <tr>
                                            <td>
                                                <asp:Label Font-Bold="true" ID="lblEmailID" runat="server" Text="Email ID"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="txtEmailID" Width="100%" Text='<%# Eval("EmailID") %>' Height="30px" runat="server" />
                                            </td>
                                        </tr>
                                        <!-- Age -->
                                        <tr>
                                            <td>
                                                <asp:Label Font-Bold="true" ID="lblAge" runat="server" Text="Age"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="txtAge" runat="server" Height="30px" Text='<%# Eval("Age") %>' />
                                            </td>
                                        </tr>
                                        <!-- DOB -->
                                        <tr>
                                            <td>
                                                <asp:Label Font-Bold="true" ID="lblDOB" runat="server" Text="Date of Birth"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="txtDOB" runat="server" Height="30px" Text='<%# String.Format("{0:dd-MMM-yyyy}", Eval("DOB")) %>' />
                                            </td>
                                        </tr>
                                        <!-- UID -->
                                        <tr>
                                            <td>
                                                <asp:Label Font-Bold="true" ID="lblUID" runat="server" Text="Aadhar Card No"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="txtUID" runat="server" Height="30px" Text='<%# Eval("CustomerUID") %>' />
                                            </td>
                                        </tr>
                                        <!-- Pan ID -->
                                        <tr>
                                            <td>
                                                <asp:Label Font-Bold="true" ID="lblPanID" runat="server" Text="Pan Card No"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="txtPanID" Width="100%" Text='<%# Eval("CustomerPanID") %>' Height="30px" runat="server" />
                                            </td>
                                        </tr>
                                        <!-- Election ID -->
                                        <tr>
                                            <td>
                                                <asp:Label Font-Bold="true" ID="lblElectionID" runat="server" Text="Election card No"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="txtElectionID" runat="server" Height="30px" Text='<%# Eval("CustomerElectionID") %>' />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-lg-5" style='text-align: center'>
                                    <table style="width: 100%; text-align: left;">
                                        <!-- Gender -->
                                        <tr>
                                            <td>
                                                <asp:Label Font-Bold="true" ID="lblGender" runat="server" Text="Gender"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="txtGender" runat="server" Height="30px" Text='<%# Eval("Gender") %>' />
                                            </td>
                                        </tr>
                                        <!-- CreatedBy -->
                                        <tr>
                                            <td>
                                                <asp:Label Font-Bold="true" ID="lblCreatedBy" runat="server" Text="Created By"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="txtCreatedBy" runat="server" Height="30px" Text='<%# Eval("CreatedBy") %>' />
                                            </td>
                                        </tr>
                                        <!-- CreatedOn -->
                                        <tr>
                                            <td>
                                                <asp:Label Font-Bold="true" ID="lblCreatedOn" runat="server" Text="Created On"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="txtCreatedOn" runat="server" Height="30px" Text='<%# Eval("CreatedOn", "{0:dd-MMM-yyyy h:m tt}") %>' />
                                            </td>
                                        </tr>
                                        <!-- ModifiedBy -->
                                        <tr>
                                            <td>
                                                <asp:Label Font-Bold="true" ID="lblModifiedBy" runat="server" Text="Modified By"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="txtModifiedBy" runat="server" Height="30px" Text='<%# Eval("ModifiedBy") %>' />
                                            </td>
                                        </tr>
                                        <!-- ModifiedOn -->
                                        <tr>
                                            <td>
                                                <asp:Label Font-Bold="true" ID="lblModifiedOn" runat="server" Text="Modified On"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="txtModifiedOn" runat="server" Height="30px" Text='<%# Eval("ModifiedOn", "{0:dd-MMM-yyyy h:m tt}") %>' />
                                            </td>
                                        </tr>
                                        <!-- IsDiscontinued -->
                                        <tr>
                                            <td>
                                                <asp:Label Height="30px" Font-Bold="true" ID="lblIsDiscontinued" runat="server" Text="IsDiscontinued"></asp:Label>
                                            </td>
                                            <td>
                                                <div class="make-switch switch-small" data-on-label='Yes' data-off-label="No" data-on="success" data-off="danger">
                                                    <asp:CheckBox ID="IsDiscontinued" Checked='<%# Eval("IsDiscontinued") %>' runat="server" />
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
        <!-- Panel for Editing Employees in a FormView Ends -->
    </div>
    <!-- Edit Panel and View Record Ends -->

    <!-- /New Customer modal -->
    <div id="divInsert">
        <asp:FormView ID="frmCustomer" runat="server" Width="100%" DataSourceID="srcCustomers" DefaultMode="Insert">
            <InsertItemTemplate>
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <span style="color: White" class="fa fa-smile-o fa-lg"></span>&nbsp Register New Customer.
                    </div>
                    <div class="panel-body">
                        <!-- Add 2 HTML Tables within a row inside panel body -->
                        <!-- Starts a row inside panel body -->
                        <div class="row">
                            <div class="col-lg-6" style='text-align: center'>
                                <table style="width: 100%; text-align: left;">
                                    <!-- Name -->
                                    <tr>
                                        <td style="width: 35%">
                                            <asp:Label ID="lblName" runat="server" Text="Customer Name"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtName" runat="server" Height="30px"
                                                Text='<%# Bind("Name") %>' />
                                        </td>
                                        <td style="width: 5%">
                                            <asp:RequiredFieldValidator ID="reqName" ValidationGroup="InsertGroup" ControlToValidate="txtName"
                                                runat="server" Enabled='<%# GetRequired("IsNameRequired") %>' Display="None" ErrorMessage="Enter Name" Text="*" ForeColor="Red" />
                                        </td>
                                    </tr>
                                    <!-- Address -->
                                    <tr>
                                        <td style="width: 35%">
                                            <asp:Label ID="lblAddress" runat="server" Text="Address"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtAddress" runat="server" Height="30px"
                                                Text='<%# Bind("Address") %>' />
                                        </td>
                                        <td style="width: 5%">
                                            <asp:RequiredFieldValidator ID="reqAddress" ValidationGroup="InsertGroup" ControlToValidate="txtAddress"
                                                runat="server" Enabled='<%# GetRequired("IsAddressRequired") %>' Display="None" ErrorMessage="Enter Address" Text="*" ForeColor="Red" />
                                        </td>
                                    </tr>
                                    <!-- PhoneNo -->
                                    <tr>
                                        <td style="width: 35%">
                                            <asp:Label ID="lblPhoneNo" runat="server" Text="Phone No"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPhoneNo" runat="server" Height="30px"
                                                Text='<%# Bind("PhoneNo") %>' />
                                        </td>
                                        <td style="width: 5%">
                                            <asp:RequiredFieldValidator ID="reqPhoneNo" ValidationGroup="InsertGroup" ControlToValidate="txtPhoneNo"
                                                runat="server" Enabled='<%# GetRequired("IsPhoneNoRequired") %>' Display="None" ErrorMessage="Enter Phone No" Text="*" ForeColor="Red" />
                                        </td>
                                    </tr>
                                    <!-- MobileNo -->
                                    <tr>
                                        <td style="width: 35%">
                                            <asp:Label ID="lblMobileNo" runat="server" Text="Mobile No"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtMobileNo" runat="server" Height="30px"
                                                Text='<%# Bind("MobileNo") %>' />
                                        </td>
                                        <td style="width: 5%">
                                            <asp:RequiredFieldValidator ID="reqMobileNo" ValidationGroup="InsertGroup" ControlToValidate="txtMobileNo"
                                                runat="server" Enabled='<%# GetRequired("IsMobileNoRequired") %>' Display="None" ErrorMessage="Enter Mobile No" Text="*" ForeColor="Red" />
                                        </td>
                                    </tr>
                                    <!-- EmailID -->
                                    <tr>
                                        <td style="width: 35%">
                                            <asp:Label ID="lblEmailID" runat="server" Text="Email ID"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtEmailID" runat="server" TextMode="Email" Height="30px"
                                                Text='<%# Bind("EmailID") %>' />
                                        </td>
                                        <td style="width: 5%">
                                            <asp:RequiredFieldValidator ID="reqEmailID" ValidationGroup="InsertGroup" ControlToValidate="txtEmailID"
                                                runat="server" Enabled='<%# GetRequired("IsEmailIDRequired") %>' Display="None" ErrorMessage="Enter Email ID" Text="*" ForeColor="Red" />
                                        </td>
                                    </tr>
                                    <!-- Age -->
                                    <tr>
                                        <td style="width: 35%">
                                            <asp:Label ID="lblAge" runat="server" Text="Age"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtAge" runat="server" Height="30px"
                                                Text='<%# Bind("Age") %>' />
                                        </td>
                                        <td style="width: 5%">
                                            <asp:RequiredFieldValidator ID="reqAge" ValidationGroup="InsertGroup" ControlToValidate="txtAge"
                                                runat="server" Enabled='<%# GetRequired("IsAgeRequired") %>' Display="None" ErrorMessage="Enter Age" Text="*" ForeColor="Red" />
                                        </td>
                                    </tr>
                                    <!-- DOB -->
                                    <tr>
                                        <td style="width: 35%">
                                            <asp:Label ID="lblDateofBirth" runat="server" Text="Date of Birth"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtDateofBirth" runat="server" Height="30px" CssClass="DateInput form-control"
                                                Text='<%# Bind("DOB") %>' />
                                        </td>
                                        <td style="width: 5%">
                                            <asp:RequiredFieldValidator ID="reqDOB" ValidationGroup="InsertGroup" ControlToValidate="txtDateofBirth"
                                                runat="server" Enabled='<%# GetRequired("IsDOBRequired") %>' Display="None" ErrorMessage="Choose Date of Birth" Text="*" ForeColor="Red" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-lg-6" style='text-align: center'>
                                <table style="width: 100%; text-align: left;">
                                    <!-- Aaddhar Card No -->
                                    <tr>
                                        <td style="width: 35%">
                                            <asp:Label ID="lblUID" runat="server" Text="Aadhar Card No"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtUID" runat="server" Height="30px"
                                                Text='<%# Bind("CustomerUID") %>' />
                                        </td>
                                        <td style="width: 5%">
                                            <asp:RequiredFieldValidator ID="reqUID" ValidationGroup="InsertGroup" ControlToValidate="txtUID"
                                                runat="server" Enabled='<%# GetRequired("IsCustomerUIDRequired") %>' Display="None" ErrorMessage="Enter Addhar Card No" Text="*" ForeColor="Red" />
                                        </td>
                                    </tr>
                                    <!-- Pan ID -->
                                    <tr>
                                        <td style="width: 35%">
                                            <asp:Label ID="lblPanID" runat="server" Text="Pan Card No"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPanID" runat="server" Height="30px"
                                                Text='<%# Bind("CustomerPanID") %>' />
                                        </td>
                                        <td style="width: 5%">
                                            <asp:RequiredFieldValidator ID="reqPanID" ValidationGroup="InsertGroup" ControlToValidate="txtPanID"
                                                runat="server" Enabled='<%# GetRequired("IsCustomerPanIDRequired") %>' Display="None" ErrorMessage="Enter Pan Card No" Text="*" ForeColor="Red" />
                                        </td>
                                    </tr>
                                    <!-- Election ID -->
                                    <tr>
                                        <td style="width: 35%">
                                            <asp:Label ID="lblElectionID" runat="server" Text="Election Card No"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtElectionID" runat="server" Height="30px"
                                                Text='<%# Bind("CustomerElectionID") %>' />
                                        </td>
                                        <td style="width: 5%">
                                            <asp:RequiredFieldValidator ID="reqElectionID" ValidationGroup="InsertGroup" ControlToValidate="txtElectionID"
                                                runat="server" Enabled='<%# GetRequired("IsCustomerElectionIDRequired") %>' Display="None" ErrorMessage="Enter Election Card No" Text="*" ForeColor="Red" />

                                            <asp:CustomValidator runat="server" ID="reqID" Display="None" ErrorMessage="Enter PanID or AadharID or ElectionID"
                                                ForeColor="Red" ControlToValidate="txtElectionID" ValidationGroup="InsertGroup"></asp:CustomValidator>
                                        </td>
                                    </tr>
                                    <!-- Gender -->
                                    <tr>
                                        <td style="width: 35%">
                                            <asp:Label ID="lblGender" runat="server" Text="Gender"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="ddlGender" SelectedValue='<%# Bind("Gender") %>' Height="30px" Width="100%">
                                                <asp:ListItem Text="Select Gender" Value="-1" Selected="True"></asp:ListItem>
                                                <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                                                <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                                                <asp:ListItem Text="Not Available" Value="Not Available"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 5%">
                                            <asp:RequiredFieldValidator Enabled='<%# GetRequired("IsGenderRequired") %>' InitialValue="-1" ID="reqGender" ValidationGroup="InsertGroup" ControlToValidate="ddlGender"
                                                runat="server" Display="None" ErrorMessage="Select Gender" Text="*" ForeColor="Red" />
                                        </td>
                                    </tr>
                                    <!--Validation Summary..-->
                                    <tr>
                                        <td></td>
                                        <td>
                                            <asp:ValidationSummary HeaderText="Errors" runat="server" DisplayMode="BulletList" ID="vgInsertGroup" ValidationGroup="InsertGroup" ForeColor="Red" />
                                        </td>
                                    </tr>
                                    <!-- Buttons -->
                                    <tr>
                                        <td></td>
                                        <td colspan="2">
                                            <br />
                                            <asp:LinkButton ID="lnkSave" Width="30%" CommandName="Insert" ValidationGroup="InsertGroup"
                                                CausesValidation="True" runat="server" Text='<i style="color:White" class="fa fa-floppy-o fa-fw"></i> Save'
                                                class="btn btn-default btn-success btn-fw" OnClick="lnkSave_Click" />

                                            <button type="button" style="width: 30%" class="btn btn-default btn-success btn-fw" onclick="JavaScript:showDisplay();">
                                                <span style="color: White" class="fa fa-undo fa-fw"></span>Close
                                            </button>
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
    <!-- /New Customer modal ends -->

    <asp:SqlDataSource runat="server" ID="srcCustomers" ConnectionString='<%$ connectionStrings:DBCS %>'
        SelectCommand="spGetCustomers" SelectCommandType="StoredProcedure"
        InsertCommand="spCustomers" InsertCommandType="StoredProcedure" OnInserted="srcCustomers_Inserted"
        UpdateCommand="spCustomers" UpdateCommandType="StoredProcedure" OnUpdated="srcCustomers_Updated">
        <InsertParameters>
            <asp:ControlParameter Name="UserName" ControlID="__Page" PropertyName="UserName" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter Name="CustomerID" ControlID="grdCustomers" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter Name="CustomerID" ControlID="grdCustomers" Type="Int32" />
            <asp:ControlParameter Name="UserName" ControlID="__Page" PropertyName="UserName" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="srcgrdCustomers" ConnectionString='<%$ connectionStrings:DBCS %>'
        SelectCommand="spGetCustomers" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

    <script type="text/javascript">
        function showInsert() {
            var divInsert = document.getElementById('divInsert');
            var divDisplay = document.getElementById('divDisplay');

            divInsert.style.display = 'block';
            divDisplay.style.display = 'none';
        }

        function showDisplay() {
            var divInsert = document.getElementById('divInsert');
            var divDisplay = document.getElementById('divDisplay');

            divInsert.style.display = 'none';
            divDisplay.style.display = 'block';
        }
    </script>
</asp:Content>
