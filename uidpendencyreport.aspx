<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="uidpendencyreport.aspx.cs" Inherits="uidpendencyreport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .dataTables_filter {
            margin-top: -4%;
        }
    </style>
     <div class="row"><div class="col-lg-12"><b>UID Report</b></div></div>
    <div class="col-lg-11" style="display: none">
        <table align="left" style="font-family: Verdana; font-size: small; margin: 7px 10px;">
            <tr>
                <td>From Date &nbsp; </td>
                <td>
                    <input class="form-control datetimepicker" type="text" value="" id="txt_frdt" readonly="readonly" style="background-color: white !important" />
                </td>
                <td>&nbsp; To Date &nbsp; </td>
                <td>
                    <input class="form-control datetimepicker" type="text" value="" id="txt_todt" readonly="readonly" style="background-color: white !important" />
                </td>
                <td>&nbsp;&nbsp;<a id="btn_srch" style="Width: 100px;" class="btn btn-danger  btn-sm" onclick="getdata();return false;">Show</a></td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lbl_nmmsg" runat="server" ForeColor="#dc3545"></asp:Label>
                </td>
                <td><span onclick="exportdatamethod()" class="pull-right"><i class="fa fa-file-excel-o " style="font-size: 30px; color: green;"></i></span></td>
            </tr>
        </table>
    </div>
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="container-fluid" id="jsdatatable" style="margin-top: 10%">
                <div id="gridtablediv" class="customtextdatatable"></div>
            </div>
        </div>
        <div class="col-md-3"></div>
    </div>
    <asp:Label runat="server" ID="lbl_ermsg" ForeColor="Red" ClientIDMode="Static"></asp:Label>
    <div class="modal fade" id="examplepopup" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <p class="modal-title" id="P1">Reference Summary :&nbsp;<label id="flcid" style="color: #dc3545"></label></p>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="font-size: 25px;">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <h5>
                        <asp:Label ID="lbl_msg" runat="server" class="lbl-msg"></asp:Label></h5>
                    <div class="row clearfix">
                        <div class="col-md-12">
                            <div class="tab-content padding-0">
                                <div class="tab-pane animated fadeIn active">
                                    <div class="">
                                        <div class="col-sm-12">
                                            <div id="table" style="margin-left: 25px"></div>
                                            <asp:HiddenField runat="server" ID="pdfid" ClientIDMode="Static"></asp:HiddenField>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--added point of UAT--%>
    <div class="modal custom-modal fade show" id="MRFinformation" role="dialog" aria-modal="true" style="display: none; padding-left: 17px;">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Requisition Info</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card punch-status">
                                <div class="card-body">
                                    <div class="row" id="gridtabledivreq"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <style>
        .dt-buttons {
            display: none;
        }
    </style>
    <script>
        $(document).ready(function () { getedatatble(); });
        function getdata() {
            getedatatble();
        }

        function getedatatble() {
            $('#gridtablediv').empty();
            $('#gridtable').empty();
            $.ajax({
                type: "POST",
                url: "uidpendencyreport.aspx/bindata",
                dataType: "json",
                data: JSON.stringify({ typ: "23", frmdate: $('#txt_frdt').val(), todate: $('#txt_todt').val() }),
                beforesend: loadmyloading(),
                contentType: "application/json",
                success: function (data) {
                    $('#gridtablediv').html('');
                    if (data.d.length > 0) {
                        $('#gridtablediv').html('');
                        $('#lbl_ermsg')[0].innerText = "";
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
                                td += '<td>' + fault[i][col[j]] + '</td>';
                            }
                            td += '</tr>';
                        }
                        gridtable += '<tbody style="margin-left: -50px; float: left;"> ' + td + '</tbody>';
                        gridtable += ' </table>';
                        $('#gridtablediv').append(gridtable);
                        $('#gridtable').DataTable({
                            "scrollCollapse": true, dom: 'Bfrtip',
                            "paging": false,
                            //"sorting": false,
                            "scrollY": 230,
                            "scrollX": true,
                            //"scrollCollapse": true,
                            buttons: [
                               'excel',
                            ]
                        });

                    }
                    else {
                        $('#lbl_ermsg')[0].innerText = "No Record Found!!!";
                    }
                    removemyloading();
                },
                error: function (err) {
                    removemyloading();
                }

            });
        }

        function exportdatamethod() {
            debugger;
            $('.buttons-excel').trigger('click');
        }

    </script>

</asp:Content>

