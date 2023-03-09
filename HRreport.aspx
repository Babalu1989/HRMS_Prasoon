<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="HRreport.aspx.cs" Inherits="HRreport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="assets/js/editor.js"></script>
    <div>
        <span style="/*margin-right: 54%; margin-top: 1%; */" onclick="exportdatamethod()" class="pull-right"><i class="fa fa-file-excel-o " style="font-size: 30px; color: green;"></i></span>
    </div>
    <div class="container-fluid" id="jsdatatable" style="margin-top: -2%;">
        <div id="gridtablediv" class="customtextdatatable"></div>
    </div>  
       <!-- Edit terminate Employee Modal -->
    <div id="edit_details" class="modal custom-modal fade" role="dialog">
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
                            <label>Last Date <span class="text-danger">*</span></label>
                            <div class="cal-icon">
                                <input type="text" class="form-control datetimepicker" value="" id="terminationdate" autocomplete="off" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Reason <span class="text-danger">*</span></label>
                            <textarea class="form-control" rows="4" id="terminationreason"></textarea>
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
            display:none;
        }
    </style>
    <script>
        $(document).ready(function () {
            getedatatble();                     
        });
        $(document).on('click', '.odd', function () {
            // your function here   
            var table = $('#gridtable').DataTable();
            var data = table.row(this).data();
          //  alert('You clicked on ' + data[0] + '\'s row');
           // $('#edit_details').modal('show');
            //data[0].edit({
            //        buttons: [
            //            { label: 'Cancel', fn: function () { this.close(); } },
            //            'Edit'
            //        ]
            //    });
        });      
        function getedatatble() {
            $.ajax({
                type: "POST",
                url: "HRreport.aspx/bindata",
                dataType: "json",
                data: JSON.stringify({ typ: "5" }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $('#gridtablediv').html('');
                        debugger;
                        var gridtable = '';
                        gridtable = '  <table id="gridtable"  class="table table-striped custom-table datatable dataTable no-footer" role="grid">';
                        var col = [];
                        var colHeader = [];
                        var th = '';
                        var tfoot = '';
                        var fault = eval(data.d);
                        for (var i = 0; i < fault.length; i++) {
                            for (var key in fault[i]) {
                                if (col.indexOf(key) === -1) {
                                    col.push(key);
                                    colHeader.push({ data: key, title: key })

                                    th += '<th style="text-align: center;">' + key + '</th>';
                                    tfoot += '<th ></th>';//For Footer added by prasoon 15-10-2019
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
                                if (j == 0) {
                                    td += '<td>' + fault[i][col[j]] + '</td>';
                                } else {
                                    td += '<td style="text-align: center;">' + fault[i][col[j]] + '</td>';
                                }
                            }
                            td += ' </tr>';
                        }
                        gridtable += '  <tbody> ' + td + '</tbody>';
                        gridtable += '  <tfoot align="center"> <tr class="gridheader">' + tfoot + '</tr></thead>';//For Footer added by prasoon 15-10-2019
                        gridtable += ' </table>';
                        $('#gridtablediv').append(gridtable);
                        removemyloading();
                        $('#gridtable').dataTable({
                            "footerCallback": function (row, data, start, end, display) {
                                var api = this.api(), data;
                                // converting to interger to find total
                                var intVal = function (i) {
                                    return typeof i === 'string' ?
                                        i.replace(/[\$,]/g, '') * 1 :
                                        typeof i === 'number' ?
                                        i : 0;
                                };

                                // computing column Total the complete result 
                                var monTotal = api
                                    .column(1)
                                    .data()
                                    .reduce(function (a, b) {
                                        return intVal(a) + intVal(b);
                                    }, 0);

                                var tueTotal = api
                                   .column(2)
                                   .data()
                                   .reduce(function (a, b) {
                                       return intVal(a) + intVal(b);
                                   }, 0);

                                var wedTotal = api
                                   .column(3)
                                   .data()
                                   .reduce(function (a, b) {
                                       return intVal(a) + intVal(b);
                                   }, 0);

                                var thuTotal = api
                                   .column(4)
                                   .data()
                                   .reduce(function (a, b) {
                                       return intVal(a) + intVal(b);
                                   }, 0);
                                $(api.column(0).footer()).html('Incl GST');
                                $(api.column(1).footer()).html((monTotal * 1.18).toFixed(2));
                                $(api.column(2).footer()).html((tueTotal * 1.18).toFixed(2));
                                $(api.column(3).footer()).html((wedTotal * 1.18).toFixed(2));
                                $(api.column(4).footer()).html((thuTotal * 1.18).toFixed(2));
                            },
                            buttons: [
                              'excel',
                            ],
                            "paging": false,
                            "sorting": false,
                            "info": false,
                            dom: "Bfrtip",
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

