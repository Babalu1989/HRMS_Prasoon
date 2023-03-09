<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="Common_report.aspx.cs" Inherits="Common_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">    
    <div>
        <span style="/*margin-right: 54%;margin-top: 1%;*/" onclick="exportdatamethod()" class="pull-right"><i class="fa fa-file-excel-o " style="font-size: 30px; color: green;"></i></span>
        <span class="float-left" style="margin-top: 1%;">Report Based On: &nbsp;&nbsp;</span>
        <div class="float-left" style="margin-top: 0%;">           
            <asp:DropDownList runat="server" ID="ddl_based" CssClass="form-control" ClientIDMode="Static"></asp:DropDownList>
           
        </div>
    </div>
    <div class="container-fluid form-scroll" id="jsdatatable" style="margin-top: -2%;">
        <div id="gridtablediv" class="customtextdatatable"></div>
    </div>
    <style>
        .dt-buttons {
            display:none;
        }
    </style>

    <script>
        $("#ddl_based").change(function () {
            loadmyloading();
            getedatatble();
        });

        function getedatatble() {
            var ddlvalue = ddl_based.options[ddl_based.selectedIndex].value;
            $.ajax({
                type: "POST",
                url: "common_report.aspx/bindata",
                dataType: "json",
                data: JSON.stringify({ typ: ddlvalue }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $('#gridtablediv').html('');
                        debugger;
                        var gridtable='';
                        gridtable = '  <table id="gridtable"  class="table table-striped custom-table datatable dataTable no-footer" role="grid">';
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
                                td += '<td>' + fault[i][col[j]] + '</td>';
                            }
                            td += ' </tr>';
                        }
                        gridtable += '  <tbody> ' + td + '</tbody>';
                        gridtable += ' </table>';
                        $('#gridtablediv').append(gridtable);
                        removemyloading();
                        $('#gridtable').DataTable({
                            "info": true,
                            dom: 'Bfrtip',
                            "paging": false,                          
                            "sorting": false,                                                 
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

