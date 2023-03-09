<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="Reportingofficer.aspx.cs" Inherits="Common_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <span style="float: left;" onclick="exportdatamethod()" class="pull-right"><i class="fa fa-file-excel-o " style="font-size: 30px; float: left; color: green;"></i></span>
    <div class="container-fluid form-scroll" id="jsdatatable" style="margin-top: -2%;">
        <div id="gridtablediv" class="customtextdatatable"></div>
    </div>


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
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label>Employee ID<span class="text-danger">*</span></label>
                                    <input class="form-control" type="text" value="" id="empid" disabled="disabled" />
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label>Employee name <span class="text-danger">*</span></label>
                                    <input class="form-control" type="text" value="" id="name" disabled="disabled" />
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label>Mobile <span class="text-danger">*</span></label>
                                    <input class="form-control" type="text" value="" id="mobile" maxlength="10" onkeypress="return validatenumber(event)" />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label>Division <span class="text-danger">*</span></label>
                                    <div class="add-group-btn">
                                        <asp:DropDownList runat="server" ID="ddl_division" ClientIDMode="Static" class="form-control" onchange="getsubdivmodal(this);"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label>Sub-Division <span class="text-danger">*</span></label>
                                    <div class="add-group-btn">
                                        <asp:ListBox runat="server" ID="profilemodalsubdivision" ClientIDMode="Static" class="form-control" SelectionMode="Multiple"></asp:ListBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label>Email: <span class="text-danger">*</span></label>
                                    <textarea class="form-control" id="email"></textarea>
                                </div>
                            </div>
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
    <style>
        .dt-buttons {
            display: none;
        }
    </style>

    <script>
        $(document).ready(function () {
            getedatatble();

        });

        function getedatatble() {
            $.ajax({
                type: "POST",
                url: "Reportingofficer.aspx/bindata",
                dataType: "json",
                data: JSON.stringify({ typ: "5", div: "", subdiv: "" }),
                contentType: "application/json",
                success: function (data) {
                    console.log("data", data);
                    var empdetails = eval(data.d);
                    if (data.d.length > 0) {
                        $('#gridtablediv').html('');
                        debugger;
                        var gridtable = '  <table id="gridtable"  class="table table-striped custom-table datatable dataTable no-footer" role="grid">';
                        var col = [];
                        var colHeader = [];
                        var th = '';
                        var fault = eval(empdetails[0]);
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
                                td += '<td>' + fault[i][col[j]] + '</td>';
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
                                'visible': false, 'targets': [6, 7],
                            },
                            ],
                            "scrollCollapse": true, dom: 'Bfrtip',
                            buttons: [
                                 //{
                                 //    extend: 'excelHtml5',
                                 //    title: 'Data export'
                                 //},
                               'excel',
                            ],
                             dom: 'Bfrtip',                            
                            lengthMenu: [
                             [5]
                            ],
                        });
                    }
                }
            });
            function AddOption(text, value) {
                debugger;
                var option = document.createElement('option');
                option.value = value;
                option.innerHTML = text;
                ddlCountries.options.add(option);
            }
        }
        function getedatatblesub() {
            var division = ddl_div.options[ddl_div.selectedIndex].value;
            var subdiv = (ddl_subdivision.options[ddl_subdivision.selectedIndex].value == undefined) ? "" : ddl_subdivision.options[ddl_subdivision.selectedIndex].value;
            var type = '';
            if (subdiv == "") {
                type = "2";
            } else {
                type = "3";
            }
            $.ajax({
                type: "POST",
                url: "EmployeeSummary.aspx/bindata",
                dataType: "json",
                data: JSON.stringify({ typ: type, div: division, subdiv: subdiv }),
                contentType: "application/json",
                success: function (data) {
                    console.log("data", data);
                    var empdetails = eval(data.d);
                    if (data.d.length > 0) {

                        $('#gridtablediv').html('');
                        debugger;
                        var gridtable = '  <table id="gridtable"  class="table table-striped custom-table datatable dataTable no-footer" role="grid">';
                        var col = [];
                        var colHeader = [];
                        var th = '';
                        var fault = eval(empdetails[0]);
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
                                td += '<td>' + fault[i][col[j]] + '</td>';
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

        function exportdatamethod() {
            debugger;
            $('.buttons-excel').trigger('click');
        }

        function edit_employee(obj) {
            var value = obj.split(',');
            $('#edit_employee').modal('show');
            $('#empid').val(value[0]);
            $('#mobile').val(value[1]);
            $('#email').val(value[2]);
            $('#name').val(value[3]);
            $('#ddl_division').val(value[4]);
            getsubdivmodal($('#ddl_division'), value[5]);
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
        function function_edit_deactive() {

            if ($('#mobile').val() == "" || $('#ddl_division').val() == "" || $('#profilemodalsubdivision').val().toString() == "" || $('#email').val() == "") {
                 left("All Data Should be Field");
            } else {
                $.ajax({
                    type: "POST",
                    url: "Reportingofficer.aspx/l1_update",
                    dataType: "json",
                    data: JSON.stringify({ typ: "6", empid: $('#empid').val(), mobile: $('#mobile').val(), ddl_division: $('#ddl_division').val(), subdivision: $('#profilemodalsubdivision').val().toString(), email: $('#email').val() }),
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
        }
    </script>
</asp:Content>

