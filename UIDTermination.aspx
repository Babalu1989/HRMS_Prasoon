<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="UIDTermination.aspx.cs" Inherits="UIDTermination" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="assets/js/underscore.js"></script>
    <style>
        .dt-buttons {
            display: none;
        }
    </style>
    <span onclick="exportdatamethod()" class="pull-right"><i class="fa fa-file-excel-o " style="font-size: 30px; margin-left: 25px; color: green;"></i></span>
    <div class="container-fluid" id="jsdatatable">   
        Employee Status: <b><a id="divcnt" class="ml-2"></a>     </b>
        <div id="gridtablediv" style="" class="customtextdatatable"></div>
    </div>
    <!-- Edit terminate Employee Modal -->
    <div id="edit_employee" class="modal custom-modal fade" role="dialog">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Employee ID Card Status</h5>
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

                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>UID <span class="text-danger">*</span></label>
                                    <input class="form-control" type="text" value="" id="terminationuid" disabled="disabled" />
                                </div>
                            </div>
                            <div class="col-sm-6">
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
                        <div class="form-group">
                            <label>Remarks <span class="text-danger">*</span></label>
                            <textarea class="form-control" rows="4" id="terminationreason"></textarea>
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
        $(document).ready(function () { getedatatble(); });
        function getedatatble() {
            $.ajax({
                type: "POST",
                url: "UIDTermination.aspx/bindata",
                dataType: "json",
                data: JSON.stringify({ typ: "13" }),
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
                        var statusnam;
                        statusnam = (_.groupBy(fault, 'Employee Status'));
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
                            "scrollCollapse": true, dom: 'Bfrtip',
                            "paging": false,
                            "sorting": false,
                            "scrollY": 280,
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
                                filename: 'UID Termination list'
                                },
                            ]                           
                        });
                    }
                }
            });
        }


        function edit_employee(obj) {
            var valterminate = obj.split(',');
            $('#edit_employee').modal('show');
            $('#terminationname').val(valterminate[1]);
            $('#terminationaadhar').val(valterminate[0]);
            $('#terminationuid').val(valterminate[2]);
        }

        function function_edit_deactive() {
            if ($('#ddl_cardaccept').val() == "" || $('#terminationreason').val() == "") { left("Please fill all the mandatory fileds"); } else {
                $.ajax({
                    type: "POST",
                    url: "UIDTermination.aspx/employeeterminate",
                    dataType: "json",
                    data: JSON.stringify({ typ: "14", aadhar: $('#terminationaadhar').val(), status: $('#ddl_cardaccept').val(), UID: $('#terminationuid').val(), reason: $('#terminationreason').val() }),
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

