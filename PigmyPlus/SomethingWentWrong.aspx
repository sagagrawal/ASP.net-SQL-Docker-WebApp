<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="SomethingWentWrong.aspx.cs" Inherits="PigmyPlus.SomethingWentWrong" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadingContent" runat="server">
    <span class="fa fa-frown-o fa-lg"></span> Access Denied
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ActionContentsButtons" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ActionContent" runat="server">
    <ul class="dropdown-menu pull-right" role="menu">
        <li><a href="Welcome.aspx"><span class="fa fa-home fa-lg"></span> Home </a></li>
        <li class="divider"></li>
        <li>
            <asp:LoginStatus ID="LoginStatus1" runat="server" LogoutText='<i class="fa fa-power-off fa-fw"></i> Logout' />
        </li>
    </ul>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
<div class="row">
        <div class="col-lg-3" style='text-align: center'>
            <img src="Assets/Images/Stop.png" />
        </div>
        <div class="col-lg-9">

            <div class="alert alert-warning" role="alert">
                <h3><span class="fa fa-exclamation-triangle fa-fw"></span>Oops !</h3>
                <br />
                Something went wrong.
                Please contact System Administrator.
                <br />
                <br />
                <a href="Welcome.aspx">Click here</a> to go Home Page.
            </div>
            <br />
            <br />
        </div>
    </div>
</asp:Content>
