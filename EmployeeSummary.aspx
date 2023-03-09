<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="EmployeeSummary.aspx.cs" Inherits="Common_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <span style="/*margin-right: 54%;margin-top: 1%;*/" onclick="exportdatamethod()" class="pull-right"><i class="fa fa-file-excel-o " style="font-size: 30px; color: green;"></i></span>
        <span class="float-left" style="margin-top: 1%;">Division: &nbsp;&nbsp;</span>
        <div class="float-left" style="margin-top: 0%;">           
            <asp:DropDownList runat="server" ID="ddl_div" CssClass="form-control" ClientIDMode="Static"></asp:DropDownList>
           
        </div>
         <span class="float-left" style="margin-top: 1%;">Sub-Division: &nbsp;&nbsp;</span>
        <div class="float-left" style="margin-top: 0%;">           
            <asp:DropDownList runat="server" ID="ddl_subdivision" CssClass="form-control" ClientIDMode="Static">
                <asp:ListItem Value="" Text="--Select--"></asp:ListItem>
            </asp:DropDownList>           
        </div>

    </div>
    <div class="container-fluid" id="jsdatatable" style="margin-top: -2%;">
        <div id="gridtablediv" class="customtextdatatable" style="margin-left: -40px;"></div>
    </div>
    <style>
        .dt-buttons {
            display:none;
        }
    </style>

    <script>
        $("#ddl_div").change(function () {
            getedatatble();
        });
        $("#ddl_subdivision").change(function () {
            getedatatblesub();
        });

        function getedatatble() {
            //$('#ddl_subdivision').val(0);
            var ddlCountries;
            ddlCountries = document.getElementById("<%=ddl_subdivision.ClientID %>");                      
            ddlCountries.options.length = 0;
            AddOption("--Select--", "");
            var division = ddl_div.options[ddl_div.selectedIndex].value;
            var subdiv = (ddl_subdivision.options[ddl_subdivision.selectedIndex].value == undefined) ? "" : ddl_subdivision.options[ddl_subdivision.selectedIndex].value;
            var type='';
            if(subdiv=="")
            {
                type="2";
            }else{
                type="3";
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
                        for (var i = 0; i < (empdetails[1].length)-1; i++) {
                               AddOption(empdetails[1][i].SUB_DIV, empdetails[1][i].SUB_DIV_CODE);

                           }                      

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
                                 //{
                                 //    extend: 'excelHtml5',
                                 //    title: 'Data export'
                                 //},
                               'excel',                              
                            ],          
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
    </script>
</asp:Content>

