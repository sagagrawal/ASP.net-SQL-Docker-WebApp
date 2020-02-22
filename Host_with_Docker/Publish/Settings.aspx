<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="PigmyPlus.Settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadingContent" runat="server">
    <span class="fa fa-gear fa-fw"></span>&nbsp Settings.
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ActionContentsButtons" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ActionContent" runat="server">
    <ul class="dropdown-menu pull-right" role="menu">
        <li><a href="Welcome.aspx"><span class="fa fa-home fa-lg"></span>Home </a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container col-lg-7 col-lg-offset-2">
        <asp:HyperLink style="text-align:left;" NavigateUrl="~/ChangePassword.aspx" CssClass="btn btn-block btn-default" ForeColor="Black" runat="server" Text='<span class="fa fa-pencil fa-fw"></span> Change Password '></asp:HyperLink>
        <asp:HyperLink style="text-align:left;" NavigateUrl="~/CustomizeCustomerRequirements.aspx" CssClass="btn btn-block btn-default" ForeColor="Black" runat="server" Text='<span class="fa fa-pencil fa-fw"></span> Customize Customer Requirements '></asp:HyperLink>
        <asp:HyperLink style="text-align:left;" NavigateUrl="~/CustomizeCustomerGrid.aspx" CssClass="btn btn-block btn-default" ForeColor="Black" runat="server" Text='<span class="fa fa-pencil fa-fw"></span> Customize Customer Grid Display Attributes '></asp:HyperLink>
    </div>
</asp:Content>
