<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="UIDReturnreplace.aspx.cs" Inherits="UIDReturnreplace" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .dt-buttons {
            display: none;
        }
    </style>
    <span onclick="exportdatamethod()" class="pull-left" style="color: green;">Download File:<i class="fa fa-file-excel-o " style="font-size: 30px; margin-left: 15px; color: green;"></i></span>
    <a href="#" class="btn add-btn ml-2" data-toggle="modal" data-target="#add_employee" style="float: left"><i class="fa fa-plus"></i>Entry Form</a>
    <div class="container-fluid" id="jsdatatable">
        <div id="gridtablediv" style="" class="customtextdatatable"></div>
    </div>
    <!-- Edit terminate Employee Modal -->
    <div id="edit_employee" class="modal custom-modal fade" role="dialog">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Update Employee Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">Ã—</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Employee Name <span class="text-danger">*</span></label>
                                    <input class="form-control" type="text" value="" id="terminationname" disabled="disabled" />
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Aadhaar No<span class="text-danger">*</span></label>
                                    <input class="form-control" type="text" value="" id="terminationaadhar" disabled="disabled" />
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>UID <span class="text-danger">*</span></label>
                                    <input class="form-control" type="text" value="" id="terminationuid" disabled="disabled" />
                                </div>
                            </div>
                            <div class="col-sm-6" id="div_newuidno">
                                <div class="form-group">
                                    <label>New UID No<span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="newuidno" readonly="readonly" />
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Current Validity <span class="text-danger">*</span></label>
                                    <input class="form-control datetimepicker" type="text" value="" id="txt_oldvalidity" disabled="disabled" />
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Remarks</label>
                                    <input type="text" class="form-control" id="txtremarks" />
                                </div>
                            </div>
                            <div class="col-sm-6" id="div_txt_uidtype">
                                <div class="form-group">
                                    <label>UID Type<span class="text-danger">*</span></label>
                                    <select class="form-control" id="txt_uidtype">
                                        <option value="0">--Select--</option>
                                        <option value="TEMPORARY">Temporary</option>
                                        <option value="PERMANENT">Permanent</option>
                                        <option value="DUPLICATE">Duplicate</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-sm-6" id="div_txt_validupto">
                                <div class="form-group">
                                    <label>Valid Upto<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control datetimepicker" id="txt_validupto" readonly="readonly" style="background-color: white !important" />
                                </div>
                            </div>
                            <div class="col-sm-6" id="div_ddl_cardaccept">
                                <div class="form-group">
                                    <label>ID Card Received <span class="text-danger">*</span></label>
                                    <div class="add-group-btn">
                                        <asp:DropDownList runat="server" ID="ddl_cardaccept" ClientIDMode="Static" class="form-control">
                                            <asp:ListItem Value="0" Text="--Select--"></asp:ListItem>
                                            <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                            <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="submit-section">
                            <a class="btn btn-primary submit-btn" onclick="function_edit_deactive();">Submit</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- Edit terminate Employee Modal -->
    <div id="add_employee" class="modal custom-modal fade" role="dialog">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Return & Replacement</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Aadhaar No<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" value="" id="aadhar" maxlength="12" onkeypress="return validatenumber(event)" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Employee Name<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" value="" id="name" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || (event.charCode == 32)" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Father's Name<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" value="" id="fathername" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || (event.charCode == 32)" />
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
                                <label>Request Type<span class="text-danger">*</span></label>
                                <asp:DropDownList runat="server" ID="ddl_reqtype" class="form-control" ClientIDMode="Static">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Return" Value="CR"></asp:ListItem>
                                    <asp:ListItem Text="Replace" Value="CRR"></asp:ListItem>
                                    <asp:ListItem Text="Card Lost" Value="CL"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                          <div class="col-sm-6" id="div_firdoc" style="display: none">                               
                                <div class="form-group">
                                     <a href="javascript:void(0);" class="btn btn-primary edit-btn" onclick="BrowseFile('filesbillnew');" style="margin-left: 4%; margin-top: 29px;"><i class="fa fa-paperclip"></i></a>
                                    <div class="file-field">
                                         <label> FIR Document:<span class="text-danger">*</span></label>
                                        <span id="filenamebillnew" class="text-success"></span>
                                        <asp:FileUpload ID="filesbillnew" ClientIDMode="Static" runat="server" Style="display: none" accept="application/pdf" onchange="onChange_FileUpload(this,'filenamebillnew')" />
                                    </div>
                                </div>
                            </div>
                         <script>
                             $("#ddl_reqtype").change(function () {
                                 if ($("#ddl_reqtype").val() == "CL") {
                                     $("#div_firdoc").show();
                                 } else {
                                     $("#div_firdoc").hide();
                                 }
                             });
                        </script>
                        <div class="col-md-6" hidden="hidden">
                            <div class="form-group">
                                <label class="col-form-label">Requisition Number<span class="text-danger">*</span></label>
                                <input class="form-control" type="text" required="required" data-error-msg="Requisition Number Required" id="reqno" />
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
        function function_clearance_insert() {
            if ($('#name').val() == "" || $('#fathername').val() == "" || $('#addmodaldob').val() == "" || $('#ddl_vendor_popup').val() == "0" || $('#ddl_department_popup').val() == "0" || $('#ddl_division').val() == "0" || $('#ddl_reqtype').val() == "0") {
                left("Please fill all the mandatory fileds");
            } else {
                if ($('#aadhar').val().length < 12) { left("Aadhar should be 12 digit!"); }
                else {
                    if ($('#ddl_reqtype').val() == "CR" || $('#ddl_reqtype').val() == "CRR") {
                        $.ajax({
                            type: "POST",
                            url: "UIDReturnreplace.aspx/UIDRetunreplaceSave",
                            dataType: "json",
                            data: JSON.stringify({ typ: "15", reqno: $('#reqno').val(), name: $('#name').val(), fname: $('#fathername').val(), dob: $('#addmodaldob').val(), company: $('#ddl_vendor_popup').val(), department: $('#ddl_department_popup').val(), division: $('#ddl_division').val(), aadhar: $('#aadhar').val(), reqtype: $('#ddl_reqtype').val() }),
                            contentType: "application/json",
                            success: function (data) {
                                if (data.d.length > 0) {
                                    console.log(data);
                                    var response = eval(data.d);
                                    console.log("response", response);
                                    if (response.length > 0) {
                                        $('#add_employee').modal('hide');
                                        left(response[0].TXT);
                                        removemyloading();
                                    }
                                }
                            }
                        });

                    }/////

                    else {
                        var doctype = [];
                        var doc = [];
                        var dataD = '';
                        if ($('#filenamebillnew')[0].innerHTML == "") {
                            alert("Required Document must upload");

                        } else {
                            var data = new FormData();
                            var files = '';
                            var fileUploadbilldynamic = '';
                            var fileUploadbill = $("#filesbillnew").get(0);
                            doctype.push("13");
                            doc.push($('#filenamebillnew')[0].innerHTML);
                            files = fileUploadbill.files;
                            for (var i = 0; i < files.length; i++) {
                                data.append(files[i].name, files[i]);

                            }

                            data.append("typ", "15");
                            data.append("reqno", $('#reqno').val());
                            data.append("name", $('#name').val());
                            data.append("fname", $('#fathername').val());

                            data.append("dob", $('#addmodaldob').val());
                            data.append("company", $('#ddl_vendor_popup').val());
                            data.append("department", $('#ddl_department_popup').val());
                            data.append("division", $('#ddl_division').val());

                            data.append("aadhar", $('#aadhar').val());
                            data.append("reqtype", $('#ddl_reqtype').val());

                            data.append("doctype", doctype.toString());
                            data.append("doc", doc.toString());
                            $.ajax({
                                url: 'cardlost.ashx',
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



                    /////
                }
            }
        }

        $(document).ready(function () { getedatatble(); });
        function getedatatble() {
            $.ajax({
                type: "POST",
                url: "UIDReturnreplace.aspx/bindata",
                dataType: "json",
                data: JSON.stringify({ typ: "16" }),
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
                        var lbl_div = '';
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

                                } else if (j == col.length - 3) {
                                    if ((fault[i][col[j]] != "" || fault[i][col[j]] != null) && fault[i][col[j + 1]] == "Card Lost") {
                                        td += '<td><i class="fa fa-file-pdf-o text-danger" aria-hidden="true" style="font-size: 30px;" id="' + fault[i][col[j]] + '" onclick="pdfdownloadfunc(' + fault[i][col[j]] + ')"></i></td>';
                                    } else {
                                        td += '<td><i class="fa fa-ban text-danger" aria-hidden="true" style="font-size: 30px;" id="' + fault[i][col[j]] + '"></i></td>';
                                    }

                                }
                                else {
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
                            "scrollY": 230,
                            "scrollX": true,
                            "scrollCollapse": true,
                            //columnDefs: [
                            //{
                            //    "visible": true, "targets": groupColumn,
                            //    render: function (data, type, row, meta) {
                            //        data = '<a href="javascript:" onclick="backendcall(this)">' + encodeURIComponent(data) + '</a>';
                            //        return data;
                            //    }
                            //},
                            //],                           
                            buttons: [{
                                //''   
                                extend: 'excel',
                                filename: 'UID Return-Replace Lost list'
                            },
                            ]
                        });
                    }
                }
            });
        }

        var rrrequesttype = '';
        function edit_employee(obj) {
            var valterminate = obj.split(',');
            $('#edit_employee').modal('show');
            $('#terminationname').val(valterminate[1]);
            $('#terminationaadhar').val(valterminate[0]);
            $('#terminationuid').val(valterminate[2]);
            if (valterminate[3] != "") {
                $('#div_ddl_cardaccept').hide();
                $('#div_txt_uidtype').show();
                $('#div_txtremarks').show();
                $('#div_newuidno').show();
                document.getElementById("newuidno").defaultValue = $('#terminationuid').val();
                $('#div_txt_validupto').show();
                $('#div_txt_validupto').val("");
            }
            if (valterminate[3] == "Card Lost") {
                $('#div_ddl_cardaccept').hide();
                $('#div_txt_uidtype').show();
                $('#div_txtremarks').show();
                $('#div_newuidno').show();
                $('#txt_oldvalidity').val(valterminate[4]); //added for UAT 18 march 2021
                document.getElementById("newuidno").defaultValue = $('#terminationuid').val();
                $('#div_txt_validupto').show();
                $('#div_txt_validupto').val("");
            }
            if (valterminate[3] == "Card Replace") {
                $('#div_ddl_cardaccept').show();
                $('#div_txt_uidtype').show();
                $('#div_txtremarks').show();
                $('#div_newuidno').show();
                $('#txt_oldvalidity').val(valterminate[4]); //added for UAT 18 march 2021
                document.getElementById("newuidno").defaultValue = $('#terminationuid').val();
                $('#div_txt_validupto').show();
                $('#div_txt_validupto').val("");
            }
            if (valterminate[3] == "Card Return") {
                $('#div_ddl_cardaccept').show();
                $('#div_txt_uidtype').hide();
                $('#div_txtremarks').show();
                $('#div_newuidno').hide();
                $('#div_txt_validupto').hide();
                $('#div_txt_validupto').val("");
                $('#txt_oldvalidity').val(valterminate[4]); //added for UAT 18 march 2021
            }
            rrrequesttype = valterminate[3];
        }

        function function_edit_deactive() {
            var rrtype = true;

            if (rrrequesttype == "Card Lost") {
                if ($('#txt_uidtype').val() == "0" || $('#txt_validupto').val() == "") {
                    rrtype = false;
                }
            }
            if (rrrequesttype == "Card Replace") {
                if ($('#txt_uidtype').val() == "0" || $('#txt_validupto').val() == "" || $('#ddl_cardaccept').val() == "0") {
                    rrtype = false;
                }
            }
            if (rrrequesttype == "Card Return") {
                if ($('#ddl_cardaccept').val() == "0") {
                    rrtype = false;
                }
            }

            if (rrtype == true) {
                $.ajax({
                    type: "POST",
                    url: "UIDReturnreplace.aspx/employeeterminate",
                    dataType: "json",
                    data: JSON.stringify({ typ: "19", aadhar: $('#terminationaadhar').val(), status: $('#ddl_cardaccept').val(), UID: $('#terminationuid').val(), txt_uidtype: $('#txt_uidtype').val(), txtremarks: $('#txtremarks').val(), newuidno: $('#newuidno').val(), txt_validupto: $('#txt_validupto').val() }),
                    contentType: "application/json",
                    success: function (data) {
                        if (data.d.length > 0) {
                            var response = eval(data.d);
                            console.log("response", response);
                            if (response.length > 0) {
                                left(response[0].TXT);
                                $('#edit_employee').modal('hide');

                            }
                        }
                    }
                });
            } else {
                left("Please fill all the mandatory fileds");
            }
        }
        $('#txt_validupto').datepicker({ minDate: 0 });
        function exportdatamethod() {
            debugger;
            $('.buttons-excel').trigger('click');
        }
    </script>
    <script>
        function pdfdownloadfunc(requestNo) {
            console.log(requestNo.id);
            $.ajax({

                url: 'UIDReturnreplace.aspx/createpdf',

                type: "POST",

                dataType: "json",

                data: JSON.stringify({ refno: requestNo.id }),

                contentType: "application/json; charset=utf-8",

                success: function (data) {

                    console.log(data);
                    // window.location.href = data.d;
                    var dataResult = $.parseJSON(data.d);
                    if (dataResult.length > 0 && dataResult[0].STATUS > 0) {
                        var sampleArr = base64ToArrayBuffer((dataResult[0].FileBase64));
                        saveByteArray(dataResult[0].FileName, sampleArr, dataResult[0].extension);
                    } else {
                        alert(dataResult[0].MESSAGE);
                    }
                    // removemyloading();
                }, error: function (err) {
                    console.log(err);
                    removemyloading();
                }

            });
        }

        function base64ToArrayBuffer(base64) {
            var binaryString = window.atob(base64);
            var binaryLen = binaryString.length;
            var bytes = new Uint8Array(binaryLen);
            for (var i = 0; i < binaryLen; i++) {
                var ascii = binaryString.charCodeAt(i);
                bytes[i] = ascii;
            }
            return bytes;
        }

        function saveByteArray(reportName, byte, extension) {
            var blob = new Blob([byte], { type: "application/pdf" });
            var link = document.createElement('a');
            link.href = window.URL.createObjectURL(blob);
            var fileName = reportName;
            link.download = fileName;
            link.click();
        };
    </script>
</asp:Content>

