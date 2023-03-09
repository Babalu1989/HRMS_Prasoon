<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="EmployeeDetail.aspx.cs" Inherits="EmployeeDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .dataTables_length {
            display: none;
        }
        .buttons-excel {
            display:none;
        }
    </style>
    <div>
         <span style="" onclick="exportdatamethod()" class="pull-right"><i class="fa fa-file-excel-o " style="font-size: 30px; color: green;"></i></span>
    </div>
    <!-- Page Content -->
    <div class="container-fluid">
        <span class="float-left" style="margin-top: 1%;">Division: &nbsp;&nbsp;</span>
        <div class="float-left" style="margin-top: 0%;">
            <asp:DropDownList runat="server" ID="ddl_division" CssClass="form-control" ClientIDMode="Static" Enabled="false"></asp:DropDownList>

        </div>
        <span class="float-left" style="margin-top: 1%;">&nbsp;&nbsp;Sub-Division: &nbsp;&nbsp;</span>
        <div class="float-left" style="margin-top: 0%;">
            <asp:DropDownList runat="server" ID="ddl_subdiv" CssClass="form-control" ClientIDMode="Static" onchange="getsubdivdata(this);"></asp:DropDownList>

        </div>
        <div id="gridtablediv" class="customtextdatatable" />
    </div>
    <script>
        $(document).ready(function () {
            getedatatble("0");
        });
        $("#ddl_division").change(function () {
            getedatatble("0");
        });
        function exportdatamethod() {
            debugger;
            $('.buttons-excel').trigger('click');
        }
      
        function getsubdivdata(obj) {
            getedatatblesubdiv($('#ddl_subdiv').val());
        }
        var ddlCountries;
        function getedatatble(subdiv) {
            
            ddlCountries = document.getElementById("<%=ddl_subdiv.ClientID %>");
                ddlCountries.options.length = 0;
            $.ajax({
                type: "POST",
                url: "EmployeeDetail.aspx/bindata",
                dataType: "json",
                data: JSON.stringify({ typ: "4", subdivvalue: subdiv, div: $('#ddl_division').val() }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $('#gridtablediv').html('');
                        debugger;
                        var gridtable = '  <table id="gridtable"  class="table table-striped custom-table datatable dataTable no-footer" role="grid">';
                        var col = [];
                        var colHeader = [];
                        var th = '';
                        var empdetails = eval(data.d);
                        console.log("empdetails", empdetails);
                        var fault = eval(empdetails[0]);
                        AddOption("--Select--", "0");
                        for (var i = 0; i < (empdetails[1].length) - 1; i++) {
                            AddOption(empdetails[1][i].SUB_DIV, empdetails[1][i].SUB_DIV_CODE);

                        }

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
                                if (j == col.length - 1) {
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
                                    //                                    data = '<a href="javascript:" onclick="backendcall(this)">' + encodeURIComponent(data) + '</a>';
                                    data = encodeURIComponent(data) ;
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

        function AddOption(text, value) {
            debugger;
            var option = document.createElement('option');
            option.value = value;
            option.innerHTML = text;
            ddlCountries.options.add(option);
        }

        function getedatatblesubdiv(subdiv) {         
            $.ajax({
                type: "POST",
                url: "EmployeeDetail.aspx/bindatasubdivwise",
                dataType: "json",
                data: JSON.stringify({ typ: "4", subdivvalue: subdiv, div: $('#ddl_division').val() }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $('#gridtablediv').html('');
                        debugger;
                        var gridtable = '  <table id="gridtable"  class="table table-striped custom-table datatable dataTable no-footer" role="grid">';
                        var col = [];
                        var colHeader = [];
                        var th = '';
                        var empdetails = eval(data.d);
                        console.log("empdetails", empdetails);
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
                                if (j == col.length - 1) {
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





    </script>
    <!-- /Script End -->


</asp:Content>

