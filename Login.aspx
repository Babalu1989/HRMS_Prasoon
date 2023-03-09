<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png" />
    <link rel="icon" type="image/png" href="assets/img/favicon.png" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>HRMS(SLA)</title>
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
    <!-- Extra details for Live View on GitHub Pages -->
    <!-- Canonical SEO -->
    <link rel="canonical" href="https://www.creative-tim.com/product/material-dashboard-pro" />
    <!--  Social tags      -->
    <meta name="keywords" content="HRMS(SLA)" />
    <meta name="description" content="" />
    <%--<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />--%>
    <link href="maxcdn.bootstrapcdn/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet" />
    <!-- CSS Files -->
    <link href="assets/css/demo.css" rel="stylesheet" />
    <link href="assets/css/material-dashboard.minf066.css" rel="stylesheet" />
    <link rel="stylesheet" href="assets/css/style.css" />
    <!-- CSS Just for demo purpose, don't include it in your project -->
</head>
<body>
    <form id="form1" runat="server" autocomplete="off">
        <div>
            <nav class="navbar navbar-expand-lg navbar-transparent navbar-absolute fixed-top text-white">
                <img src="assets/img/BSESRAJDHANI.png" class="loginimg" />
                <div class="container">
                    <div class="navbar-wrapper">
                        <%-- <a class="navbar-brandlogin">Human Resource Management System</a>--%>
                    </div>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="navbar-toggler-icon icon-bar"></span>
                        <span class="navbar-toggler-icon icon-bar"></span>
                        <span class="navbar-toggler-icon icon-bar"></span>
                    </button>
                    <img src="assets/img/logo2.png" alt="BRPL-HRMS(SLA)" class="loginimglogo" />
                </div>
            </nav>
            <!-- End Navbar -->
            <div class="wrapper">
                <div class="page-header login-page header-filter" filter-color="black" style="background-image: url('assets/img/login.png'); background-size: cover; background-position: top center;">
                    <!--   you can change the color of the filter page using: data-color="blue | purple | green | orange | red | rose " -->
                  

                    <div class="container">

                        <!-- Account Logo -->
                        <div class="account-logo">
                        </div>
                        <!-- /Account Logo -->

                        <div class="account-box">
                            <div class="account-wrapper">
                                <%-- <h3 class="account-title">Login</h3>
                                <p class="account-subtitle">Access to our dashboard</p>--%>

                                <!-- Account Form -->
                                <form action="index.html">
                                    <div class="form-group">
                                        <label>User ID</label>
                                        <input class="form-control" type="text" id="txt_userid" />
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col">
                                                <label>Password</label>
                                            </div>
                                        </div>
                                        <input class="form-control" type="password" id="txt_password" autocomplete="off" />                                      
                                    </div>
                                    <div class="text-center">
                                        <a class="btn btn-primary account-btn" onclick="login();">Login</a>
                                    </div>
                                      <div class="col-auto float-right">
                                            <a class="" href="http://10.125.68.71:86/passwordreset.aspx">Forgot password?  <%--text-muted--%>
                                            </a>
                                        </div>
                                    <br />
                                    <div class="account-footer">                                        
                                        <p>
                                            <a href="javascript:void(0)">Design &amp; Developed By :<br />
                                                BRPL IT Development Team (V6.2)</a>
                                        </p>
                                    </div>
                                </form>
                                <!-- /Account Form -->

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="assets/js/jquery-3.2.1.min.js"></script>
    <script src="assets/jalert/jAlerts.min.js"></script>
    <script src="assets/jalert/jAlerts.js"></script>
    <link href="assets/jalert/jAlerts.css" rel="stylesheet" />
    <script>       
           function left(msg) {
               jAlert({
                   contentText: msg
               }, "left"); // <---- Notice how this is changed to "left"
           }

        function login() {
            debugger;          
            var empid = $('#txt_userid').val();
            var pass = $('#txt_password').val();
            if (empid == "" || pass == "") {
                alert("User-id/Password Required")
            } else {               
                $.ajax({

                    url: 'Login.aspx/fetchlogindetails',

                    type: "POST",

                    dataType: "json",

                    data: JSON.stringify({ empid: empid, pass: pass }),//ca details from sap

                    contentType: "application/json; charset=utf-8",                    
                    success: function (data) {
                        console.log(data);
                        if (data.d.length > 0) {
                            dataD = JSON.parse(data.d);
                            var datalength = dataD.length;
                            console.log("dataD", dataD);
                            if ((datalength > 0 && dataD[0].USER_LOGINID != "1") && (dataD[0].HRMS_CNT > dataD[0].CLR_CNT)) { window.location.href = "Dashboard";}
                           else if ((datalength > 0 && dataD[0].USER_LOGINID != "1") && dataD[0].CLR_CNT > 0) { window.location.href = "Clearance"; }
                           else if (datalength > 0 && dataD[0].USER_LOGINID != "1") { window.location.href = "MRF"; }
                            else {
                                alert("User ID/Password Incorrect");
                            }
                        } else {
                            alert("User ID/Password Incorrect");
                        }
                       
                    },
                    error: function (err) {                       
                        console.log(err);
                    }

                });
            }
        }
    </script>    
</body>
</html>
