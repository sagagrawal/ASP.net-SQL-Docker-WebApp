<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true"
    CodeBehind="ChangePassword.aspx.cs" Inherits="PigmyPlus.WebForm6" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadingContent" runat="server">
    <span class="fa fa-pencil fa-fw"></span> Change Password
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ActionContent" runat="server">
    <!-- Dropdown Action Button -->
    <ul class="dropdown-menu pull-right" role="menu">
        <li><a href="Welcome.aspx"><span class="fa fa-home fa-lg"></span> Home </a></li>
    </ul>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-lg-6">
        <table style="width: 100%;">
            <tr>
                <td>
                    <div class="form-group">
                        <label>
                            Current Password
                        </label>
                        <asp:TextBox ID="txtCurrentPassword" runat="server"  TextMode="Password" />
                    </div>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="reqUserName" Text="*" runat="server"
                        ForeColor="Red" ControlToValidate="txtCurrentPassword" 
                        ErrorMessage="Enter Current Password" />
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <label>
                            Enter New Password
                        </label>
                        <asp:TextBox ID="txtNewPassword" placeholder="At Least 5 Characters" runat="server" TextMode="Password" />
                    </div>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="reqNewPassword" Text="*" runat="server" ForeColor="Red" ControlToValidate="txtNewPassword" ErrorMessage="Enter New Password" />
                    <%--<asp:CompareValidator ID="cmpNewPasswordLength" text="*" runat="server" ForeColor="Red" ControlToValidate="txtNewPassword" ErrorMessage="Password must contain at least 5 characters"/>--%>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <label>
                            Confirm New Password
                        </label>
                        <asp:TextBox ID="txtConfirmPassword" placeholder="At Least 5 Characters" runat="server" TextMode="Password" />
                    </div>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="reqConfirmPassword" Text="*" runat="server" Display="Dynamic"
                        ForeColor="Red" ControlToValidate="txtConfirmPassword" ErrorMessage="Enter Confirm Password" />
                    <asp:CompareValidator ID="cmpConfirmPassword" Text="*" runat="server" 
                        ForeColor="Red" ControlToValidate="txtConfirmPassword" ErrorMessage="Password Confirmation Mismatch"
                        ControlToCompare="txtNewPassword" Operator="Equal"  />
                </td>
            </tr>
        </table>
        <div class="form-group">
            <asp:Button ID="btnChangePassword" Text="Change Password" runat="server" OnClick="btnChangePassword_Click" />
        </div>
        <div class="form-group">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
            <asp:Label ID="lblMessage" runat="server" />
        </div>
    </div>
</asp:Content>