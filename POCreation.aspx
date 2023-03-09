<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="POCreation.aspx.cs" Inherits="POCreation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .dt-buttons {
            display: none;
        }
    </style>
    <span onclick="exportdatamethod()" class="pull-left"><i class="fa fa-file-excel-o " style="font-size: 30px; margin-left: 25px; color: green;"></i></span>

    <div class="container-fluid" id="jsdatatable">
        <div id="gridtablediv" style="" class="customtextdatatable"></div>
    </div>
    <!-- Edit terminate Employee Modal -->
    <div id="edit_employee" class="modal custom-modal fade" role="dialog">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Update</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">Ã—</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Status <span class="text-danger">*</span></label>
                                    <input class="form-control" type="text" value="" id="txtstatus" disabled="disabled" />
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Requisition No <span class="text-danger">*</span></label>
                                    <input class="form-control" type="text" value="" id="txtrequisition" disabled="disabled" />
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Department <span class="text-danger">*</span></label>
                                    <input class="form-control" type="text" value="" id="txtdept" disabled="disabled" />
                                </div>
                            </div>

                            <!--New added-->
                            <div class="col-sm-6">
                                <div class="row" style="margin-top: 2%;" id="div_buyer">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label>Assign To Buyer<span class="text-danger">*</span></label>
                                            <asp:DropDownList runat="server" class="form-control" ID="ddl_buyer" ClientIDMode="Static"></asp:DropDownList>

                                        </div>
                                    </div>
                                    <div class="col-sm-6" id="div_noofpo">
                                        <div class="form-group">
                                            <label>No of PO<span class="text-danger">*</span></label>
                                            <input type="number" class="form-control" id="txt_noofpo" min="1" oninput="this.value=Math.abs(this.value)" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div id="addmoredocumentdiv" class="col-sm-6"></div>



                            <!--New added-->
                            <div class="col-lg-12" id="div_po">
                                <fieldset class="scheduler-border">
                                    <legend class="scheduler-border">PO Details:</legend>
                                    <div class="row" id="divpoadd">
                                    </div>
                                </fieldset>
                            </div>

                            <div class="col-sm-6" id="div_wo">
                                <div class="form-group">
                                    <label>Work Order No<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="txt_workorderno" />
                                </div>
                            </div>
                            <div class="col-sm-6" id="div_from">
                                <div class="form-group">
                                    <label>Period From<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control datetimepicker" id="txt_from" readonly="readonly" style="background-color: white !important" />
                                </div>
                            </div>
                            <div class="col-sm-6" id="div_To">
                                <div class="form-group">
                                    <label>Period To<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control datetimepicker" id="txt_to" readonly="readonly" style="background-color: white !important" />
                                </div>
                            </div>
                        </div>
                        <div class="submit-section">
                            <div class="row pull-right" style="margin-top: -30px;" id="addmorebtndiv">
                                <div class="file-field">
                                    <div class="add-more">
                                        <a class="header-primary" href="javascript:void(0);" onclick="addmoredocument();"><i class="fa fa-plus-circle"></i>Add More</a>
                                    </div>
                                </div>
                            </div>

                            <a class="btn btn-primary submit-btn" onclick="function_edit_deactive();">Submit</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Edit terminate Employee Modal -->
        <div class="modal fade" id="alertMessage" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="H1">Message</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <h5>
                            <asp:Label ID="lbl_msg" runat="server" class="lbl-msg"></asp:Label></h5>
                    </div>
                </div>
            </div>
        </div>
    </div>
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
                        <asp:Label ID="Label1" runat="server" class="lbl-msg"></asp:Label></h5>
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
    <script>

        $(document).ready(function () { getedatatble(); });
        function getedatatble() {
            $.ajax({
                type: "POST",
                url: "POCreation.aspx/bindata",
                dataType: "json",
                data: JSON.stringify({ typ: "21" }),
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
                                if (j == 1) {
                                    if (fault[i][col[j]] == "Working") {
                                        td += '<td><span class="badge badge-danger-border">' + fault[i][col[j]] + '</span></td>';
                                    } else {
                                        td += '<td><span class="badge badge-success-border">' + fault[i][col[j]] + '</span></td>';
                                    }

                                }
                                else if (j == col.length - 4) {
                                    if ((fault[i][col[j]] != "" || fault[i][col[j]] != null)) {
                                        td += '<td><i class="fa fa-file-pdf-o text-danger" aria-hidden="true" style="font-size: 30px;" id="' + fault[i][col[j]] + '" onclick="pdfdownloadfunc(this)"></i></td>';
                                    } else {
                                        td += '<td><i class="fa fa-ban text-danger" aria-hidden="true" style="font-size: 30px;" id="' + fault[i][col[j]] + '"></i></td>';
                                    }

                                }

                                else {
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
                            fixedColumns: {
                                leftColumns: 1,
                                rightColumns: 1
                            },
                            columnDefs: [
                            {
                                "visible": true, "targets": groupColumn,
                                render: function (data, type, row, meta) {
                                    data = '<a href="javascript:" onclick="backendcall(this)">' + encodeURIComponent(data) + '</a>';
                                    return data;
                                }
                            }],
                            buttons: [{
                                //''   
                                extend: 'excel',
                                filename: 'PO Creation list'
                            }],
                        });
                    }
                }
            });
        }

        var cnt;
        function edit_employee(obj) {
            var valterminate = obj.split(',');
            $('#edit_employee').modal('show');
            $('#txtstatus').val(valterminate[1]);
            $('#txtrequisition').val(valterminate[0]);
            $('#txtdept').val(valterminate[2]);
            if (valterminate[1] == "Signed Copy Uploaded" || valterminate[1] == "Moved to Head Contract") {
                $('#div_buyer').show();
                $('#div_noofpo').show();
                $('#addmoredocumentdiv').show();
                $('#div_po').hide();
                $('#div_wo').hide();
                $('#div_from').hide();
                $('#div_To').hide();
            }

            if (valterminate[3] != "NA") {
                $('#ddl_buyer').val(valterminate[3]);
                $('#ddl_buyer').prop('disabled', true);
                $('#txt_noofpo').val(valterminate[4]);
                $('#txt_noofpo').prop('disabled', true);
                $('#addmoredocumentdiv').hide();
                $('#addmorebtndiv').hide();
                cnt = parseInt(valterminate[4]);
                console.log(cnt);
                $('#divpoadd').empty();
                var poadd = '';

                for (pocnt = 0; pocnt < cnt; pocnt++) {
                    poadd += '<div class="col-sm-4">';
                    poadd += '<div class="form-group">';
                    poadd += '<label>PO No ' + (pocnt + 1) + '<span class="text-danger">*</span></label>';
                    poadd += '<input type="number" class="form-control" id="txt_pono_' + pocnt + '"   oninput="this.value=Math.abs(this.value)"/>';
                    poadd += '</div>';
                    poadd += '</div>';
                }
                $('#divpoadd').append(poadd);

            }
        }

        function function_edit_deactive() {
            var buyerpo = [];
            var ponumbers = '';
            var isactive = true;

            <% if (Session["EMP_TYPE"].ToString() == "HC")%> {

                    if ($('#txt_noofpo').val() != "") {
                        buyerpo.push({ buyer: $('#ddl_buyer').val(), noofpo: $('#txt_noofpo').val() })
                    } else {
                        isactive = false;
                    }

                    if (z > 0) {
                        for (ist = 0; ist < z; ist++) {
                            if ($('#txt_noofpo_' + ist).val() != "") {
                                buyerpo.push({ buyer: $('#ddl_buyer_' + ist).val(), noofpo: $('#txt_noofpo_' + ist).val() })
                            }
                            else {
                                isactive = false;
                            }
                        }
                    }
                }



                <% if (Session["EMP_TYPE"].ToString() == "Buyer")%> {
                    if (cnt > 0) {
                        for (pocnt = 0; pocnt < cnt; pocnt++) {
                            if ($("#txt_pono_" + pocnt).val() == "" || $('#txt_workorderno').val() == "" || $('#txt_from').val() == "" || $('#txt_to').val() == "") {
                                popups("All PO Number should be filled!!!");
                                isactive = false;

                            } else {
                                ponumbers += $("#txt_pono_" + pocnt).val() + ',';
                            }
                        }
                    }
                }


                if (isactive == true) {
                    // if ($('#ddl_buyer').val() == "NA" || $('#txt_noofpo').val() == "" || $('#txt_pono').val() == "" || $('#txt_workorderno').val() == "") { left("Please fill all the mandatory fileds"); } else {
                    $.ajax({
                        type: "POST",
                        url: "POCreation.aspx/update",
                        dataType: "json",
                        data: JSON.stringify({ typ: "4", req: $('#txtrequisition').val(), buyerpo: buyerpo, pono: ponumbers, wono: $('#txt_workorderno').val(), fromdt: $('#txt_from').val(), todt: $('#txt_to').val() }),
                        contentType: "application/json",
                        success: function (data) {
                            if (data.d.length > 0) {
                                var response = eval(data.d);
                                console.log("response", response);
                                if (response.length > 0) {
                                    left(response[0].TXT);
                                    $('#edit_employee').modal('hide');

                                }
                            }
                        }
                    });
                } else {
                    left("Please fill all the mandatory fileds");
                }
                // }
            }
            $('#txt_validupto').datepicker({ minDate: 0 });
            function exportdatamethod() {
                debugger;
                $('.buttons-excel').trigger('click');
            }

            var z = 0;
            function addmoredocument() {
                debugger;
                var rowadd = '';
                var txt_noofpo = 'txt_noofpo_' + z;
                var ddl_buyer = 'ddl_buyer_' + z;
                var tableSelect = "<select name='ctl00$ContentPlaceHolder1$" + ddl_buyer + "' id='" + ddl_buyer + "' class='form-control'>";
                $.each($('#ddl_buyer')[0].options, function (key, data) {
                    console.log(data);
                    tableSelect += '<option value="' + data.value + '">' + data.text + '</option>';
                });
                tableSelect += "</select>";
                rowadd += " <div class='row'>";
                rowadd += " <div class='col-sm-6'><div class='form-group'><label>Assign To Buyer<span class='text-danger'>*</span></label>" + tableSelect + "</div></div>";
                rowadd += " <div class='col-sm-6'><div class='form-group'>";
                rowadd += "  <label>No of PO<span class='text-danger'>*</span></label>";
                rowadd += " <input type='number' min='1' oninput='this.value=Math.abs(this.value)' class='form-control' name='ctl00$ContentPlaceHolder1$txt_noofpo_" + z + "' id='" + txt_noofpo + "'>";
                rowadd += " </div></div>";
                rowadd += " </div>";
                $('#addmoredocumentdiv').append(rowadd);
                z = z + 1;

            }

            function popups(msg) {
                document.getElementById("<%=lbl_msg.ClientID %>").innerHTML = msg;
                $("#alertMessage").modal("show");
            }
    </script>
    <script>
        function pdfdownloadfunc(requestNo) {
            console.log(requestNo.id);
            $.ajax({

                url: 'POCreation.aspx/createpdf',

                type: "POST",

                dataType: "json",

                data: JSON.stringify({ refno: requestNo.id }),

                contentType: "application/json; charset=utf-8",

                success: function (data) {

                    console.log(data);
                    // window.location.href = data.d;
                    var dataResult = $.parseJSON(data.d);
                    if (dataResult.length > 0 && dataResult[0].STATUS > 0) {
                        var sampleArr = base64ToArrayBuffer((dataResult[0].FileBase64));
                        saveByteArray(dataResult[0].FileName, sampleArr, dataResult[0].extension);
                    } else {
                        alert(dataResult[0].MESSAGE);
                    }
                    // removemyloading();
                }, error: function (err) {
                    console.log(err);
                    removemyloading();
                }

            });
        }

        //function base64ToArrayBuffer(base64) {
        //    var binaryString = window.atob(base64);
        //    var binaryLen = binaryString.length;
        //    var bytes = new Uint8Array(binaryLen);
        //    for (var i = 0; i < binaryLen; i++) {
        //        var ascii = binaryString.charCodeAt(i);
        //        bytes[i] = ascii;
        //    }
        //    return bytes;
        //}

        //function saveByteArray(reportName, byte, extension) {
        //    var blob = new Blob([byte], { type: "application/pdf" });
        //    var link = document.createElement('a');
        //    link.href = window.URL.createObjectURL(blob);
        //    var fileName = reportName;
        //    link.download = fileName;
        //    link.click();
        //};


        //===========
        function backendcall(refno) {
            console.log(refno);
            $.ajax({

                url: 'POCreation.aspx/download',

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


        //===========
    </script>

</asp:Content>

