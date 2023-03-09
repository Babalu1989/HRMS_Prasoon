<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="Seperation.aspx.cs" Inherits="Seperation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .dt-buttons {
            display: none;
        }
    </style>
    <div id="gridtablediv" style="margin-top: 0%;" class="customtextdatatable"></div>

    <div class="modal custom-modal fade show" id="attendance_info" role="dialog" aria-modal="true" style="display: none; padding-left: 17px;">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Activity Info</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card punch-status">
                                <div class="card-body">
                                    <h5 class="card-title">Employee Details<small class="text-muted"></small></h5>
                                    <div class="form-scroll">

                                        <div class="punch-det">
                                            <h6>Name</h6>
                                            <p id="name"></p>
                                        </div>
                                        <div class="punch-det">
                                            <h6>Company</h6>
                                            <p id="company"></p>
                                        </div>
                                        <div class="punch-det">
                                            <h6>Aadhar</h6>
                                            <p id="aadhar"></p>
                                        </div>
                                        <div class="punch-det">
                                            <h6>Department</h6>
                                            <p id="department"></p>
                                        </div>
                                        <div class="punch-det">
                                            <h6>Mobile</h6>
                                            <p id="mobile"></p>
                                        </div>
                                        <div class="punch-det">
                                            <h6>L1 Employee Name</h6>
                                            <p id="liname"></p>
                                        </div>
                                        <div class="punch-det">
                                            <h6>L1 Mobile</h6>
                                            <p id="limobile"></p>
                                        </div>
                                        <div class="punch-det">
                                            <h6>Uploaded by</h6>
                                            <p id="uploadedby"></p>
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
                                        <ul class="res-activity-list" id="uldiv">
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>

        $(document).ready(function () {
            getedatatble();
        });

        function getedatatble() {
            $.ajax({
                type: "POST",
                url: "Seperation.aspx/bindata",
                dataType: "json",
                data: JSON.stringify({ typ: "102" }),
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

        function backendcall(obj) {
            $('#uldiv').empty();
            var aadhar = obj.innerHTML;
            $.ajax({
                type: "POST",
                url: "Seperation.aspx/bindmoredata",
                dataType: "json",
                data: JSON.stringify({ typ: "102A", emp: aadhar }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var fault = eval(data.d);
                        console.log(fault);
                        $('#name')[0].innerText = fault[0].EMP_NAME;
                        $('#company')[0].innerText = fault[0].EMP_COMP;
                        $('#aadhar')[0].innerText = fault[0].AADHAAR;
                        $('#department')[0].innerText = fault[0].EMP_DEPT;
                        $('#mobile')[0].innerText = fault[0].MOBILE;
                        $('#liname')[0].innerText = fault[0].L1_NAME;
                        $('#limobile')[0].innerText = fault[0].L1_MOBILE;
                        $('#uploadedby')[0].innerText = fault[0].INSRTBY;
                        $('#attendance_info').modal('show');                       
                        var array = fault[0].ACTIVITY.split('|');
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

                    }
                }
            });
        }
    </script>
</asp:Content>


