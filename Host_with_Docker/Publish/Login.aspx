<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PigmyPlus.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PigmyPlus Care Pro</title>
    <link href="Assets/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="Assets/css/sb-admin.css" rel="stylesheet" />
    <script type="text/javascript" src="Assets/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="Assets/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="Assets/js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script type="text/javascript" src="Assets/js/sb-admin.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="login-panel panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">Login to PigmyPlus Care Pro.</h3>
                        </div>
                        <div class="panel-body">
                            <fieldset>
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-user fa-fw"></i></span>
                                        <asp:TextBox ID="txtUserName" runat="server" placeholder="Login Name" />
                                    </div>
                                    <asp:RequiredFieldValidator ID="reqUserName" ControlToValidate="txtUserName" runat="server" Display="None" ErrorMessage="Enter Your Username"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
                                        <asp:TextBox ID="txtPassword" runat="server" placeholder="Password" TextMode="Password" />
                                    </div>
                                    <asp:RequiredFieldValidator ID="reqPassword" Display="None" ControlToValidate="txtPassword" runat="server" ErrorMessage="Enter Password"></asp:RequiredFieldValidator>
                                </div>

                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblMsg" ForeColor="Red" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:ValidationSummary ID="ValidationSummary1" DisplayMode="BulletList" runat="server" />
                                        </td>
                                    </tr>
                                </table>

                                <asp:Button ID="btnLogin" class="btn btn-lg btn-success btn-block" runat="server" Text="Login" OnClick="btnLogin_Click" />
                            </fieldset>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
