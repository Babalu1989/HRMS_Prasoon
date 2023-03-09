<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="UIDGeneration.aspx.cs" Inherits="UIDGeneration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .dt-buttons {
            display: none;
        }
    </style>
    <div class="row">
        <%-- <asp:FileUpload ID="FileUpload" runat="server" CssClass="btn add-btn" Style="height: 36px; margin-top: 10px;" />
        <asp:Button ID="btnUpload" runat="server" OnClick="btnUpload_Click" Text="Upload" CssClass="float-left" hidden="hidden" CausesValidation="False" />--%>
        <div class="float-left" style="margin-top: 1%; margin-left: 5px;">
            <asp:Label runat="server" ID="lbl_msg" ForeColor="Red"></asp:Label>
            <%if (Session["EMP_TYPE"].ToString() == "SLA" || Session["EMP_TYPE"].ToString() == "Buyer")
              {%>
            <a href="javascript:void(0)" class="btn add-btn" onclick="functionshowmodal();"><i class="fa fa-plus"></i>Entry Form</a>
            <%} %><%else { } %>
            <%--  <div style="float: right; margin-top: 8px;">&nbsp;&nbsp;&nbsp;OR&nbsp;&nbsp;&nbsp;</div>
            <a id="A1" href="javascript:void(0);" class="btn add-btn" onclick="btnfire();return false;">Upload</a>--%>
            <%-- <script> function btnfire() {
     document.getElementById("<%=btnUpload.ClientID %>").click();

 } function btnfiledwn() {
     document.getElementById("<%=filedownload.ClientID %>").click();

 }

            </script>--%>
        </div>
        <asp:Button runat="server" ID="filedownload" OnClick="filedownload_Click" hidden="hidden" CausesValidation="False" />
        <%-- <i class="fa fa-file-excel-o float-right" style="font-size: 30px; margin-left: 90%; margin-top: -3%; color: green;" data-toggle="tooltip" title="Sample File" onclick="btnfiledwn();return false;"></i>--%>
    </div>
    <div id="gridtablediv" style="margin-top: 0%;" class="customtextdatatable"></div>
    <div class="row">
        <div class="col-lg-12 ">
            <div class="table-responsive">
                <asp:GridView runat="server" ID="gv_uploaddata" ClientIDMode="Static" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="false" DataKeyNames="EmpId" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnRowDataBound="gv_uploaddata_RowDataBound" OnRowDeleting="GridView1_RowDeleting">
                    <Columns>
                        <asp:CommandField ShowEditButton="true" />
                        <asp:BoundField DataField="SNo" HeaderText="SNo" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="EmpId" HeaderText="EmpId" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="Name" HeaderText="Name" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="Roles" HeaderText="Roles" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="Company" HeaderText="Company" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="DOB" HeaderText="DOB(DDMMYYYY)" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="Aadhaar" HeaderText="Aadhaar" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="DOJ" HeaderText="DOJ(DDMMYYYY)" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="Department" HeaderText="Department" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="Location" HeaderText="Location" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="DOS" HeaderText="DOS(DDMMYYYY)" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="Reason for Seperation" HeaderText="Reason for Seperation" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="Mobile" HeaderText="Mobile" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="Email" HeaderText="Email" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="L1 Empid" HeaderText="L1 Empid" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="L1 Name" HeaderText="L1 Name" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="L1 Mobile" HeaderText="L1 Mobile" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="L1 Email" HeaderText="L1 Email" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:CommandField ShowDeleteButton="true" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-4"></div>
        <div class="col-lg-4">
            <asp:Button runat="server" ID="submit" class="btn add-btn" OnClick="submit_Click" Text="Submit" Style="float: left;" Visible="false" />
            <asp:TextBox runat="server" ID="txt_errorcnt" Visible="false"></asp:TextBox>
        </div>
        <div class="col-lg-4"></div>
    </div>
    <div class="modal custom-modal fade show" id="attendance_info" role="dialog" aria-modal="true" style="display: none; padding-left: 17px;">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">View Detailed Status</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card punch-status" style="height: 780px !important">
                                <div class="card-body">
                                    <h5 class="card-title">Candidate Details<small class="text-muted"></small></h5>
                                    <div class="form-scroll" style="max-height: 680px !important">
                                        <div class="punch-det">
                                            <h6>Requisition Number</h6>
                                            <p id="reqnomodal" style="color: red"></p>
                                        </div>
                                        <div class="punch-det">
                                            <h6>Employee Name</h6>
                                            <p id="namemodal"></p>
                                        </div>
                                        <div class="punch-det">
                                            <h6>Father's Name</h6>
                                            <p id="fathermodal"></p>
                                        </div>
                                        <div class="punch-det">
                                            <h6>DOB</h6>
                                            <p id="dob"></p>
                                        </div>
                                        <div class="punch-det">
                                            <h6>Department</h6>
                                            <p id="department"></p>
                                        </div>
                                        <div class="punch-det">
                                            <h6>Division</h6>
                                            <p id="division"></p>
                                        </div>
                                        <div class="punch-det">
                                            <h6>Aadhaar No</h6>
                                            <p id="aadharmodal"></p>
                                        </div>
                                        <div class="punch-det">
                                            <h6>Work Order No</h6>
                                            <p id="workordermodal"></p>
                                        </div>
                                        <div class="punch-det">
                                            <h6>Work Order from</h6>
                                            <p id="workorderfrommodal"></p>
                                        </div>
                                        <div class="punch-det">
                                            <h6>Work Order To</h6>
                                            <p id="workorderTomodal"></p>
                                        </div>
                                        <div class="punch-det">
                                            <h6>Proposed By</h6>
                                            <p id="reqby"></p>
                                        </div>
                                        <div class="punch-det">
                                            <h6>Proposed Date</h6>
                                            <p id="reqdt"></p>
                                        </div>
                                        <div class="punch-det">
                                            <h6>New UID No</h6>
                                            <p id="uid"></p>
                                        </div>
                                        <div class="punch-det">
                                            <h6>Security Remarks</h6>
                                            <p id="securityremarks"></p>
                                        </div>
                                        <div class="punch-det">
                                            <h6>UID Generated by</h6>
                                            <p id="uidby"></p>
                                        </div>
                                        <div class="punch-det">
                                            <h6>UID Generated Date</h6>
                                            <p id="uiddt"></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card recent-activity">
                                <div class="card-body">
                                    <h5 class="card-title">Activity</h5>
                                    <div class="form-scroll">
                                        <ul class="res-activity-list" id="uldiv" style="height: 100px !important"></ul>
                                    </div>
                                </div>
                            </div>
                            <%if (Session["EMP_TYPE"].ToString() == "Security")
                              {%>
                            <div class="card recent-activity">
                                <div class="card-body">
                                    <h5 class="card-title">Action</h5>
                                    <label class="radiocontainer" onclick="applicationstatuscheck()">
                                        I here by certify that there is  Biometric data availale for this Candidate
                                    <input type="radio" name="applicationstatus" value="available" />
                                        <span class="checkmark"></span>
                                    </label>
                                    <label class="radiocontainer" onclick="applicationstatuscheck()">
                                        I here by certify that there is no Biometric data availale for this Candidate
                                    <input type="radio" name="applicationstatus" value="new" />
                                        <span class="checkmark"></span>
                                    </label>
                                    <div id="applicationdivhideshow" style="display: none">
                                        <div class="form-scroll" id="applicationdiv">
                                            <div class="punch-det">
                                                <h6>New UID No<span class="text-danger">*</span></h6>
                                                <input type="number" class="form-control" id="newuidno" readonly="readonly" />
                                                <h6>Remarks</h6>
                                                <input type="text" class="form-control" id="txtremarks" />
                                                <h6>UID Type<span class="text-danger">*</span></h6>
                                                <select class="form-control" id="txt_uidtype">
                                                    <option value="--Select--">--Select--</option>
                                                    <option value="TEMPORARY">Temporary</option>
                                                    <option value="PERMANENT">Permanent</option>
                                                    <%-- <option value="DUPLICATE">Duplicate</option>--%>
                                                </select>
                                                <h6>Valid Upto<span class="text-danger">*</span></h6>
                                                <input type="text" class="form-control datetimepicker" id="txt_validupto" readonly="readonly" style="background-color: white !important" />
                                            </div>
                                        </div>
                                    </div>
                                    <div id="availablediv" style="display: none">
                                        <div class="form-scroll" id="Div2">
                                            <div class="punch-det">
                                                 <h6>UID No</h6>
                                                <input type="text" class="form-control" id="txt_avaibaleuid" maxlength="9" onkeypress="return validatenumber(event)" />
                                                 <h6>Name</h6>
                                                <input type="text" class="form-control" id="txt_avaibalename" />
                                                <h6>DOB</h6>
                                                <input type="text" class="form-control datetimepicker" id="txt_avaibaledob" />
                                                 <h6>Father's Name</h6>
                                                <input type="text" class="form-control" id="txt_avaibalefathername" />
                                                <h6>Aadhaar No</h6>
                                                <input type="text" class="form-control" id="txt_avaibaleaadhar" />
                                                <h6>Remarks</h6>
                                                <input type="text" class="form-control" id="txtremarksavailable" />
                                            </div>
                                        </div>
                                    </div>
                                    <script>
                                        function applicationstatuscheck() {
                                            if ($("input[name='applicationstatus']:checked").val() == "new") {
                                                $('#applicationdivhideshow').show();
                                                $('#availablediv').hide();
                                                
                                            }
                                            else if ($("input[name='applicationstatus']:checked").val() == "available") {
                                                $('#availablediv').show();
                                                $('#applicationdivhideshow').hide();
                                            }
                                            else {
                                                $('#applicationdivhideshow').hide();
                                                $('#availablediv').hide();
                                            }
                                        }
                                    </script>
                                </div>
                            </div>
                            <div class="submit-section">
                                <a class="btn btn-primary submit-btn pull-right" onclick="funsubmit();return false;">Submit</a>
                            </div>
                            <%} %><%else { } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="add_employee" class="modal custom-modal fade" role="dialog">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">New ID Card Form</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div id="gridtablerequisition" style="margin-top: 0%;" class="customtextdatatable"></div>
                <div class="modal-body">
                    <div class="row mt-4">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="col-form-label">Requisition Number<span class="text-danger">*</span></label>
                                <input class="form-control" type="text" required="required" data-error-msg="Requisition Number Required" id="reqno" readonly="readonly" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Employee Name<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" value="" id="name" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Father's Name<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" value="" id="fathername" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="col-form-label">Date of Birth <span class="text-danger">*</span></label>
                                <div class="cal-icon">
                                    <input class="form-control datetimepicker" type="text" maxlength="9" data-error-msg="Birth Date Required" id="addmodaldob" readonly="readonly" style="background-color: white !important" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Company/Vendor<span class="text-danger">*</span></label>
                                <asp:DropDownList runat="server" ID="ddl_vendor_popup" class="form-control" data-error-msg="Vendor Required" ClientIDMode="Static"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Department<span class="text-danger">*</span></label>
                                <asp:DropDownList runat="server" ID="ddl_department_popup" class="form-control" ClientIDMode="Static"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Division<span class="text-danger">*</span></label>
                                <asp:DropDownList runat="server" ID="ddl_division" class="form-control" ClientIDMode="Static"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Aadhaar No</label>
                                <input type="text" class="form-control" value="" id="aadhar" maxlength="10" onkeypress="return validatenumber(event)" />
                            </div>
                        </div>
                    </div>
                    <div class="submit-section">
                        <a class="btn btn-primary submit-btn" onclick="function_clearance_insert();">Submit</a>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <script>
        $('#gv_uploaddata').DataTable();
        function function_clearance_insert() {
            if ($('#reqno').val() == "" || $('#name').val() == "" || $('#fathername').val() == "" || $('#addmodaldob').val() == "" || $('#ddl_vendor_popup').val() == "0" || $('#ddl_department_popup').val() == "0" || $('#ddl_division').val() == "0") { left("Please fill the mandatory fileds"); } else {
                $.ajax({
                    type: "POST",
                    url: "UIDGeneration.aspx/UIDGenerationSave",
                    dataType: "json",
                    data: JSON.stringify({ typ: "8", reqno: $('#reqno').val(), name: $('#name').val(), fname: $('#fathername').val(), dob: $('#addmodaldob').val(), company: $('#ddl_vendor_popup').val(), department: $('#ddl_department_popup').val(), division: $('#ddl_division').val(), aadhar: $('#aadhar').val() }),
                    contentType: "application/json",
                    success: function (data) {
                        if (data.d.length > 0) {
                            console.log(data);
                            var response = eval(data.d);
                            console.log("response", response);
                            if (response.length > 0) {
                                $('#add_employee').modal('hide');
                                left(response[0].TXT);
                            }
                        }
                    }
                });
            }

        }
    </script>
    <script>
        $('document').ready(function () {
            $('#reqno').on('blur', function () {
                var username = $('#reqno').val();
                if (username == '') {
                    username_state = false;
                    return;
                }
                getdata(username);
            });
        });

        function getdata(username) {
            $.ajax({
                type: "POST",
                url: "UIDGeneration.aspx/checkreqno",
                dataType: "json",
                data: JSON.stringify({ reqno: username, type: "9" }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var getvalue = eval(data.d);
                        console.log("getvalue", getvalue);
                        if (getvalue.length > 0) {
                            if (getvalue[0].CNT == "0") {
                                $('#reqno').addClass("is-invalid");
                                $('#reqno').after('<div class="help-block with-errors">Requisition Number Not Exists</div>');
                            } else {
                                $('#reqno').removeClass("is-invalid");
                                $('#reqno').addClass("is-valid");
                                $('#ddl_department_popup').val(getvalue[0].DEPARTMENT);
                                $('#ddl_division').val(getvalue[0].DIVISION);
                            }
                        }
                    }
                }
            });
        }

        function getedatatble() {
            $.ajax({
                type: "POST",
                url: "UIDGeneration.aspx/bindata",
                dataType: "json",
                data: JSON.stringify({ typ: "10" }),
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
                                if (j == col.length) {
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
                            "scrollCollapse": true, dom: 'Bfrtip',
                            "paging": false,
                            "sorting": false,
                            "scrollY": 280,
                            "scrollX": true,
                            "scrollCollapse": true,
                            columnDefs: [
                            {
                                "visible": true, "targets": groupColumn,
                                render: function (data, type, row, meta) {
                                    data = '<a href="javascript:" onclick="backendcall(this)">' + encodeURIComponent(data) + '</a>';
                                    return data;
                                }
                            },
                            ],
                            buttons: [
                               'excel',
                            ]
                        });
                    }
                }
            });
        }
        function getedatatblerequisition() {
            $.ajax({
                type: "POST",
                url: "UIDGeneration.aspx/bindata",
                dataType: "json",
                data: JSON.stringify({ typ: "22" }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $('#gridtablerequisition').html('');
                        debugger;
                        var gridtablereqdiv = '<table id="gridtablereq"  class="table table-striped custom-table datatable dataTable no-footer" role="grid" width="100%">';
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

                        gridtablereqdiv += '  <thead style="width:100%;"> <tr>' + th + '</tr></thead>';

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
                                if (j == col.length) {
                                } else {
                                    td += '<td>' + fault[i][col[j]] + '</td>';
                                }
                            }
                            td += ' </tr>';
                        }
                        gridtablereqdiv += '  <tbody> ' + td + '</tbody>';
                        gridtablereqdiv += ' </table>';
                        $('#gridtablerequisition').append(gridtablereqdiv);
                        var groupColumn = 0;
                        $('#gridtablereq').DataTable({
                            "paging": false,
                            //"sorting": false,
                            "scrollY": 280,
                            columnDefs: [
                            {
                                "visible": true, "targets": groupColumn,
                                render: function (data, type, row, meta) {
                                    data = '<a href="javascript:" onclick="functionfill(this)">' + encodeURIComponent(data) + '</a>';
                                    return data;
                                }
                            },
                            ]
                        });
                    }
                }
            });
        }

        $(document).ready(function () {
            getedatatble();
        });
        function backendcall(obj) {
            debugger;
            var table = $('#gridtable').DataTable();
            var data;
            $('#gridtable tbody').on('click', 'tr', function () {
                data = table.row(this).data();
                //alert('You clicked on ' + data[0] + data[1] + data[2] + data[3] + '\'s row');
                $('#uldiv').empty();
                var aadhar = obj.innerHTML;
                $.ajax({
                    type: "POST",
                    url: "UIDGeneration.aspx/bindmoredata",
                    dataType: "json",
                    data: JSON.stringify({ typ: "10A", emp: aadhar, name: data[1], fname: data[2], dob: data[3] }),
                    contentType: "application/json",
                    success: function (data) {
                        if (data.d.length > 0) {
                            var fault = eval(data.d);
                            console.log(fault);
                            $('#reqnomodal')[0].innerText = fault[0].REQUISITIONNO;
                            $('#namemodal')[0].innerText = fault[0].NAME;
                            $('#fathermodal')[0].innerText = fault[0].FNAME;
                            $('#dob')[0].innerText = fault[0].DOB;
                            $('#department')[0].innerText = fault[0].DEPARTMENT;
                            $('#division')[0].innerText = fault[0].DIVISION;
                            $('#aadharmodal')[0].innerText = fault[0].AADHAR;
                            $('#reqby')[0].innerText = fault[0].UPLOADBY;
                            $('#reqdt')[0].innerText = fault[0].UPLOADDT;
                            $('#uid')[0].innerText = fault[0].UIDNO;
                            $('#securityremarks')[0].innerText = fault[0].UIDREMARKS;
                            $('#uidby')[0].innerText = fault[0].UIDGENRATEBY;
                            $('#uiddt')[0].innerText = fault[0].UIDGENERATEDT;
                            //added for final uat point 17 march 2021
                            $('#workordermodal')[0].innerText = fault[0].WONUMBER;
                            $('#workorderfrommodal')[0].innerText = fault[0].WO_FROM;
                            $('#workorderTomodal')[0].innerText = fault[0].WO_TO;
                            //added for final uat point 17 march 2021

                           
                            $('#attendance_info').modal('show');
                            var array = fault[0].STATUS.split('|');
                            var loopdiv = '';
                            for (var emplist = 0; emplist < array.length; emplist++) {
                                var data = array[emplist].split(',');
                                loopdiv += '<li>';
                                loopdiv += '<p class="mb-0">' + data[0] + '</p>';
                                loopdiv += '<p class="res-activity-time">';
                                loopdiv += (data[1].includes("Done")) ? '<i class="fa fa-check text-success">' + data[1] + '</i>' : '<i class="fa fa-clock-o text-danger">' + data[1] + '</i>';
                                loopdiv += '</p>';
                                loopdiv += '</li>';
                            }
                            $('#uldiv').append(loopdiv);
                            document.getElementById("newuidno").defaultValue = parseInt(fault[0].newuid); //fault[0].newuid+ 1;

                        }
                    }
                });
                $('#attendance_info').modal('show');
            });
        }
    </script>
    <script>
        var updatedRight = [];
        function funsubmit() {
            if ($("input[name='applicationstatus']:checked").val() == undefined) {
                left("Select Atleast one Option");
            }
            if ($("input[name='applicationstatus']:checked").val() == "new") {
                if ($('#newuidno').val() == "" || $('#txt_validupto').val() == "" || $('#txt_uidtype').val() == "--Select--") {
                    left("Please fill all the mandatory fileds");
                } else {
                    updatedRight.push({ Name: $("input[name='applicationstatus']:checked").val(), uidno: $('#newuidno').val(), remarks: $('#txtremarks').val(), reqno: $('#reqnomodal')[0].innerText, cname: $('#namemodal')[0].innerText, fname: $('#fathermodal')[0].innerText, dob: $('#dob')[0].innerText, validupto: $('#txt_validupto').val(), uidtype: $('#txt_uidtype').val() });
                    savedata();
                }
            }
            if ($("input[name='applicationstatus']:checked").val() == "available") {    
                updatedRight.push({ Name: $("input[name='applicationstatus']:checked").val(), uidno: $('#txt_avaibaleuid').val() + "," + $('#txt_avaibalename').val(), remarks: $('#txtremarksavailable').val(), reqno: $('#reqnomodal')[0].innerText, cname: $('#namemodal')[0].innerText, fname: $('#fathermodal')[0].innerText, dob: $('#dob')[0].innerText, validupto: "", uidtype: "" });
                savedata();
            }
        }
        function savedata() {
            $.ajax({

                url: 'UIDGeneration.aspx/updatedetails',

                type: "POST",

                dataType: "json",

                data: JSON.stringify({ empcode: "", typ: "11", updatedRight: updatedRight }),

                contentType: "application/json; charset=utf-8",

                success: function (data) {
                    console.log(data.length);
                    $('#attendance_info').modal('hide');
                    if (data.d[0].MSG_CODE == 0) {
                        left(data.d[0].TXT);
                    }
                    else {
                        left(data.d[0].TXT);
                    }
                }, error: function (err) {
                    console.log(err);
                }

            });

        }

        $('#txt_validupto').datepicker({
            minDate: -0,
            maxDate: "+1Y"
        });


        function functionfill(obj) {
            $('#reqno').val(obj.innerHTML);
            $('#reqno').prop('disabled', true);
            $('#name').val("");
            $('#fathername').val("");
            $('#addmodaldob').val("");
            $('#ddl_vendor_popup').val("0");
            $('#ddl_department_popup').val("0");
            $('#ddl_division').val("0");
            $('#aadhar').val("");
            getdata(obj.innerHTML);
        }
    </script>
    <script>

        function functionshowmodal() {
                     <%if (Session["EMP_TYPE"].ToString() == "SLA" || Session["EMP_TYPE"].ToString() == "Buyer")
                       {%> getedatatblerequisition(); <%}%>
             $('#add_employee').modal('show');
         }
    </script>
    <script>
        function searchemp() {
            var usernameempid = $('#txt_avaibaleuid').val();
            $.ajax({
                type: "POST",
                url: "UIDGeneration.aspx/checkbrpluid",
                dataType: "json",
                data: JSON.stringify({ empcode: usernameempid, type: "1JJ" }),
                beforesend: loadmyloading(),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 4) {
                        var getvalue = eval(data.d);
                        console.log("getvalue", getvalue);
                        if (getvalue.length > 0) {
                            $('#txt_avaibalename').val(getvalue[0][0].EMP_NM);
                            $('#txt_avaibalefathername').val(getvalue[0][0].EMP_FTHR_NM);
                            $('#txt_avaibaleaadhar').val(getvalue[0][0].AADHAR);
                            $('#txt_avaibaledob').val(getvalue[0][0].DOB);
                        } else {
                            $('#txt_avaibalename').val(""); $('#txt_avaibalefathername').val(""); $('#txt_avaibaleaadhar').val(""); $('#txt_avaibaledob').val("");
                        }
                        removemyloading();
                    } else {
                        $('#txt_avaibalename').val(""); $('#txt_avaibalefathername').val(""); $('#txt_avaibaleaadhar').val(""); $('#txt_avaibaledob').val("");
                        removemyloading();
                    }
                    removemyloading();
                }
            });
        }
        $('#txt_avaibaleuid').on('keyup', function (event) {
            //if (event.keyCode == '13') {
            if ($('#txt_avaibaleuid').val().length>=9) {
                debugger;
                if ($('#txt_avaibaleuid').val() != null) {
                    searchemp();
                    console.log('keyup');
                }
                return;
            }
        });
    </script>
</asp:Content>

