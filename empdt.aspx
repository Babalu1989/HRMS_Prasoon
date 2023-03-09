<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="empdt.aspx.cs" Inherits="empdt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style>
        .dt-buttons {
            display: none;
        }
    </style>
    <div class="container-fluid" id="jsdatatable">
        <div class="float-left" style="margin-top: 0%;">
            <%--margin-bottom: -2%;"--%>
            <a href="#" class="btn add-btn" data-toggle="modal" data-target="#add_employee"><i class="fa fa-plus"></i>Add Employee</a>
        </div>
        <div id="gridtablediv" style="margin-top: 0%;" class="customtextdatatable"></div>
    </div>

    <!-- Add Employee Modal -->
    <form class="form">
        <div id="add_employee" class="modal custom-modal fade" role="dialog">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add Employee</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="card-box">
                                        <h3 class="card-title">Profile Information <%--<a href="javascript:void(0);" class="delete-icon"></a>--%></h3>
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="profile-img-wrap edit-img">
                                                    <img id="blah" src="http://placehold.it/120x120" />
                                                    <div class="fileupload btn">
                                                        <span class="btn-text">edit</span>
                                                        <input class="upload" id="pic" type="file" onchange="readURLaddnew(this);" accept="image/png" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-12" style="text-align: center;">
                                                <span style="color: maroon">Only jpg Supported</span>
                                            </div>
                                            <script>
                                                $('.fileupload').bind("click", function () {
                                                    $('#pic').click();
                                                });
                                                function readURLaddnew(input) {
                                                    debugger;
                                                    if (input.files && input.files[0]) {
                                                        var reader = new FileReader();

                                                        reader.onload = function (e) {
                                                            $('#blah').attr('src', e.target.result);
                                                        };

                                                        reader.readAsDataURL(input.files[0]);
                                                    }
                                                }
                                            </script>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">Joining Type : <span class="text-danger">*</span></label>
                                                    <select class="form-control" required="required" data-error-msg="Gender Required" id="Selectjointype">
                                                        <option>--Select--</option>
                                                        <option>New Joining</option>
                                                        <option>Replacement</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <script>
                                                $("#Selectjointype").change(function () {
                                                    if ($("#Selectjointype").val() == "Replacement") {
                                                        $("#replacementdiv").show();
                                                    } else {
                                                        $("#replacementdiv").hide();
                                                    }
                                                });
                                            </script>

                                            <div class="col-sm-6">
                                                <div class="form-group" id="replacementdiv" style="display: none">
                                                    <label class="col-form-label">Replacement (Aadhar/Emp.Id) : <span class="text-danger">*</span></label>
                                                    <input class="form-control" type="text" required="required" data-error-msg="Employee Id/Aadhar No" id="replacementid" />
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">Approval Reference Number <span class="text-danger">*</span></label>
                                                    <input class="form-control" type="text" required="required" data-error-msg="Approval Reference No" id="approvalno" />
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">Work Order Number <span class="text-danger">*</span></label>
                                                    <input class="form-control" type="text" required="required" data-error-msg="Name Required" id="workorderno" />
                                                </div>
                                            </div>


                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">Employee Name <span class="text-danger">*</span></label>
                                                    <input class="form-control" type="text" required="required" data-error-msg="Name Required" id="addmodalname" />
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">Father Name</label>
                                                    <input class="form-control" type="text" required="required" data-error-msg="Father Name Required" id="addmodalfathername" />
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">BRPL-UID</label>
                                                    <input class="form-control" type="text" onkeypress="return validatenumber(event)" id="addmodalbrpluid" />
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">Employee ID <span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" required="required" data-error-msg="Emp Id. Required" id="addmodalempid" />
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">Aadhar<span class="text-danger">*</span></label>
                                                    <input class="form-control" type="text" onkeypress="return validatenumber(event)" maxlength="12" required="required" data-error-msg="Aadhar Number Required" id="addmodalaadhar" />
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">Email</label>
                                                    <input class="form-control" type="email" id="addmodalemail" />
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">Joining Date <span class="text-danger">*</span></label>
                                                    <div class="cal-icon">
                                                        <input class="form-control datetimepicker" type="text" maxlength="9" required="required" data-error-msg="Joining Date Required" id="addmodaljoiningdate" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">Birth Date <span class="text-danger">*</span></label>
                                                    <div class="cal-icon">
                                                        <input class="form-control datetimepicker" type="text" maxlength="9" required="required" data-error-msg="Birth Date Required" id="addmodaldob" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">Phone <span class="text-danger">*</span></label>
                                                    <input class="form-control" type="text" onkeypress="return validatenumber(event)" maxlength="10" required="required" data-error-msg="Phone No Required" id="addmodalphone" />
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">Alternate Number</label>
                                                    <input class="form-control" type="text" onkeypress="return validatenumber(event)" maxlength="10" required="required" data-error-msg="Alternate No Required" id="addmodalalternate" />
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">Emergency Contact No <span class="text-danger">*</span></label>
                                                    <input class="form-control" type="text" id="addmodalemergencycontact" maxlength="10" />
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">Voter Id</label>
                                                    <input class="form-control" type="text" id="addmodalvoterid" />
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">Company/Vendor</label>
                                                    <asp:DropDownList runat="server" ID="ddl_venaddnew" class="form-control" required="required" data-error-msg="Vendor Required" ClientIDMode="Static"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Department <span class="text-danger">*</span></label>
                                                    <asp:DropDownList runat="server" ID="ddl_deptaddnew" class="form-control" required="required" data-error-msg="Department Required" ClientIDMode="Static"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Designation <span class="text-danger">*</span></label>
                                                    <asp:DropDownList runat="server" ID="ddl_desgaddnew" class="form-control" required="required" data-error-msg="Designation Required" ClientIDMode="Static"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">Report To (L1)<span class="text-danger">*</span></label>
                                                    <asp:DropDownList runat="server" ID="ddl_reportingaddnewmodal" class="form-control" ClientIDMode="Static" required="required" data-error-msg="Reporting Officer Required"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Gender<span class="text-danger">*</span></label>
                                                    <select class="form-control" required="required" data-error-msg="Gender Required" id="addmodalgender">
                                                        <option>--Select--</option>
                                                        <option>Male</option>
                                                        <option>Female</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Nationality<span class="text-danger">*</span></label>
                                                    <select class="form-control" id="addmodalcountry">
                                                        <option>Indian</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Division<span class="text-danger">*</span></label>
                                                    <asp:DropDownList runat="server" ID="ddl_divaddnew" class="form-control" ClientIDMode="Static" onchange="getsubdiv(this);" required="required" data-error-msg="Division Required"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Sub-Division<span class="text-danger">*</span></label>
                                                    <asp:DropDownList runat="server" ID="ddl_subdivaddnew" class="form-control" ClientIDMode="Static" required="required" data-error-msg="Sub-Division Required">
                                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-12">
                                                <div class="form-group">
                                                    <label class="col-form-label">Address <span class="text-danger">*</span></label>
                                                    <input class="form-control" type="text" required="required" data-error-msg="Address Required" id="addmodaladdress" />
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>State<span class="text-danger">*</span></label>
                                                    <asp:DropDownList runat="server" ID="ddl_stateaddnew" class="form-control" ClientIDMode="Static" onchange="getcity(this);" required="required" data-error-msg="State Required"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>City<span class="text-danger">*</span></label>
                                                    <asp:DropDownList runat="server" ID="ddl_cityaddnew" class="form-control" ClientIDMode="Static" required="required" data-error-msg="City Required">
                                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">Landmark</label>
                                                    <input class="form-control" type="text" required="required" data-error-msg="Landmark Required" id="addmodallandmark" />
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">Pin-Code <span class="text-danger">*</span></label>
                                                    <input class="form-control" type="text" onkeypress="return validatenumber(event)" maxlength="6" required="required" data-error-msg="Pin Code Required" id="addmodalpincode" />
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">UAN <span class="text-danger">*</span></label>
                                                    <input class="form-control" type="text" required="required" data-error-msg="UAN Required" id="addmodaluan" onkeypress="return validatenumber(event)" maxlength="12" />
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">Mode of Contract <span class="text-danger">*</span></label>
                                                    <select class="form-control" required="required" data-error-msg="Mode of Contract Required" id="addmodalcontractmode">
                                                        <option>--Select--</option>
                                                        <option>Long Term</option>
                                                        <option>Short Term</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">Period of Contract From <span class="text-danger">*</span></label>
                                                    <div class="cal-icon">
                                                        <input class="form-control datetimepicker" type="text" maxlength="9" required="required" data-error-msg="From Date Required" id="addmodalcontractfrom" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">Period of Contract To <span class="text-danger">*</span></label>
                                                    <div class="cal-icon">
                                                        <input class="form-control datetimepicker" type="text" maxlength="9" required="required" data-error-msg="To Date Required" id="addmodalcontractto" />
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">Category of Wage <span class="text-danger">*</span></label>

                                                    <select class="form-control" id="addmodalwage">
                                                        <option>--Select--</option>
                                                        <option>Minimum Wages</option>
                                                        <option>Special</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label class="col-form-label">Nature of Job<span class="text-danger">*</span></label>
                                                    <asp:DropDownList runat="server" ID="ddl_nojaddnewmodal" class="form-control" ClientIDMode="Static" required="required" data-error-msg="Nature of Job Required"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="submit-section">
                                <button class="btn btn-primary submit-btn" onclick="funcaddnewmodaldatasave();">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <!-- /Add Employee Modal -->

    <!-- Edit terminate Employee Modal -->
    <div id="edit_employee" class="modal custom-modal fade" role="dialog">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">Ã—</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Employee <span class="text-danger">*</span></label>
                                    <input class="form-control" type="text" value="" id="terminationname" disabled="disabled" />
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Aadhaar <span class="text-danger">*</span></label>
                                    <input class="form-control" type="text" value="" id="terminationaadhar" disabled="disabled" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Type <span class="text-danger">*</span></label>
                            <div class="add-group-btn">
                                <asp:DropDownList runat="server" ID="ddl_terminationtype" ClientIDMode="Static" class="form-control"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Effective Date <span class="text-danger">*</span></label>
                            <div class="cal-icon">
                                <input type="text" class="form-control datetimepicker" value="" id="terminationdate" autocomplete="off" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Reason <span class="text-danger">*</span></label>
                            <textarea class="form-control" rows="4" id="terminationreason"></textarea>
                        </div>
                        <div class="submit-section">
                            <button class="btn btn-primary submit-btn" onclick="function_edit_deactive();">Submit</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- Edit terminate Employee Modal -->


    <!-- Delete Employee Modal -->
    <div class="modal custom-modal fade" id="delete_employee" role="dialog">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="form-header">
                        <h3>Delete Employee</h3>
                        <p>Are you sure want to delete?</p>
                    </div>
                    <div class="modal-btn delete-action">
                        <div class="row">
                            <div class="col-6">
                                <a href="javascript:void(0);" class="btn btn-primary continue-btn">Delete</a>
                            </div>
                            <div class="col-6">
                                <a href="javascript:void(0);" data-dismiss="modal" class="btn btn-primary cancel-btn">Cancel</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /Delete Employee Modal -->

    <!-- Employee Details Modal -->

    <div id="details" style="display: none">
        <div class="content container-fluid">
            <!-- Page Title -->
            <div class="row">
                <div class="col-sm-11">
                    <h4 class="page-title"><a href="javascript:void(0);" class="btn btn-xs btn-link btn-toggle-fullwidth"><i class="fa fa-arrow-left" onclick="function_back();return false;"></i></a>Profile</h4>
                    <%--<i class="la la-home  la-2x"></i><h4 class="page-title">Profile</h4>--%>
                </div>
                <div class="col-sm-1"><span style="float: left;" onclick="javascript:printDiv('details')" class="pull-right"><i class="fa fa-print " style="font-size: 30px; float: left; color: red;"></i></span></div>
            </div>
            <!-- /Page Title -->

            <div class="card-box mb-0">
                <div class="row">
                    <div class="col-md-12">
                        <div class="profile-view">
                            <div class="profile-img-wrap">
                                <div class="profile-img">
                                    <a href="javascript:void(0);">
                                        <img id="profile" /></a>
                                </div>
                            </div>
                            <div class="profile-basic">
                                <div class="row">
                                    <div class="col-md-5">
                                        <div class="profile-info-left">
                                            <h3 class="user-name m-t-0 mb-0"><span id="empname"></span></h3>
                                            <h6 class="text-muted"><span id="department"></span><span id="divsionspan"></span></h6>
                                            <small class="text-muted"><span id="designation"></span></small>
                                            <div class="staff-id">Employee ID : <span id="empid"></span></div>
                                            <div class="staff-id">Aadhar : <span id="aadharid"></span></div>
                                            <div class="staff-id">BRPL-UID : <span id="uidno"></span></div>
                                            <div class="staff-id">Date of Joining : <span id="doj"></span></div>
                                            <div class="small doj text-muted">Date of Birth : <span id="dob"></span></div>
                                            <div class="staff-msg">
                                                <a class="btn btn-custom" id="btnCookie">Send Message</a>
                                                <script type="text/javascript">
                                                    $(function () {
                                                        $("#btnCookie").bind("click", function () {
                                                            $.cookie("name", $("#empname")[0].textContent);
                                                            $.cookie("aadhar", $("#aadharid")[0].textContent);
                                                            $.cookie("designation", $("#designation")[0].textContent);
                                                            $.cookie("dob", $("#dob")[0].textContent);
                                                            $.cookie("phone", $("#phone")[0].textContent);
                                                            $.cookie("email", $("#email")[0].textContent);
                                                            $.cookie("img", $('#profile')[0].src);
                                                            window.location.href = "Message";
                                                        });
                                                    });
                                                </script>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-7">
                                        <ul class="personal-info">
                                            <li>
                                                <div class="title">Phone:</div>
                                                <div class="text"><span id="phone" style="color: blue"></span></div>
                                            </li>
                                            <li>
                                                <div class="title">Email:</div>
                                                <div class="text"><span id="email" style="color: blue"></span></div>
                                            </li>
                                            <li>
                                                <div class="title staff-id">Present Add:</div>
                                                <div class="text"><span id="address"></span></div>
                                            </li>
                                            <li>
                                                <div class="title staff-id">Permanent Add:</div>
                                                <div class="text"><span id="permanentaddress"></span></div>
                                            </li>
                                            <li>
                                                <div class="title">Gender:</div>
                                                <div class="text"><span id="gender"></span></div>
                                            </li>
                                            <li>
                                                <div class="title">Reports to (L1):</div>
                                                <div class="text">
                                                    <div class="avatar-box">
                                                        <div class="avatar avatar-xs">
                                                            <img src="assets/img/logout.png" alt="" />
                                                        </div>
                                                    </div>
                                                    <span id="reportingoffc" style="color: #0094ff"></span>
                                                    <span id="reportingoffccode" style="color: #0094ff"></span>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="title">Reports to (L2):</div>
                                                <div class="text">
                                                    <div class="avatar-box">
                                                        <div class="avatar avatar-xs">
                                                            <img src="assets/img/logout.png" alt="" />
                                                        </div>
                                                    </div>
                                                    <span id="reportingoffcl2" style="color: #0094ff"></span>
                                                    <span id="reportingoffccodel2" style="color: #0094ff"></span>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="title">Status:</div>
                                                <div class="text" id="empstatus"></div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="pro-edit">
                                <a class="edit-icon" href="javascript:void(0)" onclick="mdlpersonaldata();">
                                    <i class="fa fa-pencil"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card tab-box">
                <div class="row user-tabs">
                    <div class="col-lg-12 col-md-12 col-sm-12 line-tabs">
                        <ul class="nav nav-tabs nav-tabs-bottom">
                            <li class="nav-item"><a href="#emp_profile" data-toggle="tab" class="nav-link active">Profile</a></li>
                            <li class="nav-item"><a href="#emp_projects" data-toggle="tab" class="nav-link">Documents</a></li>
                            <li class="nav-item"><a href="#bank_statutory" data-toggle="tab" class="nav-link">Salary&nbsp;<small class="text-danger">(Admin Only)</small></a></li>
                            <li class="nav-item"><a href="#salaryHistory" data-toggle="tab" class="nav-link">Salary&nbsp;History<small class="text-danger">(Admin Only)</small></a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="tab-content">
                <!-- Profile Info Tab -->
                <div id="emp_profile" class="pro-overview tab-pane fade show active">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card-box profile-box">
                                <h3 class="card-title">Contract Informations <a class="edit-icon" onclick="function_contractinformation();"><i class="fa fa-pencil"></i></a></h3>
                                <ul class="personal-info">
                                    <li>
                                        <div class="title">Mode of Contract</div>
                                        <div class="text"><span id="contractmode"></span></div>
                                    </li>
                                    <li>
                                        <div class="title">Period of Contract From</div>
                                        <div class="text"><span id="contractfrom"></span></div>
                                    </li>
                                    <li>
                                        <div class="title">Period of Contract To</div>
                                        <div class="text"><span id="contractto"></span></div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card-box profile-box">
                                <h3 class="card-title">Other Informations <a class="edit-icon" onclick="function_otherinformationmodal();"><i class="fa fa-pencil"></i></a></h3>
                                <ul class="personal-info">
                                    <li>
                                        <div class="title">UAN</div>
                                        <div class="text"><span id="uan"></span></div>
                                    </li>
                                    <li>
                                        <div class="title">Emergency Contact No</div>
                                        <div class="text"><span id="emergencycontact"></span></div>
                                    </li>
                                    <li>
                                        <div class="title">Category of wage</div>
                                        <div class="text"><span id="wages"></span></div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card-box profile-box">
                                <h3 class="card-title">Personal Informations <a class="edit-icon" onclick="function_personal_info_modal(this);"><i class="fa fa-pencil"></i></a></h3>
                                <ul class="personal-info">
                                    <li>
                                        <div class="title">Alternate Number</div>
                                        <div class="text"><span id="telephone" style="color: #0094ff"></span></div>
                                    </li>
                                    <li>
                                        <div class="title">Father's Name</div>
                                        <div class="text"><span id="fathersname"></span></div>
                                    </li>
                                    <li>
                                        <div class="title">ESIC</div>
                                        <div class="text"><span id="esic"></span></div>
                                    </li>
                                    <li>
                                        <div class="title">Voter Id</div>
                                        <div class="text"><span id="voterid"></span></div>
                                    </li>
                                    <li>
                                        <div class="title">Nature of Job</div>
                                        <div class="text"><span id="noj"></span></div>
                                    </li>
                                    <li>
                                        <div class="title">Vendor</div>
                                        <div class="text"><span id="vendor"></span></div>
                                    </li>

                                </ul>
                            </div>
                        </div>
                        <div class="col-md-6">

                            <div class="card-box profile-box">
                                <h3 class="card-title">Bank information<a class="edit-icon" onclick="function_bank_employee(this);"><i class="fa fa-pencil"></i></a></h3>
                                <ul class="personal-info">
                                    <li>
                                        <div class="title">Bank name</div>
                                        <div class="text"><span id="bankname"></span></div>
                                    </li>
                                    <li>
                                        <div class="title">Bank account No.</div>
                                        <div class="text"><span id="bankaccountno"></span></div>
                                    </li>
                                    <li>
                                        <div class="title">IFSC Code</div>
                                        <div class="text"><span id="ifsccode"></span></div>
                                    </li>
                                    <li>
                                        <div class="title">PAN No</div>
                                        <div class="text"><span id="panno"></span></div>
                                    </li>
                                    <li>
                                        <div class="title">MICR</div>
                                        <div class="text"><span id="micr"></span></div>
                                    </li>
                                    <li>
                                        <div class="title">PF</div>
                                        <div class="text"><span id="pf"></span></div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 d-flex">
                            <div class="card profile-box flex-fill">
                                <div class="card-body">
                                    <h3 class="card-title">Family Informations <a href="#" class="edit-icon" data-toggle="modal" data-target="#family_info_modal"><i class="fa fa-pencil"></i></a></h3>
                                    <div class="table-responsive" id="familygridtablediv">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card-box profile-box">
                                <h3 class="card-title">Education Informations <a href="#" class="edit-icon" data-toggle="modal" data-target="#education_info"><i class="fa fa-pencil"></i></a></h3>
                                <div class="experience-box">
                                    <ul class="experience-list" id="educationdiv"></ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card-box profile-box">
                                <h3 class="card-title">Experience <a href="#" class="edit-icon" data-toggle="modal" data-target="#experience_info"><i class="fa fa-pencil"></i></a></h3>
                                <div class="experience-box">
                                    <ul class="experience-list" id="experiencediv"></ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <!-- salary History Statutory Tab -->
                <div class="tab-pane fade" id="salaryHistory">
                    <div class="card">
                        <div class="card-body">
                            <div id="gridtablesalarydiv" style="margin-top: 0%;" class="customtextdatatable"></div>
                        </div>
                    </div>
                </div>
                <!-- salary History Statutory Tab -->

                <!-- /Profile Info Tab -->

                <!-- Projects Tab -->
                <div id="emp_projects" class="tab-pane">
                    <div class="row">
                        <div class="col-lg-12 col-sm-12 col-md-12 col-xl-12">
                            <div class="card-box project-box">
                                <h4 class="project-title"><a href="project-view.html">Documents</a></h4>
                                <small class="block text-ellipsis m-b-15">
                                    <span class="text-xs"></span><span class="text-muted">Total Documents :</span>
                                    <ul class="team-members">
                                        <li>
                                            <a href="javascript:void(0)" onclick="showdocmodal();" class="all-users">
                                                <asp:Label runat="server" ID="lbl_totalcnt" ClientIDMode="Static"></asp:Label></a>
                                        </li>
                                    </ul>
                                </small>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <span class="small_text fade_text">*Documents Upload:</span>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group">
                                            <asp:DropDownList ID="ddl_doctype" runat="server" class="form-control" ClientIDMode="Static">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <a href="javascript:void(0);" class="btn btn-primary edit-btn" onclick="BrowseFile('filesbill');"><i class="fa fa-paperclip"></i></a>
                                        <div class="form-group" style="margin-left: 4%; margin-top: 9px;">
                                            <div class="file-field">
                                                <span id="filenamebill" class="text-success"></span>
                                                <asp:FileUpload ID="filesbill" ClientIDMode="Static" runat="server" Style="display: none" accept="application/pdf" onchange="onChange_FileUpload(this,'filenamebill')" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="addmoredocumentdiv" class="row"></div>
                                <div class="row pull-right">
                                    <div class="file-field">
                                        <div class="add-more">
                                            <a class="header-primary" href="javascript:void(0);" onclick="addmoredocument();"><i class="fa fa-plus-circle"></i>Add More</a>
                                        </div>
                                    </div>
                                </div>
                                <%--<p class="m-b-5">Progress <span class="text-success float-right">40%</span></p>
                                <div class="progress progress-xs mb-0">
                                    <div style="width: 40%" title="" data-toggle="tooltip" role="progressbar" class="progress-bar bg-success" data-original-title="40%"></div>
                                </div>--%>
                                <div style="margin-top: 10px" class="text-center">
                                    <button class="btn btn-primary submit-btn float-center" onclick="documentsave();return false;">Submit</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /Projects Tab -->

                <!-- salary Statutory Tab -->
                <div class="tab-pane fade" id="bank_statutory">
                    <div class="card">
                        <div class="card-body">
                            <form>
                                <div class="row">
                                    <div class="col-md-5">
                                        <div class="form-group">
                                            <label>Category of wage<span class="text-danger">*</span></label>
                                            <select class="form-control" id="otherinformationmodalwage">
                                                <option>--Select--</option>
                                                <option>Minimum Wages</option>
                                                <option>Special</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-5" id="otherinformationmodalsubwagediv">
                                        <%--style="display: none" modified 17-10-2019--%>
                                        <div class="form-group">
                                            <label>Sub-Category of wage<span class="text-danger">*</span></label>
                                            <select class="form-control" id="otherinformationmodalsubwage">
                                                <option>--Select--</option>
                                                <option value="US">Unskilled</option>
                                                <option value="SSNM">Semi-Skilled and Non-Matriculate</option>
                                                <option value="SMBG">Skilled and Matriculate But Not Gard</option>
                                                <option value="GA">Graduate and Above</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="form-group" style="margin-top: 15%;"><a class="btn btn-custom t-5" onclick="javascript:printDiv('')" href="Javascript:void(0);" id="genrateSlip">Generate Slip</a></div>
                                    </div>
                                    <script>
                                        $("#otherinformationmodalwage").change(function () {
                                            if ($("#otherinformationmodalwage").val() == "Special") {
                                                $('#divspecialsalary').show(); $('#divminwages').hide(); $('#otherinformationmodalsubwagediv').show();//$('#otherinformationmodalsubwagediv').hide();
                                                var button = document.getElementById('genrateSlip');
                                                button.setAttribute("onClick", "printDiv('divspecialsalary')");
                                            }
                                            else if ($("#otherinformationmodalwage").val() == "Minimum Wages") {
                                                $('#otherinformationmodalsubwagediv').show(); $('#divspecialsalary').hide(); $('#divminwages').show();
                                                var button = document.getElementById('genrateSlip');
                                                button.setAttribute("onClick", "printDiv('divminwages')");
                                                if ($('#otherinformationmodalsubwage').val() == "US") {
                                                    $("#minwage").keyup();
                                                }
                                                if ($('#otherinformationmodalsubwage').val() == "SSNM") {
                                                    $("#minwage").keyup();
                                                }
                                                if ($('#otherinformationmodalsubwage').val() == "SMBG") {
                                                    $("#minwage").keyup();
                                                }
                                                if ($('#otherinformationmodalsubwage').val() == "GA") {
                                                    $("#minwage").keyup();
                                                }
                                                if ($('#otherinformationmodalsubwage').val() == "--Select--") {
                                                    $('#minwage').val(0)
                                                }
                                            } else {

                                                $('#otherinformationmodalsubwagediv').show(); //$('#otherinformationmodalsubwagediv').hide();
                                                $('#divspecialsalary').hide();
                                                $('#divminwages').hide();
                                            }
                                        });

                                        $("#otherinformationmodalsubwage").change(function () {
                                            getamountbackdata();
                                            if ($("#otherinformationmodalsubwage").val() == "--Select--") { //$('#divminwages').hide(); 
                                                $('#minwage').val(0)
                                            } else {
                                                if ($('#otherinformationmodalsubwage').val() == "US") {
                                                    $("#minwage").keyup();
                                                }
                                                if ($('#otherinformationmodalsubwage').val() == "SSNM") {
                                                    $("#minwage").keyup();
                                                }
                                                if ($('#otherinformationmodalsubwage').val() == "SMBG") {
                                                    $("#minwage").keyup();
                                                }
                                                if ($('#otherinformationmodalsubwage').val() == "GA") {
                                                    $("#minwage").keyup();
                                                }
                                                // $('#divminwages').show();
                                            }
                                        });
                                    </script>
                                </div>
                                <hr />
                                <div id="divspecialsalary" style="display: none">
                                    <h3 class="card-title">Basic Salary Information</h3>
                                    <label>Monthly:</label>
                                    <label class="float-lg-right ml-5">Yearly:</label>
                                    <div class="card-box">
                                        <div class="">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Basic :<span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control" id="basic" onkeyup="function_filldata();" autocomplete="off" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Basic :</label>
                                                        <input class="form-control" type="text" id="basicy" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>HRA :</label>
                                                        <input class="form-control" type="text" id="hra" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>HRA :</label>
                                                        <input class="form-control" type="text" id="hray" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Other Allowance :</label>
                                                        <input class="form-control" type="text" id="other" value="0"  onkeyup="function_filldatarest();" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Other Allowance :</label>
                                                        <input class="form-control" type="text" id="othery" value="0" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Gross Salary :</label>
                                                        <input class="form-control" type="text" id="gross" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Gross Salary :</label>
                                                        <input class="form-control" type="text" id="grossy" readonly="readonly" />
                                                    </div>
                                                </div>
                                            </div>
                                            <hr />
                                            <h5 class="card-title font-weight-bold font-italic text-center">Employer Cost</h5>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Contribution to PF @ 13% of Basic :</label>
                                                        <input class="form-control" type="text" id="epf" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Contribution to PF @ 13% of Basic :</label>
                                                        <input class="form-control" type="text" id="epfy" readonly="readonly" />
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Contribution to ESI @ 3.25% of Gross :</label>
                                                        <input class="form-control" type="text" id="eesi" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Contribution to ESI @ 3.25% of Gross :</label>
                                                        <input class="form-control" type="text" id="eesiy" readonly="readonly" />
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Bonus (8.33% of MW) :</label>
                                                        <input class="form-control" type="text" id="bonus" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Bonus (8.33% of MW) :</label>
                                                        <input class="form-control" type="text" id="bonusy" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Leave (4.81% of Basic) :</label>
                                                        <input class="form-control" type="text" id="leave" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Leave (4.81% of Basic) :</label>
                                                        <input class="form-control" type="text" id="leavey" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Workmen Compensation Insurance Policy :</label>
                                                        <input class="form-control" type="text" id="insurance" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Workmen Compensation Insurance Policy :</label>
                                                        <input class="form-control" type="text" id="insurancey" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Statutory Cost :</label>
                                                        <input class="form-control" type="text" id="statutary" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Statutory Cost :</label>
                                                        <input class="form-control" type="text" id="statutaryy" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label>Agency Margin Type<span class="text-danger">*</span></label>
                                                        <select class="form-control" id="agencytype">
                                                            <option>--Select--</option>
                                                            <option value="Percentage">Percentage Amount</option>
                                                            <option value="Fixed">Fixed Amount</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label>Agency Margin(in Rs) :</label>
                                                        <input class="form-control" type="text" id="agency" value="0" onkeyup="agencydatafill();" onkeypress="return validatenumber(event)" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Agency Margin :</label>
                                                        <input class="form-control" type="text" id="agencyy" readonly="readonly" />
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Total Employer Cost :</label>
                                                        <input class="form-control" type="text" id="totalemp" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Total Employer Cost :</label>
                                                        <input class="form-control" type="text" id="totalempy" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6"></div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>GPA :</label>
                                                        <input class="form-control" type="text" id="gpay" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6"></div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Total Cost :</label>
                                                        <input class="form-control" type="text" id="totaly" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6"></div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Total Cost Including GST(1.18) :</label>
                                                        <input class="form-control" type="text" id="totalgsty" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Conveyance Limit Per month :</label>
                                                        <input class="form-control" type="text" id="conveyanceamount" autocomplete="off" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Mobile Per Month :</label>
                                                        <input class="form-control" type="text" id="mobileamount" autocomplete="off" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="submit-section">
                                        <a class="btn btn-primary submit-btn" onclick="savesalarydetails();">Update</a>
                                    </div>
                                </div>
                                <div id="divminwages" style="display: none">
                                    <h3 class="card-title">Basic Salary Information</h3>
                                    <label>Monthly:</label>
                                    <label class="float-lg-right ml-5">Yearly:</label>
                                    <div class="card-box">
                                        <div class="">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Minimum Wages :<span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control" id="minwage" readonly="readonly" onkeyup="function_filldatanormal();" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Minimum Wages :</label>
                                                        <input class="form-control" type="text" id="minwagey" readonly="readonly" />
                                                    </div>
                                                </div>
                                            </div>
                                            <hr />
                                            <h5 class="card-title font-weight-bold font-italic text-center">Employer Cost</h5>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Contribution to PF @ 13% of Basic :</label>
                                                        <input class="form-control" type="text" id="normalpf" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Contribution to PF @ 13% of Basic :</label>
                                                        <input class="form-control" type="text" id="normalpfy" readonly="readonly" />
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Contribution to ESI @ 3.25% of Gross :</label>
                                                        <input class="form-control" type="text" id="normalesi" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Contribution to ESI @ 3.25% of Gross :</label>
                                                        <input class="form-control" type="text" id="normalesiy" readonly="readonly" />
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Bonus (8.33% of MW) :</label>
                                                        <input class="form-control" type="text" id="normalbonus" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Bonus (8.33% of MW) :</label>
                                                        <input class="form-control" type="text" id="normalbonusy" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Leave (4.81% of Basic) :</label>
                                                        <input class="form-control" type="text" id="normalleave" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Leave (4.81% of Basic) :</label>
                                                        <input class="form-control" type="text" id="normalleavey" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label>Agency Margin Type<span class="text-danger">*</span></label>
                                                        <select class="form-control" id="normalagencytype">
                                                            <option>--Select--</option>
                                                            <option value="Percentage">Percentage Amount</option>
                                                            <option value="Fixed">Fixed Amount</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label>Agency Margin(In Rs):</label>
                                                        <input class="form-control" type="text" id="normalagency" value="0" onkeyup="normalgencykeyup();" onkeypress="return validatenumber(event)" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Agency Margin(in Rs):</label>
                                                        <input class="form-control" type="text" id="normalagencyy" readonly="readonly" />
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Total Employer Cost :</label>
                                                        <input class="form-control" type="text" id="normaltotal" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Total Employer Cost :</label>
                                                        <input class="form-control" type="text" id="normaltotaly" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Fianlized Rates :</label>
                                                        <input class="form-control" type="text" id="normalfinalized" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Fianlized Rates :</label>
                                                        <input class="form-control" type="text" id="normalfinalizedy" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6"></div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>GPA :</label>
                                                        <input class="form-control" type="text" id="normalgpa" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6"></div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Total Cost :</label>
                                                        <input class="form-control" type="text" id="normaltotalcost" readonly="readonly" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6"></div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Total Cost Including GST(1.18) :</label>
                                                        <input class="form-control" type="text" id="normaltotalcostgst" readonly="readonly" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="submit-section">
                                        <button class="btn btn-primary submit-btn" onclick="savesalarynormaldetails();">Update</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- /salary Statutory Tab -->

            </div>
        </div>
        <div id="profile_info" class="modal custom-modal fade" role="dialog" aria-hidden="true" style="display: none;">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Profile Information</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="profile-img-wrap edit-img">
                                        <img id="blahprofileinformation" src="http://placehold.it/120x120" />
                                        <div class="fileupload btn">
                                            <span class="btn-text">edit</span>
                                            <input class="upload" id="profilemodalimage" type="file" onchange="readURL(this);" accept="image/jpg" />
                                            <script>
                                                $('.fileupload').bind("click", function () {
                                                    $('#profilemodalimage').click();
                                                });
                                                function readURL(input) {
                                                    debugger;
                                                    if (input.files && input.files[0]) {
                                                        var reader = new FileReader();

                                                        reader.onload = function (e) {
                                                            $('#blahprofileinformation').attr('src', e.target.result);
                                                        };

                                                        reader.readAsDataURL(input.files[0]);
                                                    }
                                                }
                                            </script>

                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-12" style="text-align: center;">
                                    <span style="color: maroon">Only jpg Supported</span>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>First Name</label>
                                            <input type="text" class="form-control" id="profilemodalempname" />
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Last Name</label>
                                            <input type="text" class="form-control" id="profilemodalemplastname" />
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Employee Id*</label>
                                            <input type="text" class="form-control" value="" id="profilemodalempid" />
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>BRPL-UID</label>
                                            <input type="text" class="form-control" value="" id="profilemodaluid" />
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Aadhar no*</label>
                                            <input type="text" class="form-control" value="" id="profilemodalaadhar" />
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Gender</label>
                                            <select class="form-control" data-select2-id="37" tabindex="-1" aria-hidden="true" id="profilemodalgender">
                                                <option value="MALE">Male</option>
                                                <option value="FEMALE">Female</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Date of Joining</label>
                                            <div class="cal-icon">
                                                <input class="form-control datetimepicker" type="text" value="" id="profilemodaldoj" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Birth Date</label>
                                            <div class="cal-icon">
                                                <input class="form-control datetimepicker" type="text" value="" id="profilemodaldob" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="figure-caption">Present Address:</div>
                            <div class="row card-box">
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label>Address</label>
                                        <input type="text" class="form-control" value="" id="profilemodaladdress" />
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>State<span class="text-danger">*</span></label>
                                        <asp:DropDownList runat="server" ID="profilemodalstate" class="form-control" ClientIDMode="Static" onchange="getcityprofilemodal(this);"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>City<span class="text-danger">*</span></label>
                                        <asp:DropDownList runat="server" ID="profilemodalcity" class="form-control" ClientIDMode="Static">
                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="figure-caption">Permanent Address:</div>
                            <div class="row card-box">
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label>Address</label>
                                        <input type="text" class="form-control" value="" id="profilemodalpermanentaddress" />
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>State<span class="text-danger">*</span></label>
                                        <asp:DropDownList runat="server" ID="profilemodalpermanentstate" class="form-control" ClientIDMode="Static" onchange="getcityprofilemodalpermanent(this);"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>City<span class="text-danger">*</span></label>
                                        <asp:DropDownList runat="server" ID="profilemodalpermanentcity" class="form-control" ClientIDMode="Static">
                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Division<span class="text-danger">*</span></label>
                                        <asp:DropDownList runat="server" ID="profilemodaldivision" class="form-control" ClientIDMode="Static" onchange="getsubdivmodal(this);"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Sub-Division<span class="text-danger">*</span></label>
                                        <asp:DropDownList runat="server" ID="profilemodalsubdivision" class="form-control" ClientIDMode="Static">
                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Reports To <span class="text-danger">*</span></label>
                                        <asp:DropDownList runat="server" ID="ddl_profileinforeport" class="form-control" ClientIDMode="Static"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Phone Number</label>
                                        <input type="text" class="form-control" value="" id="profilemodalphone" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Department <span class="text-danger">*</span></label>
                                        <asp:DropDownList runat="server" ID="ddl_profileinfodepartment" ClientIDMode="Static" class="form-control"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Designation <span class="text-danger">*</span></label>
                                        <asp:DropDownList runat="server" ID="ddl_profileinfodesignation" ClientIDMode="Static" class="form-control"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>E-Mail-id</label>
                                        <input type="text" class="form-control" value="" id="txt_profileinfomailid" />
                                    </div>
                                </div>
                            </div>
                            <div class="submit-section">
                                <button class="btn btn-primary submit-btn" onclick="funcprofilemodaldatasave();return false;">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div id="contractinformationmodal" class="modal custom-modal fade" role="dialog">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Contract Information</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Mode of Contract<span class="text-danger">*</span></label>
                                        <select class="form-control" id="contractinformationmodalmode">
                                            <option>--Select--</option>
                                            <option>Short Term</option>
                                            <option>Long Term</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Contract From:</label>
                                        <div class="cal-icon">
                                            <input class="form-control datetimepicker" type="text" value="" id="contractinformationmodalfrom" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Contract To:</label>
                                        <div class="cal-icon">
                                            <input class="form-control datetimepicker" type="text" value="" id="contractinformationmodalTo" />
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="submit-section">
                                <button class="btn btn-primary submit-btn" onclick="function_contract_update();">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div id="otherinformationmodal" class="modal custom-modal fade" role="dialog">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Other Information</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>UAN</label>
                                        <input type="text" class="form-control" value="" id="otherinformationmodaluan" onkeypress="return validatenumber(event)" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Emergency Contact Number</label>
                                        <input type="text" class="form-control" value="" id="otherinformationmodalemergency" maxlength="10" onkeypress="return validatenumber(event)" />
                                    </div>
                                </div>


                            </div>
                            <div class="submit-section">
                                <button class="btn btn-primary submit-btn" onclick="function_other_update();">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div id="personal_info_modal" class="modal custom-modal fade" role="dialog">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Personal Information</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Alternate Number</label>
                                        <input class="form-control" type="text" id="personal_info_modal_altnumber" maxlength="10" onkeypress="return validatenumber(event)" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Father's Name:</label>
                                        <input class="form-control" type="text" id="personal_info_modal_father" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>ESIC:</label>
                                        <input class="form-control" type="text" id="personal_info_modal_esic" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Voter Id:</label>
                                        <input class="form-control" type="text" id="personal_info_modal_voterid" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Nature of Job:</label>
                                        <asp:DropDownList ID="personal_info_modal_ddl_noj" runat="server" class="form-control" ClientIDMode="Static"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Vendor:</label>
                                        <asp:DropDownList runat="server" ID="personal_info_modal_ddl_vendor" class="form-control" ClientIDMode="Static"></asp:DropDownList>
                                    </div>
                                </div>

                            </div>
                            <div class="submit-section">
                                <button class="btn btn-primary submit-btn" onclick="functionupdate_personal_info_modal();">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div id="bank_details_modal" class="modal custom-modal fade" role="dialog">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Bank Information</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="card-box">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Bank Name <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="modalbankname" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Bank Account Number <span class="text-danger">*</span></label>
                                        <input class="form-control" type="text" id="modalaccountno" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>IFSC Code <span class="text-danger">*</span></label>
                                        <input class="form-control" type="text" id="modalifsc" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>PAN No</label>
                                        <input class="form-control" type="text" id="modalpanno" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>MICR:</label>
                                        <input class="form-control" type="text" id="modalmicr" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>PF:</label>
                                        <input class="form-control" type="text" id="modalpf" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="submit-section">
                            <button class="btn btn-primary submit-btn" onclick="func_bankinfosave();">Submit</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="education_info" class="modal custom-modal fade" role="dialog">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Education Informations</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-scroll">
                            <div class="card-box">
                                <h3 class="card-title">Education Informations <%--<a href="javascript:void(0);" class="delete-icon"><i class="fa fa-trash-o"></i></a>--%></h3>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group form-focus focused">
                                            <input type="text" value="" class="form-control floating" id="education_infomodalinstittute" />
                                            <label class="focus-label">Institution</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group form-focus focused">
                                            <input type="text" value="" class="form-control floating" id="education_infomodalsubject" />
                                            <label class="focus-label">Subject</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group form-focus focused">
                                            <div class="cal-icon">
                                                <input type="text" value="" class="form-control floating datetimepicker" id="education_infomodalstartdate" />
                                            </div>
                                            <label class="focus-label">Starting Date</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group form-focus focused">
                                            <div class="cal-icon">
                                                <input type="text" value="" class="form-control floating datetimepicker" id="education_infomodalcompletedate" />
                                            </div>
                                            <label class="focus-label">Complete Date</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group form-focus focused">
                                            <input type="text" value="" class="form-control floating" id="education_infomodaldegree" />
                                            <label class="focus-label">Degree</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group form-focus focused">
                                            <input type="text" value="" class="form-control floating" id="education_infomodalgrade" />
                                            <label class="focus-label">Grade</label>
                                        </div>
                                    </div>
                                </div>
                                <div id="updateeducationdiv" class="row"></div>
                                <div class="add-more" onclick="addmoreeducationupdate();">
                                    <a href="javascript:void(0);"><i class="fa fa-plus-circle"></i>Add More</a>
                                </div>
                            </div>
                        </div>
                        <div class="submit-section">
                            <button class="btn btn-primary submit-btn" onclick="education_infoupdate();">Submit</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div id="experience_info" class="modal custom-modal fade" role="dialog">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Experience Informations</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-scroll">
                            <div class="card-box">
                                <h3 class="card-title">Experience Informations <%--<a href="javascript:void(0);" class="delete-icon"><i class="fa fa-trash-o"></i></a>--%></h3>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group form-focus focused">
                                            <input type="text" class="form-control floating" value="" id="experience_info_company" />
                                            <label class="focus-label">Company Name</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group form-focus focused">
                                            <input type="text" class="form-control floating" value="" id="experience_info_location" />
                                            <label class="focus-label">Location</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group form-focus focused">
                                            <input type="text" class="form-control floating" value="" id="experience_info_position" />
                                            <label class="focus-label">Job Position</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group form-focus focused">
                                            <div class="cal-icon">
                                                <input type="text" class="form-control floating datetimepicker" value="" id="experience_info_from" />
                                            </div>
                                            <label class="focus-label">Period From</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group form-focus focused">
                                            <div class="cal-icon">
                                                <input type="text" class="form-control floating datetimepicker" value="" id="experience_info_to" />
                                            </div>
                                            <label class="focus-label">Period To</label>
                                        </div>
                                    </div>
                                </div>
                                <div id="updateexperiencedivdiv" class="row"></div>
                                <div class="add-more" onclick="addmoreexperienceupdate();">
                                    <a href="javascript:void(0);"><i class="fa fa-plus-circle"></i>Add More</a>
                                </div>
                            </div>
                        </div>
                        <div class="submit-section">
                            <button class="btn btn-primary submit-btn" onclick="function_experienceupdate();">Submit</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div id="family_info_modal" class="modal custom-modal fade" role="dialog">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Family Informations</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-scroll">
                            <div class="card-box">
                                <h3 class="card-title">Family Member <%--<a href="javascript:void(0);" class="delete-icon"><i class="fa fa-trash-o"></i></a>--%></h3>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Name <span class="text-danger">*</span></label>
                                            <input class="form-control" type="text" id="familyname" required="required" data-error-msg="Name Required" />
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Relationship <span class="text-danger">*</span></label>
                                            <select class="form-control" data-error-msg="Gender Required" id="familytype">
                                                <option>--Select--</option>
                                                <option>Father</option>
                                                <option>Mother</option>
                                                <option>Spouse</option>
                                                <option>Son</option>
                                                <option>Daughter</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Date of birth <span class="text-danger">*</span></label>
                                            <input class="form-control datetimepicker" type="text" id="familydob" required="required" data-error-msg="DOB Required" />
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Phone</label>
                                            <input class="form-control" type="text" id="familyphone" />
                                        </div>
                                    </div>
                                </div>
                                <div class="row" id="familydynamic"></div>
                                <div class="add-more" onclick="familyaddmore();">
                                    <a href="javascript:void(0);"><i class="fa fa-plus-circle"></i>Add More</a>
                                </div>
                            </div>
                        </div>
                        <div class="submit-section">
                            <a class="btn btn-primary submit-btn" onclick="submitfamily();">Submit</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- Employee Details Modal -->

    <div class="modal fade" id="examplepopup" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <p class="modal-title text-center" id="P1">&nbsp;Aadhar No :&nbsp;<label id="modalaadhar" style="color: #dc3545"></label></p>
                    <br />
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="font-size: 25px;">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>Name :&nbsp;<asp:Label ID="lbl_name" runat="server" class="text-success" ClientIDMode="Static"></asp:Label></p>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="tab-pane animated fadeIn active">
                                <div class="col-sm-12">
                                    <div id="table" style="width: 100%"></div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3" id="carouselDiv" style="display: none;">
                            <div id="demo" class="carousel slide" data-ride="carousel">
                                <!-- Indicators -->
                                <ul class="carousel-indicators">
                                    <%-- <li data-target="#demo" data-slide-to="<%=i %>" class="<%=(i==0)?"active":"" %>"></li>--%>
                                </ul>
                                <!-- The slideshow -->
                                <div class="carousel-inner">
                                    <%-- <div class="carousel-item ">                                    
                                    </div>--%>
                                </div>

                                <!-- Left and right controls -->
                                <a class="carousel-control-prev" href="#demo" data-slide="prev">
                                    <span class="carousel-control-prev-icon"></span>
                                </a>
                                <a class="carousel-control-next" href="#demo" data-slide="next">
                                    <span class="carousel-control-next-icon"></span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <script>
        $(document).ready(function () {
            getedatatble();
        });

        function showdocmodal() {
            $("#examplepopup").modal("show");
        }

        function showdocdata(aadhardata) {
            $.ajax({
                type: "POST",
                url: "empdt.aspx/data",
                dataType: "json",
                data: JSON.stringify({ aadhar: aadhardata }),
                contentType: "application/json",
                success: function (data) {
                    $('#table').empty();
                    $("#table").show();
                    debugger;
                    if (data.d.length > 0) {
                        $('#lbl_totalcnt')[0].innerText = data.d.length;
                        $("#table").append("<thead><tr class='GridViewScrollHeader'><th scope='col'>Sr No.</th><th scope='col'>Documents</th><th scope='col'>File</th></tr></thead>");
                        for (var i = 0; i < data.d.length; i++) {
                            $("#table").append("<tbody><tr class='GridViewScrollItem'><td>" + data.d[i].SR_NO + "</td><td>" + data.d[i].TXT + "</td><td>  <i id='" + data.d[i].file_id + "' class='fa fa-file-pdf-o' aria-hidden='true' style='font-size: 20px; color:red; text-align: right;' onclick='pdfdownloadfunc(this)'></i></td></tr> </tbody>");

                        }
                    } else {
                        $("#table").append("<tbody><tr class='GridViewScrollItem'><td><p style='color:red'>No Record Found !!!</p></td></tr></tbody>");
                    }
                },
                Error: function () {
                }
            });
            //griddata          
        }


        function getedatatble() {
            loadmyloading();
            $.ajax({
                type: "POST",
                url: "empdt.aspx/bindata",
                dataType: "json",
                data: JSON.stringify({ typ: "4" }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $('#gridtablediv').html('');
                        debugger;
                        var gridtable = '  <table id="gridtable"  class="table table-striped custom-table datatable dataTable no-footer" role="grid">';
                        var col = [];
                        var colHeader = [];
                        var th = '';
                        var fault = eval(data.d);
                        for (var i = 0; i < fault.length; i++) {
                            for (var key in fault[i]) {
                                if (col.indexOf(key) === -1) {
                                    col.push(key);
                                    colHeader.push({ data: key, title: key })

                                    th += '<th>' + key + '</th>';
                                }
                            }
                        }

                        gridtable += '  <thead> <tr>' + th + '</tr></thead>';

                        var srNo = 1;
                        var tempDiv = '';
                        var td = '';
                        for (var i = 0; i < fault.length; i++) {
                            var trclass = '';
                            if ((i % 2) == 0) {
                                trclass = 'class=""';
                            }
                            td += ' <tr ' + trclass + '>';
                            for (var j = 0; j < col.length; j++) {
                                if (j == col.length - 3) {
                                    if (fault[i][col[j]] == "Working") {
                                        td += '<td><span class="badge badge-success-border">' + fault[i][col[j]] + '</span></td>';
                                    } else {
                                        td += '<td><span class="badge badge-danger-border">' + fault[i][col[j]] + '</span></td>';
                                    }

                                } else {
                                    td += '<td>' + fault[i][col[j]] + '</td>';
                                }
                            }
                            td += ' </tr>';
                        }
                        gridtable += '  <tbody> ' + td + '</tbody>';
                        gridtable += ' </table>';
                        $('#gridtablediv').append(gridtable);
                        var groupColumn = 0;
                        $('#gridtable').DataTable({
                            columnDefs: [
                             {
                                 "targets": [8],
                                 "visible": false,
                             },
                              {
                                  "targets": [0],
                                  "visible": true,
                                  render: function (data, type, row, meta) {
                                      data = '<a href="javascript:" onclick="backendcall(this)">' + encodeURIComponent(data) + '</a>';
                                      return data;
                                  }
                              }
                            ],
                            "scrollCollapse": true, dom: 'Bfrtip',
                            buttons: [
                               'excel',
                            ],
                            lengthMenu: [
                             [5]
                            ],
                        });
                        removemyloading();
                    }
                }
            });
        }

        function getedatatblesalryhistory(aadhardata) {
            loadmyloading();
            $.ajax({
                type: "POST",
                url: "empdt.aspx/bindatasalary",
                dataType: "json",
                data: JSON.stringify({ typ: "12", aadhar: aadhardata }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        removemyloading();
                        $('#gridtablesalarydiv').html('');
                        debugger;
                        var gridtablesalary = '  <table id="gridtablesalary"  class="table table-striped custom-table datatable dataTable no-footer" role="grid">';
                        var col = [];
                        var colHeader = [];
                        var th = '';
                        var fault = eval(data.d);
                        for (var i = 0; i < fault.length; i++) {
                            for (var key in fault[i]) {
                                if (col.indexOf(key) === -1) {
                                    col.push(key);
                                    colHeader.push({ data: key, title: key })

                                    th += '<th>' + key + '</th>';
                                }
                            }
                        }

                        gridtablesalary += '  <thead> <tr>' + th + '</tr></thead>';

                        var srNo = 1;
                        var tempDiv = '';
                        var td = '';
                        for (var i = 0; i < fault.length; i++) {
                            var trclass = '';
                            if ((i % 2) == 0) {
                                trclass = 'class=""';
                            }
                            td += ' <tr ' + trclass + '>';
                            for (var j = 0; j < col.length; j++) {
                                if (j == col.length - 2) {
                                    if (fault[i][col[j]] == "Working") {
                                        td += '<td><span class="badge badge-success-border">' + fault[i][col[j]] + '</span></td>';
                                    } else {
                                        td += '<td><span class="badge badge-danger-border">' + fault[i][col[j]] + '</span></td>';
                                    }

                                } else {
                                    td += '<td>' + fault[i][col[j]] + '</td>';
                                }
                            }
                            td += ' </tr>';
                        }
                        gridtablesalary += '  <tbody> ' + td + '</tbody>';
                        gridtablesalary += ' </table>';
                        $('#gridtablesalarydiv').append(gridtablesalary);
                        var groupColumn = 0;
                        $('#gridtablesalary').DataTable({
                            "info": true,
                            "scrollY": 230,
                            "scrollX": true,
                            "scrollCollapse": true,
                            dom: 'Bfrtip',
                            "paging": false,
                            buttons: [
                               'excel',
                            ],
                            lengthMenu: [
                             [5]
                            ],
                        });
                    }
                }
            });
        }


        function getedatatblefamily(aadhardata) {
            loadmyloading();
            $.ajax({
                type: "POST",
                url: "empdt.aspx/bindatasalary",
                dataType: "json",
                data: JSON.stringify({ typ: "17", aadhar: aadhardata }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        removemyloading();
                        $('#familygridtablediv').html('');
                        debugger;
                        var gridtablefamily = '<table id="gridtablefamily"  class="table table-nowrap">';
                        var col = [];
                        var colHeader = [];
                        var th = '';
                        var fault = eval(data.d);
                        for (var i = 0; i < fault.length; i++) {
                            for (var key in fault[i]) {
                                if (col.indexOf(key) === -1) {
                                    col.push(key);
                                    if (key == "SR_NO") {
                                        colHeader.push({ data: "#", title: "#" })
                                        th += '<th>#</th>';
                                    } else {
                                        colHeader.push({ data: key, title: key })
                                        th += '<th>' + key + '</th>';
                                    }
                                }
                            }
                        }

                        gridtablefamily += '  <thead> <tr>' + th + '</tr></thead>';

                        var srNo = 1;
                        var tempDiv = '';
                        var td = '';
                        for (var i = 0; i < fault.length; i++) {
                            var trclass = '';
                            if ((i % 2) == 0) {
                                trclass = 'class=""';
                            }
                            td += ' <tr ' + trclass + '>';
                            for (var j = 0; j < col.length - 1; j++) {
                                td += '<td>' + fault[i][col[j]] + '</td>';
                            }
                            // if (j == col.length) {
                            td += '<td><div class="dropdown dropdown-action">';
                            td += '<a aria-expanded="false" data-toggle="dropdown" class="action-icon dropdown-toggle" href="#"><i class="material-icons">more_vert</i></a>';
                            td += '<div class="dropdown-menu dropdown-menu-right" x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(55px, 32px, 0px);">';
                            td += '<a href="javascript:void(0);" class="dropdown-item" onclick="delete_family(' + fault[i][col[j]] + ')"><i class="fa fa-trash-o m-r-5"></i> Delete</a>';
                            td += '</div>';
                            td += '</div></td>';
                            //}
                            td += ' </tr>';
                        }
                        gridtablefamily += '  <tbody> ' + td + '</tbody>';
                        gridtablefamily += ' </table>';
                        $('#familygridtablediv').append(gridtablefamily);
                        $('#gridtablefamily').DataTable({
                            dom: 'Bfrtip',
                            "paging": false,
                            "searching": false,
                            "info": false,
                            buttons: [
                               'excel',
                            ],
                        });
                    }
                }
            });
        }



        function function_back() {
            $('#details').hide();
            $('#jsdatatable').show();
        }

        var reporting = '';
        var dept = '';
        var refpic = '';
        var state = '';
        var city = '';
        var divs = '';
        var subdiv = '';
        var subcat = '';
        var vendorcode = ''; var aadhar = '';
        var permanentstate = '';
        var permanentcity = '';
        function backendcall(obj) {
            debugger;
            getedatatblesalryhistory(obj.innerHTML);
            showdocdata(obj.innerHTML);
            getedatatblefamily(obj.innerHTML);
            $('#modalaadhar')[0].innerHTML = obj.innerHTML;
            aadhar = obj.innerHTML;
            $('#details').show();
            $('#jsdatatable').hide();
            $.ajax({
                type: "POST",
                url: "empdt.aspx/binalldata",
                dataType: "json",
                data: JSON.stringify({ typ: "5", aadhar: aadhar }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var empdetails = eval(data.d);
                        console.log("empdetails", empdetails);
                        if (empdetails[0].length > 0) {
                            $('#lbl_name')[0].innerHTML = empdetails[0][0].EMP_NM;
                            $("#aadharid").text((empdetails[0][0].AADHAR) != null ? empdetails[0][0].AADHAR : "NA");
                            $("#empname").text((empdetails[0][0].EMP_NM) != null ? empdetails[0][0].EMP_NM : "NA");
                            $("#department").text((empdetails[0][0].DEPT_NAME) != null ? empdetails[0][0].DEPT_NAME : "NA");
                            $("#designation").text((empdetails[0][0].DEG) != null ? empdetails[0][0].DEG : "NA");
                            $("#empid").text((empdetails[0][0].EMP_CODE) != null ? empdetails[0][0].EMP_CODE : "NA");
                            $("#uidno").text((empdetails[0][0].UIDNO) != null ? empdetails[0][0].UIDNO : "NA");
                            $("#doj").text((empdetails[0][0].DOJ) != null ? empdetails[0][0].DOJ : "NA");
                            $("#phone").text((empdetails[0][0].CONTACT_NO) != null ? empdetails[0][0].CONTACT_NO : "NA");
                            $("#email").text((empdetails[0][0].EMAIL_ID) != null ? empdetails[0][0].EMAIL_ID : "NA");
                            $("#divsionspan").text((empdetails[0][0].DIVISION) != null ? " (" + empdetails[0][0].DIVISION + " , " + empdetails[0][0].SUB_DIV + " )" : "NA");
                            reporting = empdetails[0][0].L1_REPORTING;
                            dept = empdetails[0][0].DEPT;
                            refpic = empdetails[0][0].PIC_REF;
                            state = empdetails[0][0].STATE;
                            city = empdetails[0][0].CITY;
                            divs = empdetails[0][0].DIV_CODE;
                            subdiv = empdetails[0][0].SUB_DIV_CODE;
                            vendorcode = empdetails[0][0].VENDOR_CODE;
                            $("#empstatus").empty();
                            $("#empstatus").append(empdetails[0][0].STATUS_DESC == "Working" ? '<span class="badge badge-success-border">' + empdetails[0][0].STATUS_DESC + '</span>' : '<span class="badge badge-danger-border">' + empdetails[0][0].STATUS_DESC + '</span>');
                            $("#dob").text((empdetails[0][0].DOB) != null ? empdetails[0][0].DOB : "NA");
                            $("#address").text((empdetails[0][0].ADDR1) != null ? empdetails[0][0].ADDR1 + "," + (city != null ? city : "") + "," + (state != null ? state : "") : "NA");
                            $("#permanentaddress").text((empdetails[0][0].ADDR2) != null ? empdetails[0][0].ADDR2.split('|')[0] : "NA");
                            $("#profilemodalpermanentaddress").val((empdetails[0][0].ADDR2) != null ? empdetails[0][0].ADDR2.split('|')[0] : "NA");
                            $("#profilemodalpermanentstate").val((empdetails[0][0].ADDR3) != null ? empdetails[0][0].ADDR3 : "NA");
                            getcityprofilemodalpermanent($('#profilemodalpermanentstate'), (empdetails[0][0].ADDR2) != null ? empdetails[0][0].ADDR2.split('|')[1] : "");
                            //$("#profilemodalpermanentcity").val((empdetails[0][0].ADDR2.split('|')[1]) != null ? empdetails[0][0].ADDR2.split('|')[1] : "NA");
                            $("#gender").text((empdetails[0][0].GENDER) != null ? empdetails[0][0].GENDER : "NA");
                            $("#reportingoffc").text((empdetails[0][0].L1_NAME) != null ? empdetails[0][0].L1_NAME : "NA");
                            $("#reportingoffcl2").text((empdetails[0][0].L2_NAME) != null ? empdetails[0][0].L2_NAME : "NA");

                            $("#contractmode").text((empdetails[0][0].CONTRCT_MODE) != null ? empdetails[0][0].CONTRCT_MODE : "NA");
                            $("#contractfrom").text((empdetails[0][0].CONTRCT_FRM) != null ? empdetails[0][0].CONTRCT_FRM : "NA");
                            $("#contractto").text((empdetails[0][0].CONTRCT_TO) != null ? empdetails[0][0].CONTRCT_TO : "NA");
                            $("#uan").text((empdetails[0][0].UAN) != null ? empdetails[0][0].UAN : "NA");
                            $("#emergencycontact").text((empdetails[0][0].EMERGNCY_CONTACT_NO) != null ? empdetails[0][0].EMERGNCY_CONTACT_NO : "NA");
                            $("#wages").text((empdetails[0][0].CATG_WAGES) != null ? empdetails[0][0].CATG_WAGES + ((empdetails[0][0].CATG_WAGES_DESC) != null ? "(" + empdetails[0][0].CATG_WAGES_DESC + ")" : "") : "NA");
                            subcat = empdetails[0][0].CATG_SUB_WAGES;
                            $('#otherinformationmodalsubwage').val(empdetails[0][0].CATG_SUB_WAGES);
                            $("#reportingoffccode").text((empdetails[0][0].L1_REPORTING) != null ? "(" + empdetails[0][0].L1_REPORTING + ")" : "NA");
                            //  $("#reportingoffccodel2").text((empdetails[0][0].L1_REPORTING) != null ? "(" + empdetails[0][0].L1_REPORTING + ")" : "NA");
                            $("#telephone").text((empdetails[0][0].ALT_CONTACT_NO) != null ? empdetails[0][0].ALT_CONTACT_NO : "NA");
                            $("#fathersname").text((empdetails[0][0].EMP_FTHR_NM) != null ? empdetails[0][0].EMP_FTHR_NM : "NA");
                            $("#pf").text((empdetails[0][0].PF_NO) != null ? empdetails[0][0].PF_NO : "NA");
                            $("#esic").text((empdetails[0][0].ESIC_NO) != null ? empdetails[0][0].ESIC_NO : "NA");
                            $("#voterid").text((empdetails[0][0].VOTER_ID) != null ? empdetails[0][0].VOTER_ID : "NA");
                            $("#noj").text((empdetails[0][0].NAT_JOB) != null ? empdetails[0][0].NAT_JOB : "NA");
                            $("#vendor").text((empdetails[0][0].VENDOR_NAME) != null ? empdetails[0][0].VENDOR_NAME : "NA");
                            $("#micr").text((empdetails[0][0].MICR) != null ? empdetails[0][0].MICR : "NA");

                            $("#bankname").text((empdetails[0][0].BANK_NAME) != null ? empdetails[0][0].BANK_NAME : "NA");
                            $("#ifsccode").text((empdetails[0][0].IFSC) != null ? empdetails[0][0].IFSC : "NA");
                            $("#panno").text((empdetails[0][0].PAN_NO) != null ? empdetails[0][0].PAN_NO : "NA");
                            $("#bankaccountno").text((empdetails[0][0].AC_NO) != null ? empdetails[0][0].AC_NO : "NA");
                            document.getElementById("profile").src = "ImageCSharp.aspx?FileName=" + empdetails[0][0].PIC_REF; //new change   17-02-2020
                            document.getElementById("blahprofileinformation").src = "ImageCSharp.aspx?FileName=" + empdetails[0][0].PIC_REF; //new change   17-02-2020

                            $('#otherinformationmodalwage').val($('#wages')[0].textContent.split('(')[0]);
                            if ($('#wages')[0].textContent.split('(')[0] == "Minimum Wages") {
                                $('#otherinformationmodalsubwagediv').show(); $('#divspecialsalary').hide(); $('#divminwages').show();
                                $('#otherinformationmodalsubwage').val(subcat);
                                var button = document.getElementById('genrateSlip');
                                button.setAttribute("onClick", "printDiv('divminwages')");

                                $('#minwage').val(empdetails[0][0].BASIC);
                                $('#minwagey').val((empdetails[0][0].BASIC) * 12);
                                $('#normalpf').val(empdetails[0][0].PF);
                                $('#normalpfy').val((empdetails[0][0].PF) * 12);
                                $('#normalesi').val(empdetails[0][0].ESI);
                                $('#normalesiy').val((empdetails[0][0].ESI) * 12);
                                $('#normalbonus').val(empdetails[0][0].BONUS_MW);
                                $('#normalbonusy').val((empdetails[0][0].BONUS_MW) * 12);
                                $('#normalleave').val(empdetails[0][0].LEAVE_BASIC);
                                $('#normalleavey').val((empdetails[0][0].LEAVE_BASIC) * 12);
                               // $('#normalagency').val(empdetails[0][0].AGENCY_MARGIN);
                                //$('#normalagencyy').val(((empdetails[0][0].AGENCY_MARGIN) * 12).toFixed(2));
                                $('#normalagencyy').val((($('#normalagency').val()) * 12).toFixed(2)); // added 03-nov-2020
                                $('#normalfinalized').val(parseFloat(empdetails[0][0].TOTAL_CTC_MONTH).toFixed(2));
                                $('#normalfinalizedy').val(parseFloat(empdetails[0][0].TOTAL_CTC_MONTH).toFixed(2) * 12);
                                $('#normalgpa').val(empdetails[0][0].GPA);
                                $('#normaltotal').val((parseFloat($('#minwage').val()) + parseFloat($('#normalpf').val()) + parseFloat($('#normalesi').val()) + parseFloat($('#normalbonus').val()) + parseFloat($('#normalleave').val())).toFixed(2));
                                $('#normaltotaly').val(((parseFloat($('#minwagey').val()) + parseFloat($('#normalpf').val()) + parseFloat($('#normalesi').val()) + parseFloat($('#normalbonus').val()) + parseFloat($('#normalleave').val())) * 12).toFixed(2));
                                $('#normaltotalcost').val(empdetails[0][0].TOTAL_COST);
                                $('#normaltotalcostgst').val(empdetails[0][0].TOTAL_COST_WITH_GST);
                                //addition required
                            } else {
                                $('#divspecialsalary').show();
                                var button = document.getElementById('genrateSlip');
                                button.setAttribute("onClick", "printDiv('divspecialsalary')");
                                $('#basic').val(empdetails[0][0].BASIC);
                                $('#basicy').val((empdetails[0][0].BASIC) * 12);
                                $('#hra').val(empdetails[0][0].HRA);
                                $('#hray').val((empdetails[0][0].HRA) * 12);
                                $('#other').val(empdetails[0][0].OTHER_ALLOWANCE);
                                $('#othery').val((empdetails[0][0].OTHER_ALLOWANCE) * 12);
                                $('#gross').val(empdetails[0][0].GROSS_SAL);
                                $('#grossy').val((empdetails[0][0].GROSS_SAL) * 12);
                                $('#epf').val(empdetails[0][0].PF);
                                $('#epfy').val((empdetails[0][0].PF) * 12);
                                $('#eesi').val(empdetails[0][0].ESI);
                                $('#eesiy').val((empdetails[0][0].ESI) * 12);
                                $('#bonus').val(empdetails[0][0].BONUS_MW);
                                $('#bonusy').val((empdetails[0][0].BONUS_MW) * 12);
                                $('#leave').val(empdetails[0][0].LEAVE_BASIC);
                                $('#leavey').val((empdetails[0][0].LEAVE_BASIC) * 12);
                                $('#insurance').val(empdetails[0][0].WORKMEN_COMPENSATION);
                                $('#insurancey').val((empdetails[0][0].WORKMEN_COMPENSATION) * 12);
                                $('#statutary').val(empdetails[0][0].STATUORY_COST); $('#statutaryy').val((empdetails[0][0].STATUORY_COST) * 12);
                                // $('#agency').val(empdetails[0][0].AGENCY_MARGIN); $('#agencyy').val((empdetails[0][0].AGENCY_MARGIN) * 12);
                                $('#agency').val("0"); $('#agencyy').val("0");
                                $('#totalemp').val(empdetails[0][0].TOTAL_CTC_MONTH);
                                $('#totalempy').val(empdetails[0][0].TOTAL_CTC_ANNUM);
                                $('#gpay').val(empdetails[0][0].GPA);
                                $('#totaly').val(empdetails[0][0].TOTAL_COST);
                                $('#totalgsty').val(empdetails[0][0].TOTAL_COST_WITH_GST);
                                $('#mobileamount').val(empdetails[0][0].MOBILE_MONTH);
                                $('#conveyanceamount').val(empdetails[0][0].CONVENCE_LMT);
                            }

                        } if (empdetails[1].length > 0)//educationdetails
                        {
                            $('#educationdiv').empty();
                            var education = '';
                            for (var i = 0; i < empdetails[1].length; i++) {
                                if (empdetails[1][i].CRS_DEGR_NM != null) {
                                    education += "<li><div class='experience-user'><div class='before-circle'></div></div><div class='experience-content'><div class='timeline-content'>";
                                    education += "<a href='#/' class='name'>" + empdetails[1][i].INST_SCH + " (" + empdetails[1][i].DURATION + " )" + "</a><div>" + empdetails[1][i].CRS_DEGR_NM + "</div>";
                                    education += "<span class='time'>" + empdetails[1][i].SPEC + " (" + empdetails[1][i].GRADE + " )" + "</span>";
                                    education += "</div>";
                                    education += "</div>";
                                    education += "</li>";
                                } else {
                                    education += "<li><div class='experience-user'><div class='before-circle'></div></div><div class='experience-content'><div class='timeline-content'>";
                                    education += "<a href='#/' class='name'>NA</a><div>NA</div>";
                                    education += "<span class='time'>NA </span>";
                                    education += "</div>";
                                    education += "</div>";
                                    education += "</li>";
                                }
                            }
                            $('#educationdiv').append(education);
                        }
                        if (empdetails[2].length > 0)//workexperience
                        {
                            $('#experiencediv').empty();
                            var experience = '';
                            for (var i = 0; i < empdetails[2].length; i++) {
                                if (empdetails[2][i].COMP_NM != null) {
                                    experience += "  <li><div class='experience-user'><div class='before-circle'></div></div><div class='experience-content'><div class='timeline-content'>";
                                    experience += "<a href='#/' class='name'>" + empdetails[2][i].COMP_NM + " (" + empdetails[2][i].TODATE + " )" + "</a>";
                                    experience += "<span class='time'>" + empdetails[2][i].ADDR + "</span>"; experience += "<span class='time'>" + empdetails[2][i].EMP_RESP + "</span>";
                                    experience += "</div>";
                                    experience += "</div>";
                                    experience += "</li>";
                                }
                                else {
                                    experience += "  <li><div class='experience-user'><div class='before-circle'></div></div><div class='experience-content'><div class='timeline-content'>";
                                    experience += "<a href='#/' class='name'>NA</a>";
                                    experience += "<span class='time'>NA</span>";
                                    experience += "</div>";
                                    experience += "</div>";
                                    experience += "</li>";
                                }
                            }
                            $('#experiencediv').append(experience);
                        }

                    }
                }
            });

        }
        function mdlpersonaldata() {
            var id = $('#aadharid').val();
            $('#profile_info').modal('show');
            $('#profilemodalempname').val($('#empname')[0].innerHTML);
            $('#profilemodalempid').val($('#empid')[0].innerHTML);
            $('#profilemodaluid').val($('#uidno')[0].innerHTML);
            $('#profilemodalaadhar').val($('#aadharid')[0].innerHTML);
            $('#profilemodaldoj').val($('#doj')[0].innerHTML);
            $('#ddl_profileinforeport').val(reporting);
            $('#ddl_profileinfodepartment').val(dept);
            $('#ddl_profileinfodesignation').val($("#designation")[0].innerHTML);
            $('#profilemodaladdress').val($('#address')[0].innerHTML);
            $('#profilemodalphone').val($('#phone')[0].innerHTML);
            $('#profilemodaldob').val($('#dob')[0].innerHTML);
            $('#txt_profileinfomailid').val($('#email')[0].innerHTML);
            $('#profilemodalstate').val(state);
            $('#profilemodaldivision').val(divs);
            getsubdivmodal($('#profilemodaldivision'), subdiv);
            getcityprofilemodal($('#profilemodalstate'), city);
        }
        function edit_employee(obj) {
            var valterminate = obj.split(',');
            $('#edit_employee').modal('show');
            $('#terminationname').val(valterminate[1]);
            $('#ddl_terminationtype').val(valterminate[2]);// modified 01-11-2019
            $('#terminationaadhar').val(valterminate[0]);// modified 01-11-2019
        }

        function delete_family(obj) {
            if (confirm("Do you want to delete record!!!")) {
                $.ajax({
                    type: "POST",
                    url: "empdt.aspx/employeefamily",
                    dataType: "json",
                    data: JSON.stringify({ typ: "17A", aadhar: aadhar, name: $('#familyname').val(), relation: $('#familytype').val(), dob: $('#familydob').val(), phone: $('#familyphone').val(), srno: obj, ty: "DEL" }),
                    contentType: "application/json",
                    success: function (data) {
                        if (data.d.length > 0) {
                            var response = eval(data.d);
                            console.log("response", response);
                            if (response.length > 0) {
                                $('#family_info_modal').modal('hide');
                                left(response[0].TXT);

                            }
                        }
                    }
                });
            }
        }

        function submitfamily() {
            $.ajax({
                type: "POST",
                url: "empdt.aspx/employeefamily",
                dataType: "json",
                data: JSON.stringify({ typ: "17A", aadhar: aadhar, name: $('#familyname').val(), relation: $('#familytype').val(), dob: $('#familydob').val(), phone: $('#familyphone').val(), srno: "", ty: "NEW" }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var response = eval(data.d);
                        console.log("response", response);
                        if (response.length > 0) {
                            $('#family_info_modal').modal('hide');
                            left(response[0].TXT);

                        }
                    }
                }
            });
        }


        function function_personal_info_modal(obj) {
            $('#personal_info_modal').modal('show');
            $('#personal_info_modal_altnumber').val($('#telephone')[0].innerHTML);
            $('#personal_info_modal_father').val($('#fathersname')[0].innerHTML);
            $('#personal_info_modal_esic').val($('#esic')[0].innerHTML);
            $('#personal_info_modal_voterid').val($('#voterid')[0].innerHTML);
            $('#personal_info_modal_ddl_noj').val($('#noj')[0].innerHTML);
            $('#personal_info_modal_ddl_vendor').val(vendorcode);

        }

        function function_bank_employee(obj) {
            $('#bank_details_modal').modal('show');
            $('#modalbankname').val($('#bankname')[0].textContent);
            $('#modalaccountno').val($('#bankaccountno')[0].textContent);
            $('#modalifsc').val($('#ifsccode')[0].textContent);
            $('#modalpanno').val($('#panno')[0].textContent);
            $('#modalmicr').val($('#micr')[0].textContent);
            $('#modalpf').val($('#pf')[0].textContent);
        }

        function function_contractinformation(obj) {
            $('#contractinformationmodal').modal('show');
            $('#contractinformationmodalmode').val($('#contractmode')[0].textContent);
            $('#contractinformationmodalfrom').val($('#contractfrom')[0].textContent);
            $('#contractinformationmodalTo').val($('#contractto')[0].textContent);
        }

        function function_otherinformationmodal(obj) {
            $('#otherinformationmodal').modal('show');
            $('#otherinformationmodaluan').val($('#uan')[0].textContent);
            $('#otherinformationmodalemergency').val($('#emergencycontact')[0].textContent);
            $('#otherinformationmodalwage').val($('#wages')[0].textContent.split('(')[0]);
            if ($('#wages')[0].textContent.split('(')[0] == "Minimum Wages") {
                $('#otherinformationmodalsubwagediv').show(); $('#divspecialsalary').hide();
                $('#otherinformationmodalsubwage').val(subcat);
            }
        }

        function function_edit_deactive() {
            $.ajax({
                type: "POST",
                url: "empdt.aspx/employeeterminate",
                dataType: "json",
                data: JSON.stringify({ typ: "2", aadhar: $('#terminationaadhar').val(), status: $('#ddl_terminationtype').val(), lastdate: $('#terminationdate').val(), reason: $('#terminationreason').val() }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var response = eval(data.d);
                        console.log("response", response);
                        if (response.length > 0) {
                            $('#edit_employee').modal('hide');
                            left(response[0].TXT);

                        }
                    }
                }
            });
        }



        function function_contract_update() {
            $.ajax({
                type: "POST",
                url: "empdt.aspx/contract_update",
                dataType: "json",
                data: JSON.stringify({ typ: "1C", aadhar: $('#aadharid')[0].textContent, mode: $('#contractinformationmodalmode').val(), from: $('#contractinformationmodalfrom').val(), to: $('#contractinformationmodalTo').val() }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var response = eval(data.d);
                        console.log("response", response);
                        if (response.length > 0) {
                            $('#contractinformationmodal').modal('hide');
                            left(response[0].TXT);

                        }
                    }
                }
            });
        }
        function function_other_update() {
            $.ajax({
                type: "POST",
                url: "empdt.aspx/other_update",
                dataType: "json",
                data: JSON.stringify({ typ: "1D", aadhar: $('#aadharid')[0].textContent, uan: $('#otherinformationmodaluan').val(), emergencycontact: $('#otherinformationmodalemergency').val(), categorywage: $('#otherinformationmodalwage').val(), subcategorywage: $('#otherinformationmodalsubwage').val() }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var response = eval(data.d);
                        console.log("response", response);
                        if (response.length > 0) {
                            $('#otherinformationmodal').modal('hide');
                            left(response[0].TXT);

                        }
                    }
                }
            });
        }
        function functionupdate_personal_info_modal() {
            $.ajax({
                type: "POST",
                url: "empdt.aspx/employeepersonalinfo",
                dataType: "json",
                data: JSON.stringify({ typ: "1A", aadhar: $('#aadharid')[0].textContent, ano: $('#personal_info_modal_altnumber').val(), fathername: $('#personal_info_modal_father').val(), esic: $('#personal_info_modal_esic').val(), voterid: $('#personal_info_modal_voterid').val(), noj: $('#personal_info_modal_ddl_noj').val(), vendor: $('#personal_info_modal_ddl_vendor').val() }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var response = eval(data.d);
                        console.log("response", response);
                        if (response.length > 0) {
                            $('#personal_info_modal').modal('hide');
                            left(response[0].TXT);

                        }
                    }
                }
            });
        }

        function func_bankinfosave() {
            $.ajax({
                type: "POST",
                url: "empdt.aspx/employeebanksave",
                dataType: "json",
                data: JSON.stringify({ typ: "1B", aadhar: $('#aadharid')[0].textContent, modalbankname: $('#modalbankname').val(), modalaccountno: $('#modalaccountno').val(), modalifsc: $('#modalifsc').val(), modalpanno: $('#modalpanno').val(), modalmicr: $('#modalmicr').val(), modalpf: $('#modalpf').val() }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var response = eval(data.d);
                        console.log("response", response);
                        if (response.length > 0) {
                            $('#bank_details_modal').modal('hide');
                            left(response[0].TXT);

                        }
                    }
                }
            });
        }

        function addmoreeducation() {
            var educationdivdetail = '';
            educationdivdetail += '<div class="row"><div class="col-sm-12"><hr style="	background-color: #fff; border-top: 2px dashed #8c8b8b;"></div><div class="col-md-6"><div class="form-group form-focus"><input type="text" class="form-control floating"><label class="focus-label">Institution</label></div></div>';
            educationdivdetail += '<div class="col-md-6"><div class="form-group form-focus"><input type="text" class="form-control floating"><label class="focus-label">Subject</label></div></div><div class="col-md-6"><div class="form-group form-focus"><div class="cal-icon">';
            educationdivdetail += '<input type="text" class="form-control floating datetimepicker"></div><label class="focus-label">Starting Date</label></div></div><div class="col-md-6"><div class="form-group form-focus"><div class="cal-icon"><input type="text" class="form-control floating datetimepicker"></div>';
            educationdivdetail += '<label class="focus-label">Complete Date</label></div></div><div class="col-md-6"><div class="form-group form-focus"><input type="text" class="form-control floating"><label class="focus-label">Degree</label></div></div><div class="col-md-6"><div class="form-group form-focus"><input type="text" class="form-control floating"><label class="focus-label">Grade</label></div>';
            educationdivdetail += '</div></div>';
            $('#educationdivadd').append(educationdivdetail);

        }
        var eductioncnt = 1;
        function addmoreeducationupdate() {
            var educationdivdetailupdate = '';
            educationdivdetailupdate += '<div class="col-sm-12"><hr style="	background-color: #fff; border-top: 2px dashed #8c8b8b;"></div><div class="col-md-6"><div class="form-group form-focus"><input type="text" class="form-control floating" id="education_infomodalinstittute_' + eductioncnt + '"><label class="focus-label">Institution</label></div></div>';
            educationdivdetailupdate += '<div class="col-md-6"><div class="form-group form-focus"><input type="text" class="form-control floating" id="education_infomodalsubject_' + eductioncnt + '"><label class="focus-label">Subject</label></div></div><div class="col-md-6"><div class="form-group form-focus"><div class="cal-icon">';
            educationdivdetailupdate += '<input type="text" class="form-control floating datetimepicker" id="education_infomodalstartdate_' + eductioncnt + '"></div><label class="focus-label">Starting Date</label></div></div><div class="col-md-6"><div class="form-group form-focus"><div class="cal-icon"><input type="text" class="form-control floating datetimepicker" id="education_infomodalcompletedate_' + eductioncnt + '"></div>';
            educationdivdetailupdate += '<label class="focus-label">Complete Date</label></div></div><div class="col-md-6"><div class="form-group form-focus"><input type="text" class="form-control floating" id="education_infomodaldegree_' + eductioncnt + '"><label class="focus-label">Degree</label></div></div><div class="col-md-6"><div class="form-group form-focus"><input type="text" class="form-control floating" id="education_infomodalgrade_' + eductioncnt + '"><label class="focus-label">Grade</label></div>';
            educationdivdetailupdate += '</div>';
            eductioncnt = eductioncnt + 1;
            $('#updateeducationdiv').append(educationdivdetailupdate);

        }

        var experiencecnt = 1;
        function addmoreexperienceupdate() {
            var educationdivdetailupdate = '';
            educationdivdetailupdate += '<div class="col-sm-12"><hr style="	background-color: #fff; border-top: 2px dashed #8c8b8b;"></div><div class="col-md-6"><div class="form-group form-focus"><input type="text" class="form-control floating" id="experience_info_company_' + experiencecnt + '"><label class="focus-label">Company Name</label></div></div>';
            educationdivdetailupdate += '<div class="col-md-6"><div class="form-group form-focus"><input type="text" class="form-control floating" id="experience_info_location_' + experiencecnt + '"><label class="focus-label">Location</label></div></div><div class="col-md-6"><div class="form-group form-focus"><input type="text" class="form-control floating" id="experience_info_to_' + experiencecnt + '"><label class="focus-label">Job Position</label></div></div>';
            educationdivdetailupdate += '<div class="col-md-6"><div class="form-group form-focus"><div class="cal-icon"><input type="text" class="form-control floating datetimepicker" id="experience_info_position_' + experiencecnt + '"></div><label class="focus-label">Period From</label></div></div><div class="col-md-6"><div class="form-group form-focus"><div class="cal-icon"><input type="text" class="form-control floating datetimepicker" id="experience_info_from_' + experiencecnt + '"></div>';
            educationdivdetailupdate += '<label class="focus-label">Period To</label></div></div>';
            educationdivdetailupdate += '</div>';
            experiencecnt = experiencecnt + 1;
            $('#updateexperiencedivdiv').append(educationdivdetailupdate);

        }
        function addmoreexperience() {
            var experiencedivdetails = '';
            experiencedivdetails += '<div class="row"><div class="col-sm-12"><hr style="background-color: #fff; border-top: 2px dashed #8c8b8b;"></div><div class="col-md-6"><div class="form-group form-focus"><input type="text" class="form-control floating"><label class="focus-label">Company Name</label></div></div><div class="col-md-6"><div class="form-group form-focus"><input type="text" class="form-control floating"><label class="focus-label">Location</label></div></div>';
            experiencedivdetails += '<div class="col-md-6"><div class="form-group form-focus"><input type="text" class="form-control floating"><label class="focus-label">Job Position</label></div></div><div class="col-md-6"><div class="form-group form-focus"><div class="cal-icon"><input type="text" class="form-control floating datetimepicker"></div>';
            experiencedivdetails += '<label class="focus-label">Period From</label></div></div><div class="col-md-6"><div class="form-group form-focus"><div class="cal-icon"> <input type="text" class="form-control floating datetimepicker"></div><label class="focus-label">Period To</label></div></div></div>';
            $('#experiencedivadd').append(experiencedivdetails);
        }


        var eductiondetailsarray = [];
        function education_infoupdate() {
            eductiondetailsarray.push({ Institute: $('#education_infomodalinstittute').val(), Subject: $('#education_infomodalsubject').val(), startingdate: $('#education_infomodalstartdate').val(), completiondate: $('#education_infomodalcompletedate').val(), degree: $('#education_infomodaldegree').val(), grade: $('#education_infomodalgrade').val() });
            for (var m = 1; m < eductioncnt; m++) {
                eductiondetailsarray.push({ Institute: $('#education_infomodalinstittute_' + m + '').val(), Subject: $('#education_infomodalsubject_' + m + '').val(), startingdate: $('#education_infomodalstartdate_' + m + '').val(), completiondate: $('#education_infomodalcompletedate_' + m + '').val(), degree: $('#education_infomodaldegree_' + m + '').val(), grade: $('#education_infomodalgrade_' + m + '').val() });
            }
            $.ajax({

                url: 'Empdt.aspx/updateeducation',

                type: "POST",

                dataType: "json",

                data: JSON.stringify({ empcode: '', updationuser: $('#aadharid')[0].textContent, updatededucation: eductiondetailsarray }),

                contentType: "application/json; charset=utf-8",

                success: function (data) {
                    var response = eval(data.d);
                    console.log("response", response);
                    if (response.length > 0) {
                        left(response[0].TXT);

                    }
                }, error: function (err) {
                    console.log(err);
                }

            });
        }

        var experiencedetailsarray = [];
        function function_experienceupdate() {
            experiencedetailsarray.push({ company: $('#experience_info_company').val(), location: $('#experience_info_location').val(), position: $('#experience_info_position').val(), startingdate: $('#experience_info_from').val(), completiondate: $('#experience_info_to').val() });
            for (var mn = 1; mn < experiencecnt; mn++) {
                experiencedetailsarray.push({ company: $('#experience_info_company_' + mn + '').val(), location: $('#experience_info_location_' + mn + '').val(), position: $('#experience_info_position_' + mn + '').val(), startingdate: $('#experience_info_from_' + mn + '').val(), completiondate: $('#experience_info_to_' + mn + '').val() });
            }
            $.ajax({

                url: 'Empdt.aspx/updateexperiencemethod',

                type: "POST",

                dataType: "json",

                data: JSON.stringify({ empcode: '', updationuser: $('#aadharid')[0].textContent, updateexperience: experiencedetailsarray }),

                contentType: "application/json; charset=utf-8",

                success: function (data) {
                    console.log(data.length);
                    var response = eval(data.d);
                    console.log("response", response);
                    if (response.length > 0) {
                        left(response[0].TXT);

                    }
                }, error: function (err) {
                    console.log(err);
                }

            });
        }


        var ddl_subdivaddnewvar;
        function getsubdiv(obj) {
            $('#ddl_subdivaddnew').empty();
            var division = obj.value;
            $.ajax({
                type: "POST",
                url: "empdt.aspx/getadata",
                dataType: "json",
                data: JSON.stringify({ typ: "2", ddlvalue: obj.value }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var getvalue = eval(data.d);
                        console.log("getvalue", getvalue);
                        if (getvalue.length > 0) {
                            ddl_subdivaddnewvar = document.getElementById("<%=ddl_subdivaddnew.ClientID %>");
                            AddOptionsubdiv("--Select--", "0");
                            for (var i = 0; i < getvalue.length; i++) {
                                AddOptionsubdiv(getvalue[i].SUB_DIV, getvalue[i].SUB_DIV_CODE);
                            }
                        }
                    }
                }
            });
        }
        function AddOptionsubdiv(text, value) {
            var option = document.createElement('option');
            option.value = value;
            option.innerHTML = text;
            ddl_subdivaddnewvar.options.add(option);
        }

        function getsubdivmodal(obj, subdivvalue) {
            $('#profilemodalsubdivision').empty();
            var division = (obj.value == undefined ? obj[0].value : obj.value);
            $.ajax({
                type: "POST",
                url: "empdt.aspx/getadata",
                dataType: "json",
                data: JSON.stringify({ typ: "2", ddlvalue: division }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var getvalue = eval(data.d);
                        console.log("getvalue", getvalue);
                        if (getvalue.length > 0) {
                            profilemodalsubdivision = document.getElementById("<%=profilemodalsubdivision.ClientID %>");
                            AddOptionsubdivmodal("--Select--", "0");
                            for (var i = 0; i < getvalue.length; i++) {
                                AddOptionsubdivmodal(getvalue[i].SUB_DIV, getvalue[i].SUB_DIV_CODE);
                            }
                        }
                        $('#profilemodalsubdivision').val(subdivvalue);
                    }
                }
            });
        }

        function AddOptionsubdivmodal(text, value) {
            var option = document.createElement('option');
            option.value = value;
            option.innerHTML = text;
            profilemodalsubdivision.options.add(option);
        }



        var ddl_cityaddnewvar;
        var profilemodalcity;
        function getcity(obj) {
            $('#ddl_cityaddnew').empty();
            $('#profilemodalcity').empty();
            var division = obj.value;
            $.ajax({
                type: "POST",
                url: "empdt.aspx/getadata",
                dataType: "json",
                data: JSON.stringify({ typ: "3", ddlvalue: obj.value }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var getvalue = eval(data.d);
                        console.log("getvalue", getvalue);
                        if (getvalue.length > 0) {
                            ddl_cityaddnewvar = document.getElementById("<%=ddl_cityaddnew.ClientID %>");
                            AddOptioncity("--Select--", "0");
                            for (var i = 0; i < getvalue.length; i++) {
                                AddOptioncity(getvalue[i].CITY_NM, getvalue[i].CITY_CD);
                            }
                        }
                    }
                }
            });
        }


        function AddOptioncity(text, value) {
            var option = document.createElement('option');
            option.value = value;
            option.innerHTML = text;
            ddl_cityaddnewvar.options.add(option);
        }

        function getcityprofilemodal(obj, cityvalue) {
            $('#profilemodalcity').empty();
            var division = (obj.value == undefined ? obj[0].value : obj.value);
            $.ajax({
                type: "POST",
                url: "empdt.aspx/getadata",
                dataType: "json",
                data: JSON.stringify({ typ: "3", ddlvalue: division }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var getvalue = eval(data.d);
                        console.log("getvalue", getvalue);
                        if (getvalue.length > 0) {
                            profilemodalcity = document.getElementById("<%=profilemodalcity.ClientID %>");
                            AddOptioncitymodalprofile("--Select--", "0");
                            for (var i = 0; i < getvalue.length; i++) {
                                AddOptioncitymodalprofile(getvalue[i].CITY_NM, getvalue[i].CITY_CD);
                            }
                        }
                        $('#profilemodalcity').val(cityvalue);
                    }
                }
            });
        }

        function getcityprofilemodalpermanent(obj, cityvalue) {
            $('#profilemodalcity').empty();
            var division = (obj.value == undefined ? obj[0].value : obj.value);
            $.ajax({
                type: "POST",
                url: "empdt.aspx/getadata",
                dataType: "json",
                data: JSON.stringify({ typ: "3", ddlvalue: division }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var getvalue = eval(data.d);
                        console.log("getvalue", getvalue);
                        if (getvalue.length > 0) {
                            profilemodalcity = document.getElementById("<%=profilemodalpermanentcity.ClientID %>");
                            AddOptioncitymodalprofile("--Select--", "0");
                            for (var i = 0; i < getvalue.length; i++) {
                                AddOptioncitymodalprofile(getvalue[i].CITY_NM, getvalue[i].CITY_CD);
                            }
                        }
                        $('#profilemodalcity').val(cityvalue);
                    }
                }
            });
        }

        function getcityprofilemodalpermanent(obj, cityvalue) {
            $('#profilemodalpermanentcity').empty();
            var division = (obj.value == undefined ? obj[0].value : obj.value);
            $.ajax({
                type: "POST",
                url: "empdt.aspx/getadata",
                dataType: "json",
                data: JSON.stringify({ typ: "3", ddlvalue: division }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var getvalue = eval(data.d);
                        console.log("getvalue", getvalue);
                        if (getvalue.length > 0) {
                            profilemodalcity = document.getElementById("<%=profilemodalpermanentcity.ClientID %>");
                            AddOptioncitymodalprofile("--Select--", "0");
                            for (var i = 0; i < getvalue.length; i++) {
                                AddOptioncitymodalprofile(getvalue[i].CITY_NM, getvalue[i].CITY_CD);
                            }
                        }
                        $('#profilemodalpermanentcity').val(cityvalue);
                    }
                }
            });
        }

        function AddOptioncitymodalprofile(text, value) {
            var option = document.createElement('option');
            option.value = value;
            option.innerHTML = text;
            profilemodalcity.options.add(option);
        }

        function funcprofilemodaldatasave() {
            var data = new FormData();
            var files = '';
            var fileUploadbill = $("#blahprofileinformation").get(0);
            files = fileUploadbill.src;
            data.append("files", files);

            if (files == "http://placehold.it/120x120") {
                alert("Pic Mandatory");
            } else {
                files = files
                data.append("fname", $('#profilemodalempname').val());
                data.append("lname", $('#profilemodalemplastname').val());
                data.append("empid", $('#profilemodalempid').val());

                data.append("brplid", $('#profilemodaluid').val());
                data.append("aadhar", $('#profilemodalaadhar').val());
                data.append("gender", $('#profilemodalgender').val());
                data.append("doj", $('#profilemodaldoj').val());
                data.append("dob", $('#profilemodaldob').val());
                data.append("address", $('#profilemodaladdress').val());
                data.append("reportto", $('#ddl_profileinforeport').val());
                data.append("phone", $('#profilemodalphone').val());
                data.append("department", $('#ddl_profileinfodepartment').val());
                data.append("designation", $('#ddl_profileinfodesignation').val());
                data.append("email", $('#txt_profileinfomailid').val());
                data.append("state", $('#profilemodalstate').val());
                data.append("city", $('#profilemodalcity').val());

                data.append("profilemodalpermanentaddress", $('#profilemodalpermanentaddress').val());
                data.append("profilemodalpermanentstate", $('#profilemodalpermanentstate').val());
                data.append("profilemodalpermanentcity", $('#profilemodalpermanentcity').val());

                data.append("division", $('#profilemodaldivision').val());
                data.append("subdivision", $('#profilemodalsubdivision').val());
                data.append("picname", refpic);
                $.ajax({
                    url: 'profilemodaldatasave.ashx',
                    type: 'POST',
                    data: data,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (file) {
                        console.log("file", file);
                        $('#profile_info').modal('hide');
                        left(file.name)
                    },
                    xhr: function () {
                        var fileXhr = $.ajaxSettings.xhr();
                        if (fileXhr.upload) {
                            $("progress").show();
                            fileXhr.upload.addEventListener("progress", function (e) {
                                if (e.lengthComputable) {
                                    $("#fileProgress").attr({
                                        value: e.loaded,
                                        max: e.total
                                    });
                                }
                            }, false);
                        }
                        return fileXhr;
                    }
                });
            }
        }
    </script>
    <script>
        function funcaddnewmodaldatasave() {
            var data = new FormData();
            var files = '';
            var fileUploadbill = $("#blah").get(0);
            files = fileUploadbill.src;
            data.append("files", files);
            if (files == "http://placehold.it/120x120") {
                alert("Pic Mandatory");
            } else {
                files = files
                data.append("Ename", $('#addmodalname').val());
                data.append("father", $('#addmodalfathername').val());
                data.append("brplid", $('#addmodalbrpluid').val());
                data.append("empid", $('#addmodalempid').val());
                data.append("aadhar", $('#addmodalaadhar').val());
                data.append("email", $('#addmodalemail').val());
                data.append("doj", $('#addmodaljoiningdate').val());
                data.append("dob", $('#addmodaldob').val());
                data.append("phone", $('#addmodalphone').val());
                data.append("alternate", $('#addmodalalternate').val());
                data.append("vendor", $('#ddl_venaddnew').val());
                data.append("department", $('#ddl_deptaddnew').val());
                data.append("designation", $('#ddl_desgaddnew').val());
                data.append("reportto", $('#ddl_reportingaddnewmodal').val());
                data.append("gender", $('#addmodalgender').val());
                data.append("country", $('#addmodalcountry').val());
                data.append("division", $('#ddl_divaddnew').val());
                data.append("subdivision", $('#ddl_subdivaddnew').val());
                data.append("state", $('#ddl_stateaddnew').val());
                data.append("city", $('#ddl_cityaddnew').val());
                data.append("address", $('#addmodaladdress').val());

                data.append("landmark", $('#addmodallandmark').val());
                data.append("pincode", $('#addmodalpincode').val());
                data.append("contractmode", $('#addmodalcontractmode').val());
                data.append("contractfrom", $('#addmodalcontractfrom').val());
                data.append("contractto", $('#addmodalcontractto').val());
                data.append("uan", $('#addmodaluan').val());
                data.append("emergency", $('#addmodalemergencycontact').val());
                data.append("wage", $('#addmodalwage').val());
                data.append("voterid", $('#addmodalvoterid').val());
                data.append("noj", $('#ddl_nojaddnewmodal').val());
                data.append("picname", $('#addmodalaadhar').val());

                data.append("approvalno", $('#approvalno').val());
                data.append("workorderno", $('#workorderno').val());

                data.append("jointype", $('#Selectjointype').val());

                if ($('#Selectjointype').val() == "Replacement") {
                    data.append("replacementid", $('#replacementid').val());
                } else { data.append("replacementid", ""); }
                $.ajax({
                    url: 'addnewmodal.ashx',
                    type: 'POST',
                    data: data,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (file) {
                        console.log("file", file);
                        $('#add_employee').modal('hide');
                        left(file.name);
                    },
                    xhr: function () {
                        var fileXhr = $.ajaxSettings.xhr();
                        if (fileXhr.upload) {
                            $("progress").show();
                            fileXhr.upload.addEventListener("progress", function (e) {
                                if (e.lengthComputable) {
                                    $("#fileProgress").attr({
                                        value: e.loaded,
                                        max: e.total
                                    });
                                }
                            }, false);
                        }
                        return fileXhr;
                    }
                });
            }
        }
    </script>

    <script>
        $(function () {
            $('form').validator({
                validHandlers: {
                    '.customhandler': function (input) {
                        //may do some formatting before validating
                        input.val(input.val().toUpperCase());
                        //return true if valid
                        return input.val() === 'JQUERY' ? true : false;
                    }
                }
            });

            $('form').submit(function (e) {
                e.preventDefault();

                //if ($('form').validator('check') < 1) {
                //    left('Hurray, your information will be saved!');
                //}
            })
        })
    </script>


    <script>
        $('document').ready(function () {
            $('#addmodalbrpluid').on('blur', function () {
                var username = $('#addmodalbrpluid').val();
                if (username == '') {
                    username_state = false;
                    return;
                }
                $.ajax({
                    type: "POST",
                    url: "empdt.aspx/checkbrpluid",
                    dataType: "json",
                    data: JSON.stringify({ empcode: username, type: "1I" }),
                    contentType: "application/json",
                    success: function (data) {
                        if (data.d.length > 0) {
                            var getvalue = eval(data.d);
                            console.log("getvalue", getvalue);
                            if (getvalue.length > 0) {
                                if (getvalue[0][0].CNT == "0") {
                                    $('#addmodalbrpluid').removeClass("is-invalid");
                                    $('#addmodalbrpluid').addClass("is-valid");

                                } else {
                                    $('#addmodalbrpluid').addClass("is-invalid");
                                    $('#addmodalbrpluid').after('<div class="help-block with-errors">UID already Exists</div>');

                                }
                            }
                        }
                    }
                });
            });


            $('#addmodalaadhar').on('blur', function () {
                var usernameempid = $('#addmodalaadhar').val();
                if (usernameempid == '') {
                    return;
                }
                $.ajax({
                    type: "POST",
                    url: "empdt.aspx/checkbrpluid",
                    dataType: "json",
                    data: JSON.stringify({ empcode: usernameempid, type: "1H" }),
                    contentType: "application/json",
                    success: function (data) {
                        if (data.d.length > 0) {
                            var getvalue = eval(data.d);
                            console.log("getvalue", getvalue);
                            if (getvalue.length > 0) {
                                if (getvalue[0][0].CNT == "0") {
                                    $('#addmodalaadhar').removeClass("is-invalid");
                                    $('#addmodalaadhar').addClass("is-valid");

                                } else {
                                    $('#addmodalaadhar').addClass("is-invalid");
                                    $('#addmodalaadhar').after('<div class="help-block with-errors">Aadhar already Exists</div>');

                                }
                            }
                        }
                    }
                });
            });

            $('#replacementid').on('blur', function () {
                var usernameempid = $('#replacementid').val();
                if (usernameempid == '') {
                    return;
                }
                $.ajax({
                    type: "POST",
                    url: "empdt.aspx/checkbrpluid",
                    dataType: "json",
                    data: JSON.stringify({ empcode: usernameempid, type: "1HH" }),
                    contentType: "application/json",
                    success: function (data) {
                        if (data.d.length > 0) {
                            var getvalue = eval(data.d);
                            console.log("getvalue", getvalue);
                            if (getvalue.length > 0) {
                                if (getvalue[0][0].AADHAR_CNT == "1" && getvalue[0][0].REPLACMNT_CNT == "0") {
                                    $('#replacementid').removeClass("is-invalid");
                                    $('#replacementid').addClass("is-valid");
                                } else {
                                    $('#replacementid').addClass("is-invalid");
                                    $('#replacementid').after('<div class="help-block with-errors">' + getvalue[0][0].TXT + '</div>');
                                }
                            }
                        }
                    }
                });
            });

        });

        function printDiv(divID) {
            //Get the HTML of div
            var divElements = document.getElementById(divID).innerHTML;
            //Get the HTML of whole page
            var oldPage = document.body.innerHTML;

            //Reset the page's HTML with div's HTML only
            document.body.innerHTML =
              "<html><head><title></title></head><body>" +
              divElements + "</body>";

            //Print Page
            window.print();

            //Restore orignal HTML
            document.body.innerHTML = oldPage;


        }

        var MW_AMOUNT = '';
        var AGENCY_MARGIN = '';
        function getamountbackdata() {
            $.ajax({
                type: "POST",
                url: "empdt.aspx/salarydata",
                dataType: "json",
                data: JSON.stringify({ dropdown: $('#otherinformationmodalsubwage').val(), type: "10" }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var getvalue = eval(data.d);
                        console.log("getvalue", getvalue);
                        MW_AMOUNT = getvalue[0][0].MW_AMOUNT;
                        AGENCY_MARGIN = getvalue[0][0].AGENCY_MARGIN;
                    }
                }
            });
        }



        function function_filldata() {
            var basis = $('#basic').val();
            $('#basicy').val((basis) * 12);
            $('#hra').val(((basis) * 40) / 100);
            $('#other').val(0);
            $('#agency').val(0);
            $('#hray').val((((basis) * 40) / 100) * 12);
            $('#gross').val(parseFloat(basis) + parseFloat($('#hra').val()) + parseFloat($('#other').val()));
            $('#grossy').val((parseFloat(basis) + parseFloat($('#hra').val()) + parseFloat($('#other').val())) * 12);
            $('#epf').val(((basis) * 13) / 100);
            $('#epfy').val((((basis) * 13) / 100) * 12);
            if (parseInt($('#gross').val()) < 21000) {
                $('#eesi').val(((parseFloat($('#gross').val() * 3.25)) / 100).toFixed(2));
                $('#eesiy').val(((parseFloat($('#gross').val() * 3.25)) / 100 * 12).toFixed(2));
            } else {
                $('#eesi').val(0);
                $('#eesiy').val(0 * 12);
            }
            $('#bonus').val((((MW_AMOUNT) * 8.33) / 100).toFixed(2));
            $('#bonusy').val(((((MW_AMOUNT) * 8.33) / 100) * 12).toFixed(2));
            $('#leave').val((((basis) * 4.81) / 100).toFixed(2));
            $('#leavey').val(((((basis) * 4.81) / 100) * 12).toFixed(2));
            if (parseInt($('#eesi').val()) == 0) {
                $('#insurance').val(120);
                $('#insurancey').val(120 * 12);
            } else {
                $('#insurance').val(0);
                $('#insurancey').val(0 * 12);
            }
            $('#statutary').val((parseFloat($('#epf').val()) + parseFloat($('#eesi').val()) + parseFloat($('#bonus').val()) + parseFloat($('#leave').val()) + parseFloat($('#insurance').val())).toFixed(2));
            $('#statutaryy').val(((parseFloat($('#epf').val()) + parseFloat($('#eesi').val()) + parseFloat($('#bonus').val()) + parseFloat($('#leave').val()) + parseFloat($('#insurance').val())) * 12).toFixed(2));
           // $('#agency').val((((parseFloat($('#gross').val()) + parseFloat($('#statutary').val())) * AGENCY_MARGIN) / 100).toFixed(2));
            // $('#agencyy').val(((((parseFloat($('#gross').val()) + parseFloat($('#statutary').val())) * AGENCY_MARGIN) / 100) * 12).toFixed(2));
            $('#agencyy').val((parseFloat($('#agency').val())*12).toFixed(2));//added dated 03-nov-2020
            $('#totalemp').val((parseFloat($('#gross').val()) + parseFloat($('#statutary').val()) + parseFloat($('#agency').val())).toFixed(2));
            $('#totalempy').val((parseFloat($('#totalemp').val()) * 12).toFixed(2));
            $('#gpay').val(800);
            $('#totaly').val(((parseFloat($('#totalemp').val()) + parseFloat($('#gpay').val())) * 12).toFixed(2));
            $('#totalgsty').val((parseFloat($('#totaly').val() * 1.18)).toFixed(2));
        }



        function function_filldatarest() {
            var valueother = $('#other').val();
            $('#othery').val((valueother) * 12);
            $('#gross').val(parseFloat($('#basic').val()) + parseFloat($('#hra').val()) + parseFloat($('#other').val()));
            $('#grossy').val((parseFloat($('#basic').val()) + parseFloat($('#hra').val()) + parseFloat($('#other').val())) * 12);
            $('#epf').val((($('#basic').val()) * 13) / 100);
            $('#epfy').val(((($('#basic').val()) * 13) / 100) * 12);
            if (parseInt($('#gross').val()) < 21000) {
                $('#eesi').val(((parseFloat($('#gross').val() * 3.25)) / 100).toFixed(2));
                $('#eesiy').val(((parseFloat($('#gross').val() * 3.25)) / 100 * 12).toFixed(2));
            } else {
                $('#eesi').val(0);
                $('#eesiy').val(0 * 12);
            }
            $('#bonus').val((((MW_AMOUNT) * 8.33) / 100).toFixed(2));
            $('#bonusy').val(((((MW_AMOUNT) * 8.33) / 100) * 12).toFixed(2));
            $('#leave').val(((($('#basic').val()) * 4.81) / 100).toFixed(2));
            $('#leavey').val((((($('#basic').val()) * 4.81) / 100) * 12).toFixed(2));
            if (parseInt($('#eesi').val()) == 0) {
                $('#insurance').val(120);
                $('#insurancey').val(120 * 12);
            } else {
                $('#insurance').val(0);
                $('#insurancey').val(0 * 12);
            }
            $('#statutary').val((parseFloat($('#epf').val()) + parseFloat($('#eesi').val()) + parseFloat($('#bonus').val()) + parseFloat($('#leave').val()) + parseFloat($('#insurance').val())).toFixed(2));
            $('#statutaryy').val(((parseFloat($('#epf').val()) + parseFloat($('#eesi').val()) + parseFloat($('#bonus').val()) + parseFloat($('#leave').val()) + parseFloat($('#insurance').val())) * 12).toFixed(2));
           // $('#agency').val((((parseFloat($('#gross').val()) + parseFloat($('#statutary').val())) * AGENCY_MARGIN) / 100).toFixed(2));
            //$('#agencyy').val(((((parseFloat($('#gross').val()) + parseFloat($('#statutary').val())) * AGENCY_MARGIN) / 100) * 12).toFixed(2));
            $('#agencyy').val((parseFloat($('#agency').val()) * 12).toFixed(2));//added dated 03-nov-2020
            $('#totalemp').val((parseFloat($('#gross').val()) + parseFloat($('#statutary').val()) + parseFloat($('#agency').val())).toFixed(2));
            $('#totalempy').val((parseFloat($('#totalemp').val()) * 12).toFixed(2));
            $('#gpay').val(800);
            $('#totaly').val(((parseFloat($('#totalemp').val()) + parseFloat($('#gpay').val())) * 12).toFixed(2));
            $('#totalgsty').val((parseFloat($('#totaly').val() * 1.18)).toFixed(2));
        }
        function agencydatafill() { //added 03-nov-2020
            if ($('#agencytype').val() == "--Select--") { alert("Agency Type Required!!!"); } else {
                var valueother = $('#other').val();
                $('#othery').val((valueother) * 12);
                $('#gross').val(parseFloat($('#basic').val()) + parseFloat($('#hra').val()) + parseFloat($('#other').val()));
                $('#grossy').val((parseFloat($('#basic').val()) + parseFloat($('#hra').val()) + parseFloat($('#other').val())) * 12);
                $('#epf').val((($('#basic').val()) * 13) / 100);
                $('#epfy').val(((($('#basic').val()) * 13) / 100) * 12);
                if (parseInt($('#gross').val()) < 21000) {
                    $('#eesi').val(((parseFloat($('#gross').val() * 3.25)) / 100).toFixed(2));
                    $('#eesiy').val(((parseFloat($('#gross').val() * 3.25)) / 100 * 12).toFixed(2));
                } else {
                    $('#eesi').val(0);
                    $('#eesiy').val(0 * 12);
                }
                $('#bonus').val((((MW_AMOUNT) * 8.33) / 100).toFixed(2));
                $('#bonusy').val(((((MW_AMOUNT) * 8.33) / 100) * 12).toFixed(2));
                $('#leave').val(((($('#basic').val()) * 4.81) / 100).toFixed(2));
                $('#leavey').val((((($('#basic').val()) * 4.81) / 100) * 12).toFixed(2));
                if (parseInt($('#eesi').val()) == 0) {
                    $('#insurance').val(120);
                    $('#insurancey').val(120 * 12);
                } else {
                    $('#insurance').val(0);
                    $('#insurancey').val(0 * 12);
                }
                $('#statutary').val((parseFloat($('#epf').val()) + parseFloat($('#eesi').val()) + parseFloat($('#bonus').val()) + parseFloat($('#leave').val()) + parseFloat($('#insurance').val())).toFixed(2));
                $('#statutaryy').val(((parseFloat($('#epf').val()) + parseFloat($('#eesi').val()) + parseFloat($('#bonus').val()) + parseFloat($('#leave').val()) + parseFloat($('#insurance').val())) * 12).toFixed(2));
                // $('#agency').val((((parseFloat($('#gross').val()) + parseFloat($('#statutary').val())) * AGENCY_MARGIN) / 100).toFixed(2));
                //$('#agencyy').val(((((parseFloat($('#gross').val()) + parseFloat($('#statutary').val())) * AGENCY_MARGIN) / 100) * 12).toFixed(2));
                $('#agencyy').val((parseFloat($('#agency').val()) * 12).toFixed(2));//added dated 03-nov-2020
                $('#totalemp').val((parseFloat($('#gross').val()) + parseFloat($('#statutary').val()) + parseFloat($('#agency').val())).toFixed(2));
                $('#totalempy').val((parseFloat($('#totalemp').val()) * 12).toFixed(2));
                $('#gpay').val(800);
                $('#totaly').val(((parseFloat($('#totalemp').val()) + parseFloat($('#gpay').val())) * 12).toFixed(2));
                $('#totalgsty').val((parseFloat($('#totaly').val() * 1.18)).toFixed(2));

            }
        }

        function function_filldatanormal() {
            $.ajax({
                type: "POST",
                url: "empdt.aspx/salarydata",
                dataType: "json",
                data: JSON.stringify({ dropdown: $('#otherinformationmodalsubwage').val(), type: "10" }),
                beforesend: loadmyloading(),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var getvalue = eval(data.d);
                        console.log("getvalue", getvalue);
                        $('#minwage').val(getvalue[0][0].MW_AMOUNT);
                        var basisnormal = $('#minwage').val();
                        $('#minwagey').val(parseFloat((basisnormal) * 12).toFixed(2));
                        $('#normalpf').val(parseFloat((basisnormal * 13) / 100).toFixed(2));
                        $('#normalpfy').val(parseFloat(((basisnormal * 13) / 100) * 12).toFixed(2));
                        $('#normalesi').val(parseFloat((basisnormal * 3.25) / 100).toFixed(2));
                        $('#normalesiy').val(parseFloat(((basisnormal * 3.25) / 100) * 12).toFixed(2));
                        $('#normalbonus').val(parseFloat((basisnormal * 8.33) / 100).toFixed(2));
                        $('#normalbonusy').val(parseFloat(((basisnormal * 8.33) / 100) * 12).toFixed(2));
                        $('#normalleave').val(parseFloat((basisnormal * 4.81) / 100).toFixed(2));
                        $('#normalleavey').val(parseFloat(((basisnormal * 4.81) / 100) * 12).toFixed(2));
                       // $('#normalagency').val(getvalue[0][0].AGENCY_MARGIN);
                        //$('#normalagencyy').val(getvalue[0][0].AGENCY_MARGIN);
                        $('#normalagency').val("0"); // added 03-nov-2020
                        $('#normalagencyy').val($('#normalagency').val()*12); // added 03-nov-2020
                        $('#normaltotal').val(parseFloat($('#minwage').val()) + parseFloat($('#normalpf').val()) + parseFloat($('#normalesi').val()) + parseFloat($('#normalbonus').val()) + parseFloat($('#normalleave').val()));
                        $('#normaltotaly').val(((parseFloat($('#minwagey').val()) + parseFloat($('#normalpf').val()) + parseFloat($('#normalesi').val()) + parseFloat($('#normalbonus').val()) + parseFloat($('#normalleave').val())) * 12).toFixed(2));
                        //                        $('#normalfinalized').val((parseFloat($('#normaltotal').val()) + parseFloat($('#normalagency').val()).toFixed(2));
                        $('#normalfinalized').val((parseFloat($('#normaltotal').val()) + parseFloat($('#normalagency').val())).toFixed(2));
                        //$('#normalfinalizedy').val(((parseFloat($('#normaltotal').val()) + (parseFloat($('#normaltotal').val()) * parseFloat($('#normalagency').val())) / 100) * 12).toFixed(2));
                        $('#normalfinalizedy').val((parseFloat($('#normaltotal').val()) + parseFloat($('#normalagency').val())*12).toFixed(2));
                        $('#normalgpa').val(parseFloat(800));
                        $('#normaltotalcost').val((parseFloat($('#normalfinalizedy').val()) + parseFloat($('#normalgpa').val())).toFixed(2));
                        $('#normaltotalcostgst').val(((parseFloat($('#normaltotalcost').val()) * 1.18)).toFixed(2));


                    }
                    removemyloading();
                }

            });
            removemyloading();
        }

        function normalgencykeyup() {    //for agency margin add  added 03-nov-2020     
            if ($('#normalagencytype').val() == "--Select--") {
                alert("Agency Type Required!!!");
            } else {
                var basisnormal = $('#minwage').val();
                $('#minwagey').val(parseFloat((basisnormal) * 12).toFixed(2));
                $('#normalpf').val(parseFloat((basisnormal * 13) / 100).toFixed(2));
                $('#normalpfy').val(parseFloat(((basisnormal * 13) / 100) * 12).toFixed(2));
                $('#normalesi').val(parseFloat((basisnormal * 3.25) / 100).toFixed(2));
                $('#normalesiy').val(parseFloat(((basisnormal * 3.25) / 100) * 12).toFixed(2));
                $('#normalbonus').val(parseFloat((basisnormal * 8.33) / 100).toFixed(2));
                $('#normalbonusy').val(parseFloat(((basisnormal * 8.33) / 100) * 12).toFixed(2));
                $('#normalleave').val(parseFloat((basisnormal * 4.81) / 100).toFixed(2));
                $('#normalleavey').val(parseFloat(((basisnormal * 4.81) / 100) * 12).toFixed(2));
                $('#normalagencyy').val($('#normalagency').val() * 12); // added 03-nov-2020
                $('#normaltotal').val(parseFloat($('#normalagency').val()) + parseFloat($('#minwage').val()) + parseFloat($('#normalpf').val()) + parseFloat($('#normalesi').val()) + parseFloat($('#normalbonus').val()) + parseFloat($('#normalleave').val()));
                $('#normaltotaly').val(((parseFloat($('#normalagency').val()) + parseFloat($('#minwagey').val()) + parseFloat($('#normalpf').val()) + parseFloat($('#normalesi').val()) + parseFloat($('#normalbonus').val()) + parseFloat($('#normalleave').val())) * 12).toFixed(2));
                $('#normalfinalized').val((parseFloat($('#normaltotal').val()) + parseFloat($('#normalagency').val())).toFixed(2));
                $('#normalfinalizedy').val((parseFloat($('#normaltotal').val()) + parseFloat($('#normalagency').val()) * 12).toFixed(2));
                $('#normalgpa').val(parseFloat(800));
                $('#normaltotalcost').val((parseFloat($('#normalfinalizedy').val()) + parseFloat($('#normalgpa').val())).toFixed(2));
                $('#normaltotalcostgst').val(((parseFloat($('#normaltotalcost').val()) * 1.18)).toFixed(2));
            }

        }


        function savesalarydetails() {
            $.ajax({
                type: "POST",
                url: "empdt.aspx/employeesalarysave",
                dataType: "json",
                data: JSON.stringify({
                    typ: "11", aadhar: $('#aadharid')[0].textContent, wages: $('#otherinformationmodalwage').val(), subwages: $('#otherinformationmodalsubwage').val(), basic: $('#basic').val(), hra: $('#hra').val(), otherallowance: $('#other').val()
                    , gross: $('#gross').val(), pf: $('#epf').val(), esic: $('#eesi').val(), bonus: $('#bonus').val(), leave: $('#leave').val(), insurance: $('#insurance').val(), statuaory: $('#statutary').val(), agency: $('#agency').val(), totalpermonth: $('#totalemp').val(),
                    costperannum: $('#totalempy').val(), gpa: $('#gpay').val(), totalcost: $('#totaly').val(), totalcostgst: $('#totalgsty').val(), mobile: $('#mobileamount').val(), Conveyance: $('#conveyanceamount').val()
                }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var response = eval(data.d);
                        console.log("response", response);
                        if (response.length > 0) {
                            left(response[0].TXT);

                        }
                    }
                }
            });
        }

        function savesalarynormaldetails() {
            $.ajax({
                type: "POST",
                url: "empdt.aspx/employeesalarysave",
                dataType: "json",
                data: JSON.stringify({
                    typ: "11", aadhar: $('#aadharid')[0].textContent, wages: $('#otherinformationmodalwage').val(), subwages: $('#otherinformationmodalsubwage').val(), basic: $('#minwage').val(), hra: "", otherallowance: ""
                    , gross: $('#minwage').val(), pf: $('#normalpf').val(), esic: $('#normalesi').val(), bonus: $('#normalbonus').val(), leave: $('#normalleave').val(), insurance: "", statuaory: "", agency: $('#normalagency').val(), totalpermonth: $('#normalfinalized').val(),
                    costperannum: $('#normalfinalizedy').val(), gpa: $('#normalgpa').val(), totalcost: $('#normaltotalcost').val(), totalcostgst: $('#normaltotalcostgst').val(), mobile: "", Conveyance: ""
                }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var response = eval(data.d);
                        console.log("response", response);
                        if (response.length > 0) {
                            left(response[0].TXT);

                        }
                    }
                }
            });
        }

        var z = 0;
        function addmoredocument() {
            debugger;
            var rowadd = '';
            var filesbill = 'filesbill_' + z;
            var filenamebill = 'filenamebill_' + z;
            var ddldoctype = 'ddl_doctype_' + z;
            var tableSelect = "<select name='ctl00$ContentPlaceHolder1$" + ddldoctype + "' id='" + ddldoctype + "' class='form-control'>";
            $.each($('#ddl_doctype')[0].options, function (key, data) {
                console.log(data);
                tableSelect += '<option value="' + data.value + '">' + data.text + '</option>';
            });
            tableSelect += "</select>";
            rowadd += " <div class='col-sm-3'>" + tableSelect + "</div>";
            rowadd += " <div class='col-sm-3'>";
            rowadd += " <a class='btn btn-primary edit-btn' onclick=\"BrowseFile('" + filesbill + "');\" >";
            rowadd += " <i class='fa fa-paperclip'></i></a>";
            rowadd += "<div class='file-field'>";
            rowadd += " <span id='filenamebill_" + z + "' class='text-success'></span>";
            rowadd += " <input type='file' name='ctl00$ContentPlaceHolder1$filesbill_" + z + "' id='" + filesbill + "' accept='application/pdf' onchange=\"onChange_FileUpload(this,'" + filenamebill + "')\" style='display: none'>";
            rowadd += " </div>";
            rowadd += "</div>";
            $('#addmoredocumentdiv').append(rowadd);
            z = z + 1;

        }


        function documentsave() {
            debugger;
            var doctype = [];
            var doc = [];
            var dataD = '';
            var cano = aadhar;
            if ($('#filenamebill')[0].innerHTML == "") {
                alert("Required Document must upload");

            } else {
                var data = new FormData();
                var files = '';
                var fileUploadbilldynamic = '';
                var fileUploadbill = $("#filesbill").get(0);
                doctype.push($('#ddl_doctype')[0].value);
                doc.push($('#filenamebill')[0].innerHTML);
                files = fileUploadbill.files;
                for (var i = 0; i < files.length; i++) {
                    data.append(files[i].name, files[i]);

                }
                for (var k = 0; k < z; k++) {
                    var a = $("#filesbill_" + k + "").get(0);
                    fileUploadbilldynamic = $("#filesbill_" + k + "").get(0);
                    files = fileUploadbilldynamic.files;
                    doctype.push($('#ddl_doctype_' + k + '')[0].value);
                    doc.push($('#filenamebill_' + k + '')[0].innerHTML);
                    for (var m = 0; m < files.length; m++) {
                        data.append(files[m].name, files[m]);

                    }
                }
                data.append("aadhar", cano);
                data.append("doctype", doctype.toString());
                data.append("doc", doc.toString());
                $.ajax({
                    url: 'Handler.ashx',
                    type: 'POST',
                    data: data,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (file) {
                        console.log("file", file);
                        left(file.name);
                    },
                    xhr: function () {
                        var fileXhr = $.ajaxSettings.xhr();
                        if (fileXhr.upload) {
                            $("progress").show();
                            fileXhr.upload.addEventListener("progress", function (e) {
                                if (e.lengthComputable) {
                                    $("#fileProgress").attr({
                                        value: e.loaded,
                                        max: e.total
                                    });
                                }
                            }, false);
                        }
                        return fileXhr;
                    }
                });
            }
        }
        function pdfdownloadfunc(obj) {
            setTimeout(function () { window.location.href = window.location.href.replace(window.location.pathname.split("/").pop(), "") + "ViewDocapp_dwn_pdf.aspx" + "?pdf_nm=" + obj.id }, 1000);
        }

        var familycnt = 0;
        function familyaddmore() {
            familycnt = familycnt + 1;
            var familydiv = '';
            familydiv += ' <div class="col-md-6">';
            familydiv += '<div class="form-group">';
            familydiv += '<label>Name <span class="text-danger">*</span></label>';
            familydiv += '<input class="form-control" type="text" id="familyname_' + familycnt + '" />';
            familydiv += '</div>';
            familydiv += '</div>';
            familydiv += '<div class="col-md-6">';
            familydiv += '<div class="form-group">';
            familydiv += '<label>Relationship <span class="text-danger">*</span></label>';
            familydiv += '<select class="form-control" data-error-msg="Gender Required" id="familytype_' + familycnt + '">';
            familydiv += '<option>--Select--</option>';
            familydiv += '<option>Father</option>';
            familydiv += '<option>Mother</option>';
            familydiv += '<option>Spouse</option>';
            familydiv += '<option>Son</option>';
            familydiv += '<option>Daughter</option>';
            familydiv += '</select>';
            familydiv += '</div>';
            familydiv += '</div>';
            familydiv += '<div class="col-md-6">';
            familydiv += '<div class="form-group">';
            familydiv += '<label>Date of birth <span class="text-danger">*</span></label>';
            familydiv += '<input class="form-control datetimepicker" type="text" id="familydob_' + familycnt + '" />';
            familydiv += '</div>';
            familydiv += '</div>';
            familydiv += '<div class="col-md-6">';
            familydiv += '<div class="form-group">';
            familydiv += '<label>Phone <span class="text-danger">*</span></label>';
            familydiv += '<input class="form-control" type="text" id="familyphone_' + familycnt + '" />';
            familydiv += '</div>';
            familydiv += '</div>';
            $('#familydynamic').append(familydiv);
        }

    </script>
</asp:Content>

