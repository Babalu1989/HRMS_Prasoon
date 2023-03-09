<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="UIDRenewal.aspx.cs" Inherits="UIDRenewal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <style>
        .dt-buttons {
            display: none;
        }
    </style>
    <span onclick="exportdatamethod()" class="pull-left" style="color:green;">Download File:<i class="fa fa-file-excel-o " style="font-size: 30px; margin-left: 25px; color: green;"></i></span>     
    <div class="container-fluid" id="jsdatatable">        
        <div id="gridtablediv" style="" class="customtextdatatable"></div>
    </div>
     <!-- Edit terminate Employee Modal -->
    <div id="edit_employee" class="modal custom-modal fade" role="dialog">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Renewal of Expiry ID Cards</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">Ã—</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Employee Name<span class="text-danger">*</span></label>
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
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Current Validity <span class="text-danger">*</span></label>
                                    <input class="form-control datetimepicker" type="text" value="" id="txt_oldvalidity" disabled="disabled"/>                                   
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Add New Validity <span class="text-danger">*</span></label>
                                    <input class="form-control datetimepicker" type="text" value="" id="txt_validity" readonly="readonly" style="background-color:white !important"/>                                   
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
    <script>
        $('#txt_validity').datepicker({
            minDate: -0,
            maxDate: "+1Y"
        });
     $(document).ready(function () { getedatatble(); });
     function getedatatble() {
         loadmyloading();
            $.ajax({
                type: "POST",
                url: "UIDRenewal.aspx/bindata",
                dataType: "json",
                data: JSON.stringify({ typ: "17" }),
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
                                filename: 'Renewal list'
                            },
                            ]
                          
                        });
                    }
                }
            });
            removemyloading();
        }


        function edit_employee(obj) {
            var valterminate = obj.split(',');
            $('#edit_employee').modal('show');
            $('#terminationname').val(valterminate[1]);
            $('#terminationaadhar').val(valterminate[0]);
            $('#terminationuid').val(valterminate[2]);
            $('#txt_oldvalidity').val(valterminate[3]);
        }

        function function_edit_deactive() {
            if ($('#txt_validity').val() == "") { left("Please fill the mandatory fileds"); } else {
                $.ajax({
                    type: "POST",
                    url: "UIDRenewal.aspx/employeeidvalidity",
                    dataType: "json",
                    data: JSON.stringify({ typ: "18", aadhar: $('#terminationaadhar').val(), newvalidity: $('#txt_validity').val(), UID: $('#terminationuid').val() }),
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
        }
        function exportdatamethod() {
            debugger;
            $('.buttons-excel').trigger('click');
        }
      
    </script>
</asp:Content>

