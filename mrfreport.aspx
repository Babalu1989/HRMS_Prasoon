<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="mrfreport.aspx.cs" Inherits="mrfreport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .dataTables_filter {
            margin-top:-4%;
        }
    </style>
    <div class="col-lg-11">
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
                <td>&nbsp;&nbsp;<a ID="btn_srch" style="Width :100px;" class="btn btn-danger  btn-sm"  onclick="getdata();return false;">Show</a></td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lbl_nmmsg" runat="server" ForeColor="#dc3545"></asp:Label>
                </td>
                <td><span onclick="exportdatamethod()" class="pull-right"><i class="fa fa-file-excel-o " style="font-size: 30px; color: green;"></i></span></td>
            </tr>
        </table>
    </div>   
    
    <div class="container-fluid" id="jsdatatable">
        <%--form-scroll--%>
        <div id="gridtablediv" class="customtextdatatable"></div>
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
        //$(document).ready(function () { getedatatble(); });
        function getdata() {
            getedatatble();
        }

        function getedatatble() {
            $('#gridtablediv').empty();
            $('#gridtable').empty();
            $.ajax({
                type: "POST",
                url: "mrfreport.aspx/bindata",
                dataType: "json",
                data: JSON.stringify({ typ: "3", frmdate: $('#txt_frdt').val(), todate: $('#txt_todt').val() }),
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
                        if (col.length > 0) {
                            col.push('Download');
                            th += '<th>View</th>';
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
                                if (col[j] == "Download") {
                                    td += "<td><button type='button' class='btn btn-danger  btn-sm' onclick='Download(this);return false;'><i class='fa fa-download'></i> " + fault[i][col[0]] + "</button></td>";
                                } else {
                                    if (col[j] == "Requisition No") {
                                        td += '<td><a href="javascript:" onclick="backendcall(this);return false;">' + fault[i][col[j]] + '</a></td>';
                                    } else {
                                        td += '<td>' + fault[i][col[j]] + '</td>';
                                    }
                                }
                            }
                            td += '</tr>';
                        }
                        gridtable += '  <tbody> ' + td + '</tbody>';
                        gridtable += ' </table>';
                        $('#gridtablediv').append(gridtable);
                        $('#gridtable').DataTable({
                            "scrollCollapse": true, dom: 'Bfrtip',
                            "paging": false,
                            "sorting": false,
                            "scrollY": 230,
                            "scrollX": true,
                            "scrollCollapse": true,
                            buttons: [
                               'excel',
                            ],
                            //lengthMenu: [
                            // [5]
                            //],
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
        function Download(refno) {
            console.log(refno);
            $.ajax({

                url: 'mrfreport.aspx/download',

                type: "POST",

                dataType: "json",

                data: JSON.stringify({ refno: refno.innerText }),

                contentType: "application/json; charset=utf-8",

                success: function (data) {

                    //  $("#table").cleardraw();
                    $('#table').empty();
                    $("#table").show();
                    debugger;
                    if (data.d.length > 0) {
                        if (data.d[0]["file_id"] != null) {
                            $("#table").append("<thead><tr class='GridViewScrollHeader'><th scope='col'>Sr No.</th><th scope='col'>Documents</th><th scope='col'>File</th></tr></thead>");
                            for (var i = 0; i < data.d.length; i++) {
                                $("#table").append("<tbody><tr class='GridViewScrollItem'><td>" + data.d[i].SR_NO + "</td><td>" + data.d[i].TXT + "</td><td>  <i id='" + data.d[i].file_id + "' class='fa fa-file-pdf-o' aria-hidden='true' style='font-size: 20px; color:red; text-align: right;' onclick='pdfdownloadfunc(this)'></i></td></tr> </tbody>");

                            }
                        } else { $("#table").append("<tbody><tr class='GridViewScrollItem'><td><p style='color:red'>No Record Found !!!</p></td></tr></tbody>"); }
                    } else {
                        $("#table").append("<tbody><tr class='GridViewScrollItem'><td><p style='color:red'>No Record Found !!!</p></td></tr></tbody>");
                    }
                },
                Error: function () {
                }
            });
            //griddata
            $("#examplepopup").modal("show");
        }

        function pdfdownloadfunc(obj) {
            document.getElementById("pdfid").value = "";
            var pdfid = obj.id;
            // document.getElementById("pdfid").value = pdfid;
            //document.getElementById("<%=btn_pdf.ClientID %>").click();
            $.ajax({

                url: 'mrfreport.aspx/dnpdf',

                type: "POST",

                dataType: "json",

                data: JSON.stringify({ refno: pdfid }),

                contentType: "application/json; charset=utf-8",

                success: function (data) {

                    console.log(data);
                    var dataResult = $.parseJSON(data.d);
                    if (dataResult.length > 0 && dataResult[0].STATUS > 0) {
                        var sampleArr = base64ToArrayBuffer((dataResult[0].FileBase64));
                        saveByteArray(dataResult[0].FileName, sampleArr, dataResult[0].extension);
                    } else {
                        alert(dataResult[0].MESSAGE);
                    }
                }, error: function (err) {
                    console.log(err);
                    removemyloading();
                }

            });
        }
        function base64ToArrayBuffer(base64) {
            var binaryString = window.atob(base64);
            var binaryLen = binaryString.length;
            var bytes = new Uint8Array(binaryLen);
            for (var i = 0; i < binaryLen; i++) {
                var ascii = binaryString.charCodeAt(i);
                bytes[i] = ascii;
            }
            return bytes;
        }

        function saveByteArray(reportName, byte, extension) {
            var blob = new Blob([byte], { type: "application/" + extension });
            var link = document.createElement('a');
            link.href = window.URL.createObjectURL(blob);
            var fileName = reportName;
            link.download = fileName;
            link.click();
        };
    </script>
      <script>
          function backendcall(obj) {
              var mrfid = obj.innerText;
              $.ajax({
                  type: "POST",
                  url: "mrfreport.aspx/bindmoredata",
                  dataType: "json",
                  data: JSON.stringify({ typ: "20", id: mrfid }),
                  contentType: "application/json",
                  beforesend: loadmyloading(),
                  success: function (data) {
                      if (data.d.length > 0) {
                          $('#gridtabledivreq').html('');
                          debugger;
                          var gridtable = ' ';
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
                                      if (key == "Job Role" || key.includes("Intrim")) {
                                          th += '<div class="col-md-12"><div class="form-group"><label>' + key + '</label><textarea  rows="2" cols="20" class="form-control" disabled="disabled">' + fault[i][key] + '</textarea></div></div>';
                                      } else {
                                          th += '<div class="col-md-6"><div class="form-group"><label>' + key + '</label><input type="text"  class="form-control" disabled="disabled" value="' + fault[i][key] + '"/></div></div>';
                                      }
                                  }
                              }
                          }
                          gridtable += '  ' + th + '';
                          $('#gridtabledivreq').append(gridtable);

                      }
                      removemyloading();
                  }
              });
              $('#MRFinformation').modal('show');
          }
    </script>
    <asp:Button ID="btn_pdf" Text="Submit" runat="server" OnClick="pdfprint" hidden="hidden" />
</asp:Content>

