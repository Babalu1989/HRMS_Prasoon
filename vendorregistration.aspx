<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="vendorregistration.aspx.cs" Inherits="empdt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    -<style>
        .dt-buttons {
            display: none;
        }
    </style>
    <div class="container-fluid" id="jsdatatable">
        <div class="float-left" style="margin-top: 0%;">
            <%--margin-bottom: -2%;"--%>
            <a href="#" class="btn add-btn" data-toggle="modal" data-target="#add_employee"><i class="fa fa-plus"></i>Add Vendor</a>
        </div>
        <div id="gridtablediv" style="margin-top: 0%;" class="customtextdatatable"></div>
    </div>

    <!-- Add Employee Modal -->
    <form class="form">
        <div id="add_employee" class="modal custom-modal fade" role="dialog">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add Vendor</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                <div class="modal-body">
                    <form>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label>Vendor Name <span class="text-danger">*</span></label>
                                    <input class="form-control" type="text" value="" id="newvendorname" />
                                </div>
                            </div>                          
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label>Vendor Short Name: <span class="text-danger">*</span></label>
                                    <div class="add-group-btn">
                                       <input class="form-control" type="text" value="" id="newvendornameshort" minlength="4" maxlength="8"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Effective From <span class="text-danger">*</span></label>
                                    <div class="cal-icon">
                                        <input type="text" class="form-control datetimepicker" value="" id="newdate" autocomplete="off" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Effective To <span class="text-danger">*</span></label>
                                    <div class="cal-icon">
                                        <input type="text" class="form-control datetimepicker" value="" id="newdateto" autocomplete="off" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Work order No <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" value="" id="neworderno" autocomplete="off" />
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <a href="javascript:void(0);" class="btn btn-primary edit-btn" onclick="BrowseFile('filesbillnew');" style="margin-left: 4%; margin-top: 29px;"><i class="fa fa-paperclip"></i></a>
                                <div class="form-group">
                                    <div class="file-field">
                                         <label>Document:<span class="text-danger">*</span></label>
                                        <span id="filenamebillnew" class="text-success"></span>
                                        <asp:FileUpload ID="filesbillnew" ClientIDMode="Static" runat="server" Style="display: none" accept="application/pdf" onchange="onChange_FileUpload(this,'filenamebillnew')" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Conatct Person:<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" value="" id="newcontactperson" autocomplete="off" />
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Conatct Number : <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" value="" onkeypress="return validatenumber(event)" maxlength="10" id="newnumber" autocomplete="off" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label>Conatct Email:<span class="text-danger">*</span></label>
                                    <input type="email" class="form-control" value="" id="newemail" autocomplete="off" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Reason <span class="text-danger">*</span></label>
                            <textarea class="form-control" rows="4" id="newreason"></textarea>
                        </div>                      
                        <div class="submit-section">
                            <button class="btn btn-primary submit-btn" onclick="newdocumentsave();">Submit</button>
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
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label>Vendor Name <span class="text-danger">*</span></label>
                                    <input class="form-control" type="text" value="" id="terminationname" disabled="disabled" />
                                </div>
                            </div>                          
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label>Status <span class="text-danger">*</span></label>
                                    <div class="add-group-btn">
                                        <asp:DropDownList runat="server" ID="ddl_terminationtype" ClientIDMode="Static" class="form-control"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Effective From <span class="text-danger">*</span></label>
                                    <div class="cal-icon">
                                        <input type="text" class="form-control datetimepicker" value="" id="terminationdatefrom" autocomplete="off" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Effective To <span class="text-danger">*</span></label>
                                    <div class="cal-icon">
                                        <input type="text" class="form-control datetimepicker" value="" id="terminationdate" autocomplete="off" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Work order No <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" value="" id="txtworkorderno" autocomplete="off" />
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <a href="javascript:void(0);" class="btn btn-primary edit-btn" onclick="BrowseFile('filesbill');" style="margin-left: 4%; margin-top: 29px;"><i class="fa fa-paperclip"></i></a>
                                <div class="form-group">
                                    <div class="file-field">
                                         <label>Document:<span class="text-danger">*</span></label>
                                        <span id="filenamebill" class="text-success"></span>
                                        <asp:FileUpload ID="filesbill" ClientIDMode="Static" runat="server" Style="display: none" accept="application/pdf" onchange="onChange_FileUpload(this,'filenamebill')" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Conatct Person:<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" value="" id="terminationperson" autocomplete="off" />
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Conatct Number : <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" value="" onkeypress="return validatenumber(event)" maxlength="10" id="terminationcontact" autocomplete="off" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label>Conatct Email:<span class="text-danger">*</span></label>
                                    <input type="email" class="form-control" value="" id="terminationemail" autocomplete="off" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Reason <span class="text-danger">*</span></label>
                            <textarea class="form-control" rows="4" id="terminationreason"></textarea>
                        </div>                      
                        <div class="submit-section">
                            <button class="btn btn-primary submit-btn" onclick="documentsave();">Submit</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- Edit terminate Employee Modal -->

    <script>
        $(document).ready(function () {
            getedatatble();
        });
        var vencode = '';
        function getedatatble() {
            loadmyloading();
            $.ajax({
                type: "POST",
                url: "vendorregistration.aspx/bindata",
                dataType: "json",
                data: JSON.stringify({ typ: "15" }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        removemyloading();
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
                                if (j == col.length - 5) {
                                    if (fault[i][col[j]] == "" || fault[i][col[j]] == null) {
                                        td += '<td><i class="fa fa-ban text-danger" aria-hidden="true" style="font-size: 30px;" id="' + fault[i][col[j]] + '"></i></td>';
                                    } else {
                                        td += '<td><i class="fa fa-file-pdf-o text-danger" aria-hidden="true" style="font-size: 30px;" id="' + fault[i][col[j]] + '" onclick="pdfdownloadfunc(this)"></i></td>';
                                    }

                                } else if (j == col.length - 4) {
                                    if (fault[i][col[j]] == "Working") {
                                        td += '<td><span class="badge badge-success-border">' + fault[i][col[j]] + '</span></td>';
                                    } else {
                                        td += '<td><span class="badge badge-danger-border">' + fault[i][col[j]] + '</span></td>';
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
                        $('#gridtable').DataTable({
                            columnDefs: [
                             {
                                 "targets": [10],
                                 "visible": false,
                             },
                             {
                                 "targets": [11],
                                 "visible": false
                             }
                            ],
                            "scrollCollapse": true, dom: 'Bfrtip',
                            "paging": false,
                            "sorting": false,
                            "scrollY": 230,
                            "scrollX": true,
                            "scrollCollapse": true,
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
        function edit_employee(obj) {
            var valterminate = obj.split(',');
            $('#edit_employee').modal('show');
            vencode = valterminate[0];
            $('#terminationname').val(valterminate[1]);
            $('#ddl_terminationtype').val(valterminate[2]);
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

        function newdocumentsave() {
            debugger;
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
                doctype.push("");
                doc.push($('#filenamebillnew')[0].innerHTML);
                files = fileUploadbill.files;
                for (var i = 0; i < files.length; i++) {
                    data.append(files[i].name, files[i]);

                }
                data.append("vendor", "");
                data.append("vendorname", $('#newvendorname').val());
                data.append("vendorshort", $('#newvendornameshort').val());
                data.append("type", "16A");

                data.append("status","");
                data.append("fromdate", $('#newdate').val());
                data.append("todate", $('#newdateto').val());
                data.append("orderno", $('#neworderno').val());
                data.append("person", $('#newcontactperson').val());
                data.append("contact", $('#newnumber').val());
                data.append("email", $('#newemail').val());
                data.append("reason", $('#newreason').val());
                data.append("doctype", doctype.toString());
                data.append("doc", doc.toString());
                $.ajax({
                    url: 'vendorregistration.ashx',
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

        function documentsave() {
            debugger;
            var doctype = [];
            var doc = [];
            var dataD = '';         
            if ($('#filenamebill')[0].innerHTML == "") {
                alert("Required Document must upload");

            } else {
                var data = new FormData();
                var files = '';
                var fileUploadbilldynamic = '';
                var fileUploadbill = $("#filesbill").get(0);
                doctype.push($('#ddl_terminationtype')[0].value);
                doc.push($('#filenamebill')[0].innerHTML);
                files = fileUploadbill.files;
                for (var i = 0; i < files.length; i++) {
                    data.append(files[i].name, files[i]);

                }              
                data.append("vendor", vencode);               
                data.append("vendorname", "");
                data.append("vendorshort", "");
                data.append("type", "16");

                data.append("status", $('#ddl_terminationtype').val());
                data.append("fromdate", $('#terminationdatefrom').val());
                data.append("todate", $('#terminationdate').val());
                data.append("orderno", $('#txtworkorderno').val());
                data.append("person", $('#terminationperson').val());
                data.append("contact", $('#terminationcontact').val());
                data.append("email", $('#terminationemail').val());
                data.append("reason", $('#terminationreason').val());


                data.append("doctype", doctype.toString());
                data.append("doc", doc.toString());
                $.ajax({
                    url: 'vendorregistration.ashx',
                    type: 'POST',
                    data: data,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (file) {
                        console.log("file", file);
                        $('#edit_employee').modal('hide');
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

    </script>
</asp:Content>

