<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="Termination.aspx.cs" Inherits="Termination" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="assets/js/underscore.js"></script>
    <style>
        .dt-buttons {
            display: none;
        }
    </style>

    <div class="container-fluid" id="jsdatatable">
        <div class="row">
            <div class="col-lg-11">
                <small class="block text-ellipsis m-b-15">
                    <span class="text-xs"></span><span class="text-muted">De-Active From Date :</span>
                    <ul class="team-members">
                        <li>
                            <asp:TextBox ID="txt_frdt" runat="server" class="form-control datetimepicker" Width="150px" autocomplete="off" ClientIDMode="Static"></asp:TextBox>
                        </li>
                    </ul>

                    <span class="text-xs"></span><span class="text-muted">De-Active To Date :</span>
                    <ul class="team-members">
                        <li>
                            <asp:TextBox ID="txt_todt" runat="server" class="form-control datetimepicker" Width="150px" autocomplete="off" ClientIDMode="Static"></asp:TextBox>
                        </li>
                        <li class="ml-2"><i class="fa fa-search btn btn-primary" aria-hidden="true" onclick="getedatatble();return false;" style="MARGIN-TOP: 5px;"></i></li>
                        <li class="ml-2"><span onclick="exportdatamethod()" class="pull-right"><i class="fa fa-file-excel-o " style="font-size: 30px; margin-top: 6px; color: green;"></i></span></li>
                    </ul>
                </small>
            </div>
        </div>
        <a id="divcnt" class="ml-2"></a>
        <div id="gridtablediv" style="margin-top: -2%;" class="customtextdatatable"></div>
    </div>


    <!-- Employee Details Modal -->

    <div id="details" style="display: none">
        <div class="content container-fluid">
            <!-- Page Title -->
            <div class="row">
                <div class="col-sm-12">
                    <h4 class="page-title">Profile</h4>
                </div>
            </div>
            <!-- /Page Title -->

            <div class="card-box mb-0">
                <div class="row">
                    <div class="col-md-12">
                        <div class="profile-view">
                            <div class="profile-img-wrap">
                                <div class="profile-img">
                                    <a href="#">
                                        <img id="profile" /></a>
                                </div>
                            </div>
                            <div class="profile-basic">
                                <div class="row">
                                    <div class="col-md-5">
                                        <div class="profile-info-left">
                                            <h3 class="user-name m-t-0 mb-0"><span id="empname"></span></h3>
                                            <h6 class="text-muted"><span id="department"></span></h6>
                                            <small class="text-muted"><span id="designation"></span></small>
                                            <div class="staff-id">Employee ID : <span id="empid"></span></div>
                                            <div class="staff-id">Aadhar : <span id="aadharid"></span></div>
                                            <div class="staff-id">BRPL-UID : <span id="uidno"></span></div>
                                            <div class="small doj text-muted">Date of Join : <span id="doj"></span></div>
                                            <div class="staff-msg"><a class="btn btn-custom" href="Message">Send Message</a></div>
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
                                                <div class="title">Birthday:</div>
                                                <div class="text"><span id="dob"></span></div>
                                            </li>
                                            <li>
                                                <div class="title">Address:</div>
                                                <div class="text"><span id="address"></span></div>
                                            </li>
                                            <li>
                                                <div class="title">Gender:</div>
                                                <div class="text"><span id="gender"></span></div>
                                            </li>
                                            <li>
                                                <div class="title">Reports to:</div>
                                                <div class="text">
                                                    <div class="avatar-box">
                                                        <div class="avatar avatar-xs">
                                                            <img src="assets/img/profiles/" alt="">
                                                        </div>
                                                    </div>
                                                    <span id="reportingoffc" style="color: #0094ff"></span>
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
                            <%--  <div class="pro-edit">                           
                                <a class="edit-icon" href="javascript:void(0)" onclick="mdlpersonaldata();">
                                    <i class="fa fa-pencil"></i></a>
                            </div>--%>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tab-content">

                <!-- Profile Info Tab -->
                <div id="emp_profile" class="pro-overview tab-pane fade show active">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card-box profile-box">
                                <h3 class="card-title">Personal Informations</h3>
                                <%--<a href="#" class="edit-icon" onclick="function_personal_info_modal(this);"><i class="fa fa-pencil"></i></a>--%>
                                <ul class="personal-info">
                                    <li>
                                        <div class="title">Alternate Number</div>
                                        <div class="text"><span id="telephone" style="color: #0094ff"></span></div>
                                    </li>
                                    <li>
                                        <div class="title">Nationality</div>
                                        <div class="text"><span id="nationality"></span></div>
                                    </li>
                                    <li>
                                        <div class="title">Religion</div>
                                        <div class="text"><span id="religion"></span></div>
                                    </li>
                                    <li>
                                        <div class="title">Marital status</div>
                                        <div class="text"><span id="marritalstatus"></span></div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-md-6">

                            <div class="card-box profile-box">
                                <h3 class="card-title">Bank information</h3>
                                <%-- <a href="#" class="edit-icon" onclick="function_bank_employee(this);"><i class="fa fa-pencil"></i></a>--%>
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
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card-box profile-box">
                                <h3 class="card-title">Education Informations</h3>
                                <%--<a href="#" class="edit-icon" data-toggle="modal" data-target="#education_info"><i class="fa fa-pencil"></i></a>--%>
                                <div class="experience-box">
                                    <ul class="experience-list" id="educationdiv"></ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card-box profile-box">
                                <h3 class="card-title">Experience</h3>
                                <%--<a href="#" class="edit-icon" data-toggle="modal" data-target="#experience_info"><i class="fa fa-pencil"></i></a>--%>
                                <div class="experience-box">
                                    <ul class="experience-list" id="experiencediv"></ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /Profile Info Tab -->
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
                                            <input class="upload" id="profilemodalimage" type="file" onchange="readURL(this);" accept="image/png, image/jpeg, image/gif" />
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
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Address</label>
                                        <input type="text" class="form-control" value="" id="profilemodaladdress" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>State<span class="text-danger">*</span></label>
                                        <asp:DropDownList runat="server" ID="profilemodalstate" class="form-control" ClientIDMode="Static" onchange="getcityprofilemodal(this);"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>City<span class="text-danger">*</span></label>
                                        <asp:DropDownList runat="server" ID="profilemodalcity" class="form-control" ClientIDMode="Static">
                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
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
                                        <input class="form-control" type="text" id="personal_info_modal_altnumber" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Nationality <span class="text-danger">*</span></label>
                                        <input class="form-control" type="text" id="personal_info_modal_national" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Religion</label>
                                        <select class="select form-control select2-hidden-accessible" data-select2-id="49" tabindex="-1" aria-hidden="true" id="personal_info_modal_religion">
                                            <option>--Select--</option>
                                            <option>Hindu</option>
                                            <option>Muslim</option>
                                            <option>Sikh</option>
                                            <option>Christian</option>
                                            <option>Jain</option>
                                            <option>Buddhism</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Marital status <span class="text-danger">*</span></label>
                                        <select class="select form-control select2-hidden-accessible" data-select2-id="49" tabindex="-1" aria-hidden="true" id="personal_info_modal_marital">
                                            <option>--Select--</option>
                                            <option>Single</option>
                                            <option>Married</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="submit-section">
                                <button class="btn btn-primary submit-btn">Submit</button>
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
                        <h5 class="modal-title">Personal Information</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="card-box">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Bank Name <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Bank Account Number <span class="text-danger">*</span></label>
                                            <input class="form-control" type="text">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>IFSC Code <span class="text-danger">*</span></label>
                                            <input class="form-control" type="text">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>PAN No</label>
                                            <input class="form-control" type="text">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="submit-section">
                                <button class="btn btn-primary submit-btn">Submit</button>
                            </div>
                        </form>
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
                                    <h3 class="card-title">Education Informations <a href="javascript:void(0);" class="delete-icon"><i class="fa fa-trash-o"></i></a></h3>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group form-focus focused">
                                                <input type="text" value="Oxford University" class="form-control floating">
                                                <label class="focus-label">Institution</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-focus focused">
                                                <input type="text" value="Computer Science" class="form-control floating">
                                                <label class="focus-label">Subject</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-focus focused">
                                                <div class="cal-icon">
                                                    <input type="text" value="01/06/2002" class="form-control floating datetimepicker">
                                                </div>
                                                <label class="focus-label">Starting Date</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-focus focused">
                                                <div class="cal-icon">
                                                    <input type="text" value="31/05/2006" class="form-control floating datetimepicker">
                                                </div>
                                                <label class="focus-label">Complete Date</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-focus focused">
                                                <input type="text" value="BE Computer Science" class="form-control floating">
                                                <label class="focus-label">Degree</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-focus focused">
                                                <input type="text" value="Grade A" class="form-control floating">
                                                <label class="focus-label">Grade</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-box">
                                    <h3 class="card-title">Education Informations <a href="javascript:void(0);" class="delete-icon"><i class="fa fa-trash-o"></i></a></h3>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group form-focus focused">
                                                <input type="text" value="Oxford University" class="form-control floating">
                                                <label class="focus-label">Institution</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-focus focused">
                                                <input type="text" value="Computer Science" class="form-control floating">
                                                <label class="focus-label">Subject</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-focus focused">
                                                <div class="cal-icon">
                                                    <input type="text" value="01/06/2002" class="form-control floating datetimepicker">
                                                </div>
                                                <label class="focus-label">Starting Date</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-focus focused">
                                                <div class="cal-icon">
                                                    <input type="text" value="31/05/2006" class="form-control floating datetimepicker">
                                                </div>
                                                <label class="focus-label">Complete Date</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-focus focused">
                                                <input type="text" value="BE Computer Science" class="form-control floating">
                                                <label class="focus-label">Degree</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-focus focused">
                                                <input type="text" value="Grade A" class="form-control floating">
                                                <label class="focus-label">Grade</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="add-more">
                                        <a href="javascript:void(0);"><i class="fa fa-plus-circle"></i>Add More</a>
                                    </div>
                                </div>
                            </div>
                            <div class="submit-section">
                                <button class="btn btn-primary submit-btn">Submit</button>
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
                                    <h3 class="card-title">Experience Informations <a href="javascript:void(0);" class="delete-icon"><i class="fa fa-trash-o"></i></a></h3>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group form-focus focused">
                                                <input type="text" class="form-control floating" value="Digital Devlopment Inc">
                                                <label class="focus-label">Company Name</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-focus focused">
                                                <input type="text" class="form-control floating" value="United States">
                                                <label class="focus-label">Location</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-focus focused">
                                                <input type="text" class="form-control floating" value="Web Developer">
                                                <label class="focus-label">Job Position</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-focus focused">
                                                <div class="cal-icon">
                                                    <input type="text" class="form-control floating datetimepicker" value="01/07/2007">
                                                </div>
                                                <label class="focus-label">Period From</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-focus focused">
                                                <div class="cal-icon">
                                                    <input type="text" class="form-control floating datetimepicker" value="08/06/2018">
                                                </div>
                                                <label class="focus-label">Period To</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-box">
                                    <h3 class="card-title">Experience Informations <a href="javascript:void(0);" class="delete-icon"><i class="fa fa-trash-o"></i></a></h3>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group form-focus focused">
                                                <input type="text" class="form-control floating" value="Digital Devlopment Inc">
                                                <label class="focus-label">Company Name</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-focus focused">
                                                <input type="text" class="form-control floating" value="United States">
                                                <label class="focus-label">Location</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-focus focused">
                                                <input type="text" class="form-control floating" value="Web Developer">
                                                <label class="focus-label">Job Position</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-focus focused">
                                                <div class="cal-icon">
                                                    <input type="text" class="form-control floating datetimepicker" value="01/07/2007">
                                                </div>
                                                <label class="focus-label">Period From</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-focus focused">
                                                <div class="cal-icon">
                                                    <input type="text" class="form-control floating datetimepicker" value="08/06/2018">
                                                </div>
                                                <label class="focus-label">Period To</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="add-more">
                                        <a href="javascript:void(0);"><i class="fa fa-plus-circle"></i>Add More</a>
                                    </div>
                                </div>
                            </div>
                            <div class="submit-section">
                                <button class="btn btn-primary submit-btn">Submit</button>
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
                                    <h3 class="card-title">Family Member <a href="javascript:void(0);" class="delete-icon"><i class="fa fa-trash-o"></i></a></h3>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Name <span class="text-danger">*</span></label>
                                                <input class="form-control" type="text">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Relationship <span class="text-danger">*</span></label>
                                                <input class="form-control" type="text">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Date of birth <span class="text-danger">*</span></label>
                                                <input class="form-control" type="text">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Phone <span class="text-danger">*</span></label>
                                                <input class="form-control" type="text">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-box">
                                    <h3 class="card-title">Education Informations <a href="javascript:void(0);" class="delete-icon"><i class="fa fa-trash-o"></i></a></h3>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Name <span class="text-danger">*</span></label>
                                                <input class="form-control" type="text">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Relationship <span class="text-danger">*</span></label>
                                                <input class="form-control" type="text">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Date of birth <span class="text-danger">*</span></label>
                                                <input class="form-control" type="text">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Phone <span class="text-danger">*</span></label>
                                                <input class="form-control" type="text">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="add-more">
                                        <a href="javascript:void(0);"><i class="fa fa-plus-circle"></i>Add More</a>
                                    </div>
                                </div>
                            </div>
                            <div class="submit-section">
                                <button class="btn btn-primary submit-btn">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Employee Details Modal -->

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
                                    <label>Aadhar <span class="text-danger">*</span></label>
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
                        <%--  <div class="form-group">
                            <label>Last Date <span class="text-danger">*</span></label>
                            <div class="cal-icon">
                                <input type="text" class="form-control datetimepicker" value="" id="terminationnoticeperiod" />
                            </div>
                        </div>--%>
                        <div class="submit-section">
                            <a class="btn btn-primary submit-btn" onclick="function_edit_deactive();">Submit</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- Edit terminate Employee Modal -->

    <script>

        //$(document).ready(function () {
        //    getedatatble();
        //});

        function getedatatble() {
            $.ajax({
                type: "POST",
                url: "Termination.aspx/bindata",
                dataType: "json",
                data: JSON.stringify({ typ: "3", from: $('#txt_frdt').val(), todate: $('#txt_todt').val() }),
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
                        var statusnam;
                        statusnam = (_.groupBy(fault, 'Status'));
                        var keyNames = Object.keys(statusnam);
                        var keyValues = Object.values(statusnam);
                        console.log(keyNames); // Outputs ["a","b","c"]                       
                        console.log(keyValues); // Outputs [
                        var lbl_div = '';
                        $('#divcnt').empty();
                        for (cnlabe = 0; cnlabe < keyNames.length; cnlabe++) {
                            lbl_div += '<span class="text-xs"></span><span class="text-muted">' + keyNames[cnlabe] + ' :</span>';
                            lbl_div += '<ul class="team-members">';
                            lbl_div += '<li>';
                            lbl_div += ' <a href="javascript:void(0)" class="all-users">';
                            lbl_div += '<span id="lbl_blacklist">' + keyValues[cnlabe].length + '</span></a>';
                            lbl_div += '</li>';
                            lbl_div += '</ul>';
                        }
                        $('#divcnt').append(lbl_div);

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
                        gridtable += '  <tbody> ' + td + '</tbody>';
                        gridtable += ' </table>';
                        $('#gridtablediv').append(gridtable);
                        var groupColumn = 0;
                        $('#gridtable').DataTable({
                            columnDefs: [
                            {
                                "visible": true, "targets": groupColumn,
                                render: function (data, type, row, meta) {
                                    data = '<a href="javascript:" onclick="backendcall(this)">' + encodeURIComponent(data) + '</a>';
                                    return data;
                                }
                            },
                            ],
                            "scrollCollapse": true, dom: 'Bfrtip',
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


        function backendcall(obj) {
            debugger;
            var aadhar = obj.innerHTML;
            $('#details').show();
            $('#jsdatatable').hide();
            $.ajax({
                type: "POST",
                url: "Termination.aspx/binalldata",
                dataType: "json",
                data: JSON.stringify({ typ: "5", aadhar: aadhar }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var empdetails = eval(data.d);
                        console.log("empdetails", empdetails);
                        if (empdetails[0].length > 0) {
                            $("#aadharid").text((empdetails[0][0].AADHAR) != null ? empdetails[0][0].AADHAR : "NA");
                            $("#empname").text((empdetails[0][0].EMP_NM) != null ? empdetails[0][0].EMP_NM : "NA");
                            $("#department").text((empdetails[0][0].DEPT_NAME) != null ? empdetails[0][0].DEPT_NAME : "NA");
                            $("#designation").text((empdetails[0][0].DEG) != null ? empdetails[0][0].DEG : "NA");
                            $("#empid").text((empdetails[0][0].EMP_CODE) != null ? empdetails[0][0].EMP_CODE : "NA");
                            $("#uidno").text((empdetails[0][0].UIDNO) != null ? empdetails[0][0].UIDNO : "NA");
                            $("#doj").text((empdetails[0][0].DOJ) != null ? empdetails[0][0].DOJ : "NA");
                            $("#phone").text((empdetails[0][0].CONTACT_NO) != null ? empdetails[0][0].CONTACT_NO : "NA");
                            $("#email").text((empdetails[0][0].EMAIL_ID) != null ? empdetails[0][0].EMAIL_ID : "NA");
                            reporting = empdetails[0][0].L1_REPORTING;
                            dept = empdetails[0][0].DEPT;
                            refpic = empdetails[0][0].PIC_REF;
                            state = empdetails[0][0].STATE;
                            city = empdetails[0][0].CITY;
                            divs = empdetails[0][0].DIV_CODE;
                            subdiv = empdetails[0][0].SUB_DIV_CODE;
                            $("#empstatus").append(empdetails[0][0].STATUS_DESC == "Working" ? '<span class="badge badge-success-border">' + empdetails[0][0].STATUS_DESC + '</span>' : '<span class="badge badge-danger-border">' + empdetails[0][0].STATUS_DESC + '</span>');
                            $("#dob").text((empdetails[0][0].DOB) != null ? empdetails[0][0].DOB : "NA");
                            $("#address").text((empdetails[0][0].ADDR1) != null ? empdetails[0][0].ADDR1 : "NA");
                            $("#gender").text((empdetails[0][0].GENDER) != null ? empdetails[0][0].GENDER : "NA");
                            $("#reportingoffc").text((empdetails[0][0].L1_NAME) != null ? empdetails[0][0].L1_NAME : "NA");
                            $("#telephone").text((empdetails[0][0].ALT_CONTACT_NO) != null ? empdetails[0][0].ALT_CONTACT_NO : "NA");
                            $("#nationality").text((empdetails[0][0].NATIONALITY) != null ? empdetails[0][0].NATIONALITY : "NA");
                            $("#religion").text("NA");
                            $("#marritalstatus").text("NA");

                            $("#bankname").text((empdetails[0][0].BANK_NAME) != null ? empdetails[0][0].BANK_NAME : "NA");
                            $("#ifsccode").text((empdetails[0][0].IFSC) != null ? empdetails[0][0].IFSC : "NA");
                            $("#panno").text((empdetails[0][0].PAN_NO) != null ? empdetails[0][0].PAN_NO : "NA");
                            $("#bankaccountno").text((empdetails[0][0].BNK_AC_NO) != null ? empdetails[0][0].BNK_AC_NO : "NA");
                            document.getElementById("profile").src = "ImageCSharp.aspx?FileName=" + empdetails[0][0].PIC_REF + ".JPG";

                        } if (empdetails[1].length > 0)//educationdetails
                        {
                            var education = '';
                            for (var i = 0; i < empdetails[1].length - 1; i++) {
                                if (empdetails[1][i].CRS_DEGR_NM != null) {
                                    education += "<li><div class='experience-user'><div class='before-circle'></div></div><div class='experience-content'><div class='timeline-content'>";
                                    education += "<a href='#/' class='name'>" + empdetails[1][i].UNI_BRD + "</a><div>" + empdetails[1][i].CRS_DEGR_NM + "</div>";
                                    education += "<span class='time'>" + empdetails[1][i].SPEC + "</span>";
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
                            var experience = '';
                            for (var i = 0; i < empdetails[2].length - 1; i++) {
                                if (empdetails[2][i].COMP_NM != null) {
                                    experience += "  <li><div class='experience-user'><div class='before-circle'></div></div><div class='experience-content'><div class='timeline-content'>";
                                    experience += "<a href='#/' class='name'>" + empdetails[2][i].COMP_NM + "</a>";
                                    experience += "<span class='time'>" + empdetails[2][i].FROM_DATE + "to" + empdetails[2][i].TODATE + "</span>";
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

        function edit_employee(obj) {
            var valterminate = obj.split(',');
            $('#edit_employee').modal('show');
            $('#terminationname').val(valterminate[1]);
            $('#terminationaadhar').val(valterminate[0]);
        }

        function function_edit_deactive() {
            $.ajax({
                type: "POST",
                url: "Termination.aspx/employeeterminate",
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
        function exportdatamethod() {
            debugger;
            $('.buttons-excel').trigger('click');
        }
    </script>
</asp:Content>

