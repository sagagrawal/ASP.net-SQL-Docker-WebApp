<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="Welcome.aspx.cs" Inherits="PigmyPlus.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadingContent" runat="server">
    <span class="fa fa-home fa-lg"></span> Welcome to Pigmy Plus Care Pro.
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ActionContent" runat="server">
        <ul class="dropdown-menu pull-right" role="menu">
            <li> <asp:LoginStatus ID="lsStatus" runat="server" LogoutText='<i class="fa fa-power-off fa-fw"></i>Logout'/> </li>
        </ul>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3> <span class="fa fa-user fa-fw"></span> Welcome <%= UserName %> </h3>
</asp:Content>