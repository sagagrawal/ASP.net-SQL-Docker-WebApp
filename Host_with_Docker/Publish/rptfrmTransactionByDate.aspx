<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="rptfrmTransactionByDate.aspx.cs" Inherits="PigmyPlus.ReportForms.rptfrmTransactionByDate" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadingContent" runat="server">
    <span class="fa fa-smile-o fa-lg"></span>&nbsp Get Reports.
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ActionContentsButtons" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ActionContent" runat="server">
    <ul class="dropdown-menu pull-right" role="menu">
        <li><a href="Welcome.aspx"><span class="fa fa-home fa-lg"></span> Home </a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <div class="col-lg-6 col-md-offset-1">
        <asp:FormView ID="frmTransactionReport" runat="server" Width="100%" DefaultMode="Insert">
            <InsertItemTemplate>
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <span style="color: White" class="fa fa-smile-o fa-lg"></span>&nbsp Report of Transaction By Date
                    </div>
                    <div class="panel-body">
                        <!-- Add 2 HTML Tables within a row inside panel body -->
                        <!-- Starts a row inside panel body -->
                        <div class="row">
                            <div class="col-lg-12" style='text-align: center'>
                                <table style="width: 100%; text-align: left;">
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtTransactionDate" CssClass="form-control DateInput" placeholder="Choose Transaction Date" runat="server" Height="30px" Width="256px"></asp:TextBox>
                                            <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:UpdatePanel runat="server">
                                                <ContentTemplate>
                                                    <asp:Button runat="server" ID="btnGetReport" Text="Generate Report" CausesValidation="true" OnClick="btnGetReport_Click" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                            <asp:UpdateProgress runat="server">
                                                <ProgressTemplate>Loading...</ProgressTemplate>
                                            </asp:UpdateProgress>
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
        <br />
        <br />
    </div>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <rsweb:ReportViewer ID="rptViewer" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="90%" Height="500px"></rsweb:ReportViewer>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
