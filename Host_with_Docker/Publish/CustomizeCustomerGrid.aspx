<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="CustomizeCustomerGrid.aspx.cs" Inherits="PigmyPlus.CustomizeCustomerGrid" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadingContent" runat="server">
    <span class="fa fa-cogs fa-lg"></span>&nbsp Customize.
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ActionContentsButtons" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ActionContent" runat="server">
    <ul class="dropdown-menu pull-right" role="menu">
        <li><a href="Welcome.aspx"><span class="fa fa-home fa-lg"></span> Home </a></li>
    </ul>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <asp:FormView ID="frmVisibility" DataSourceID="srcCustomerCofiguration" Width="100%" runat="server"
        DefaultMode="Edit">
        <EditItemTemplate>
            <div class="col-lg-5 col-lg-offset-1">
                <table class="table">
                    <%-- Name --%>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" Font-Size="Larger" Text="Name"></asp:Label>
                        </td>
                        <td style="text-align: center">&nbsp;
                        </td>
                        <td style="text-align: center">
                            <div class="make-switch switch-small" style="width: 100px;" data-on-label='Show' data-off-label="Hide" data-on="success" data-off="warning">
                                <asp:CheckBox ID="CheckBox0" runat="server" Checked='<%# Bind("Name") %>' />
                            </div>
                        </td>
                    </tr>
                    <%-- Address --%>
                    <tr>
                        <td>
                            <asp:Label ID="Label2" runat="server" Font-Size="Larger" Text="Address"></asp:Label>
                        </td>
                        <td style="text-align: center">&nbsp;
                        </td>
                        <td style="text-align: center">
                            <div class="make-switch switch-small" style="width: 100px;" data-on-label='Show' data-off-label="Hide" data-on="success" data-off="warning">
                                <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Address") %>' />
                            </div>
                        </td>
                    </tr>
                    <%-- Phone No --%>
                    <tr>
                        <td>
                            <asp:Label ID="Label3" runat="server" Font-Size="Larger" Text="Phone No"></asp:Label>
                        </td>
                        <td style="text-align: center">&nbsp;
                        </td>
                        <td style="text-align: center">
                            <div class="make-switch switch-small" style="width: 100px;" data-on-label='Show' data-off-label="Hide" data-on="success" data-off="warning">
                                <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("PhoneNo") %>' />
                            </div>
                        </td>
                    </tr>
                    <%-- Mobile No --%>
                    <tr>
                        <td>
                            <asp:Label ID="Label4" runat="server" Font-Size="Larger" Text="Mobile No"></asp:Label>
                        </td>
                        <td style="text-align: center">&nbsp;
                        </td>
                        <td style="text-align: center">
                            <div class="make-switch switch-small" style="width: 100px;" data-on-label='Show' data-off-label="Hide" data-on="success" data-off="warning">
                                <asp:CheckBox ID="CheckBox3" runat="server" Checked='<%# Bind("MobileNo") %>' />
                            </div>
                        </td>
                    </tr>
                    <%-- EmailID --%>
                    <tr>
                        <td>
                            <asp:Label ID="Label5" runat="server" Font-Size="Larger" Text="Email ID"></asp:Label>
                        </td>
                        <td style="text-align: center">&nbsp;
                        </td>
                        <td style="text-align: center">
                            <div class="make-switch switch-small" style="width: 100px;" data-on-label='Show' data-off-label="Hide" data-on="success" data-off="warning">
                                <asp:CheckBox ID="CheckBox4" runat="server" Checked='<%# Bind("EmailID") %>' />
                            </div>
                        </td>
                    </tr>
                    <%-- Age --%>
                    <tr>
                        <td>
                            <asp:Label ID="Label6" runat="server" Font-Size="Larger" Text="Age"></asp:Label>
                        </td>
                        <td style="text-align: center">&nbsp;
                        </td>
                        <td style="text-align: center">
                            <div class="make-switch switch-small" style="width: 100px;" data-on-label='Show' data-off-label="Hide" data-on="success" data-off="warning">
                                <asp:CheckBox ID="CheckBox5" runat="server" Checked='<%# Bind("Age") %>' />
                            </div>
                        </td>
                    </tr>
                    <%-- DOB --%>
                    <tr>
                        <td>
                            <asp:Label ID="Label7" runat="server" Font-Size="Larger" Text="Date of Birth"></asp:Label>
                        </td>
                        <td style="text-align: center">&nbsp;
                        </td>
                        <td style="text-align: center">
                            <div class="make-switch switch-small" style="width: 100px;" data-on-label='Show' data-off-label="Hide" data-on="success" data-off="warning">
                                <asp:CheckBox ID="CheckBox6" runat="server" Checked='<%# Bind("DOB") %>' />
                            </div>
                        </td>
                    </tr>
                    <%-- UID --%>
                    <tr>
                        <td>
                            <asp:Label ID="Label8" runat="server" Font-Size="Larger" Text="Addhar Card No"></asp:Label>
                        </td>
                        <td style="text-align: center">&nbsp;
                        </td>
                        <td style="text-align: center">
                            <div class="make-switch switch-small" style="width: 100px;" data-on-label='Show' data-off-label="Hide" data-on="success" data-off="warning">
                                <asp:CheckBox ID="CheckBox7" runat="server" Checked='<%# Bind("CustomerUID") %>' />
                            </div>
                        </td>
                    </tr>
                    <%-- PanID --%>
                    <tr>
                        <td>
                            <asp:Label ID="Label9" runat="server" Font-Size="Larger" Text="Pan Card No"></asp:Label>
                        </td>
                        <td style="text-align: center">&nbsp;
                        </td>
                        <td style="text-align: center">
                            <div class="make-switch switch-small" style="width: 100px;" data-on-label='Show' data-off-label="Hide" data-on="success" data-off="warning">
                                <asp:CheckBox ID="CheckBox8" runat="server" Checked='<%# Bind("CustomerPanID") %>' />
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-lg-5">
                <table class="table">
                    <%-- ElectionID --%>
                    <tr>
                        <td>
                            <asp:Label ID="Label10" runat="server" Font-Size="Larger" Text="Election Card No"></asp:Label>
                        </td>
                        <td style="text-align: center">&nbsp;
                        </td>
                        <td style="text-align: center">
                            <div class="make-switch switch-small" style="width: 100px;" data-on-label='Show' data-off-label="Hide" data-on="success" data-off="warning">
                                <asp:CheckBox ID="CheckBox9" runat="server" Checked='<%# Bind("CustomerElectionID") %>' />
                            </div>
                        </td>
                    </tr>
                    <%-- Gender --%>
                    <tr>
                        <td>
                            <asp:Label ID="Label11" runat="server" Font-Size="Larger" Text="Gender"></asp:Label>
                        </td>
                        <td style="text-align: center">&nbsp;
                        </td>
                        <td style="text-align: center">
                            <div class="make-switch switch-small" style="width: 100px;" data-on-label='Show' data-off-label="Hide" data-on="success" data-off="warning">
                                <asp:CheckBox ID="CheckBox10" runat="server" Checked='<%# Bind("Gender") %>' />
                            </div>
                        </td>
                    </tr>
                    <%-- CreatedOn --%>
                    <tr>
                        <td>
                            <asp:Label ID="Label12" runat="server" Font-Size="Larger" Text="Created On"></asp:Label>
                        </td>
                        <td style="text-align: center">&nbsp;
                        </td>
                        <td style="text-align: center">
                            <div class="make-switch switch-small" style="width: 100px;" data-on-label='Show' data-off-label="Hide" data-on="success" data-off="warning">
                                <asp:CheckBox ID="CheckBox11" runat="server" Checked='<%# Bind("CreatedOn") %>' />
                            </div>
                        </td>
                    </tr>
                    <%-- ModifiedOn --%>
                    <tr>
                        <td>
                            <asp:Label ID="Label13" runat="server" Font-Size="Larger" Text="Modified On"></asp:Label>
                        </td>
                        <td style="text-align: center">&nbsp;
                        </td>
                        <td style="text-align: center">
                            <div class="make-switch switch-small" style="width: 100px;" data-on-label='Show' data-off-label="Hide" data-on="success" data-off="warning">
                                <asp:CheckBox ID="CheckBox12" runat="server" Checked='<%# Bind("ModifiedOn") %>' />
                            </div>
                        </td>
                    </tr>
                    <%-- IsDiscontinued --%>
                    <tr>
                        <td>
                            <asp:Label ID="Label14" runat="server" Font-Size="Larger" Text="Discontinued Status"></asp:Label>
                        </td>
                        <td style="text-align: center">&nbsp;
                        </td>
                        <td style="text-align: center">
                            <div class="make-switch switch-small" style="width: 100px;" data-on-label='Show' data-off-label="Hide" data-on="success" data-off="warning">
                                <asp:CheckBox ID="CheckBox13" runat="server" Checked='<%# Bind("IsDiscontinued") %>' />
                            </div>
                        </td>
                    </tr>
                    <%-- DiscontinuedOn --%>
                    <tr>
                        <td>
                            <asp:Label ID="Label15" runat="server" Font-Size="Larger" Text="Discontinued On"></asp:Label>
                        </td>
                        <td style="text-align: center">&nbsp;
                        </td>
                        <td style="text-align: center">
                            <div class="make-switch switch-small" style="width: 100px;" data-on-label='Show' data-off-label="Hide" data-on="success" data-off="warning">
                                <asp:CheckBox ID="CheckBox14" runat="server" Checked='<%# Bind("DiscontinuedOn") %>' />
                            </div>
                        </td>
                    </tr>
                    <%-- AccountsLinked --%>
                    <tr>
                        <td>
                            <asp:Label ID="Label16" runat="server" Font-Size="Larger" Text="No of Accounts Linked"></asp:Label>
                        </td>
                        <td style="text-align: center">&nbsp;
                        </td>
                        <td style="text-align: center">
                            <div class="make-switch switch-small" style="width: 100px;" data-on-label='Show' data-off-label="Hide" data-on="success" data-off="warning">
                                <asp:CheckBox ID="CheckBox15" runat="server" Checked='<%# Bind("NoOfAccountsLinked") %>' />
                            </div>
                        </td>
                    </tr>
                    <%-- Buttons --%>
                    <tr>
                    <td colspan="5" style="text-align: right">
                        <br />
                         <asp:LinkButton ID="lnkSave" Width="160px" CommandName="Update" CausesValidation="True"
                        runat="server" Text='<i style="color:White" class="fa fa-floppy-o fa-fw"></i> Update'
                        class="btn btn-default btn-success btn-fw" />
                    <asp:LinkButton ID="lnkCancel" Width="160px" CommandName="Cancel" CausesValidation="False"
                        runat="server" Text='<i style="color:White" class="fa fa-undo fa-fw"></i> Cancel'
                        class="btn btn-default btn-success btn-fw" OnClick="lnkCancel_Click"/>
                    </td>
                </tr>
                </table>
            </div>
        </EditItemTemplate>
    </asp:FormView>
    <asp:Label runat="server" ForeColor="Green" Font-Bold="true" Visible="false" Font-Size="Larger" ID="lblSettingsUpdated" Text="Settings Updated Successfully!"></asp:Label>
    <br />
    <asp:HyperLink runat="server" NavigateUrl="~/Welcome.aspx" ID="hlHomePage" Visible="false" Text="Click Here"></asp:HyperLink>
    <asp:Label runat="server" ID="lblHomePageText" Visible="false" Text="to go to Home Page"></asp:Label>

    <asp:SqlDataSource runat="server" ID="srcCustomerCofiguration" ConnectionString='<%$ connectionStrings:DBCS %>'
        SelectCommand="Select * from CustomerConfigurations"
        UpdateCommand="spGridDisplayConfig" UpdateCommandType="StoredProcedure" OnUpdated="srcCustomerCofiguration_Updated">
    </asp:SqlDataSource>
</asp:Content>
