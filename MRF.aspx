<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="MRF.aspx.cs" Inherits="MRF" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="assets/js/underscore.js"></script>
    <h4 class="text-muted text-center">Online Manpower Requistion Form</h4>
    <div class="" style="min-height: 750px;">
        <!-- Add MRF Modal -->
        <div class="row">
            <div class="col-sm-12">
                <div class="card-box">
                    <%--form-scroll--%>
                    <h3 class="card-title">
                        <%--  Requisition no:<asp:Label runat="server" ClientIDMode="Static" Style="color: #fc6075" ID="txt_req_no">XXXXXXXX</asp:Label>--%>
                        <a href="javascript:void(0);" class="delete-icon"></a></h3>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>MRF Type<span class="text-danger">*</span></label>
                                <select class="form-control" required="required" data-error-msg="Mode of MRF Required" id="ddl_mrfrtype">
                                    <option>--Select--</option>
                                    <option value="MRF">Manpower Requistion</option>
                                    <option value="INDENT">Indent Application for Renewal</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-form-label">Position Requirement <span class="text-danger">*</span></label>
                                <select class="form-control" data-error-msg="Mode of Contract Required" id="addmodalcontractmode">
                                    <option>--Select--</option>
                                    <option>One Year</option>
                                    <option>Short Term</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Circle<span class="text-danger">*</span></label>
                                <asp:DropDownList runat="server" ID="ddl_circle" class="form-control" ClientIDMode="Static" onchange="getdiv(this);" data-error-msg="Circle Required"></asp:DropDownList>
                            </div>
                        </div>
                        <script>
                            $("#addmodalcontractmode").change(function () {
                                if ($("#addmodalcontractmode").val() == "Short Term") {
                                    $("#perioddiv").show();
                                } else {
                                    $("#perioddiv").hide();
                                    $('#ddl_period').val(".");
                                }
                            });
                        </script>
                        <div class="col-sm-6">
                            <div class="form-group" id="perioddiv" style="display: none">
                                <label class="col-form-label">Period of Requirement: <span class="text-danger">*</span></label>
                                <select class="form-control" id="ddl_period">
                                    <option value=".">--Select--</option>
                                    <option value="1">1 month</option>
                                    <option value="2">2 month</option>
                                    <option value="3">3 month</option>
                                    <option value="4">4 month</option>
                                    <option value="5">5 month</option>
                                    <option value="6">6 month</option>
                                    <option value="7">7 month</option>
                                    <option value="8">8 month</option>
                                    <option value="9">9 month</option>
                                    <option value="10">10 month</option>
                                    <option value="11">11 month</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Division<span class="text-danger">*</span></label>
                                <asp:DropDownList runat="server" ID="ddl_divaddnew" class="form-control" ClientIDMode="Static" onchange="getsubdiv(this);" data-error-msg="Division Required"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-form-label">Manpower Requirement : <span class="text-danger">*</span></label>
                                <select class="form-control" data-error-msg="Gender Required" id="Selectjointype">
                                    <option>--Select--</option>
                                    <option>New</option>
                                    <option>Replacement</option>
                                    <option>Extension</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Sub-Division<span class="text-danger">*</span></label>
                                <asp:DropDownList runat="server" ID="ddl_subdivaddnew" class="form-control" ClientIDMode="Static" data-error-msg="Sub-Division Required">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <script>
                            $("#Selectjointype").change(function () {
                                if ($("#Selectjointype").val() == "Replacement") {
                                    $("#replacementdiv").show();
                                    $('#txt_empid').val("");
                                    $('#txt_empnm').val(""); $('#ddl_venaddnew').val("");
                                    $('#txt_empid').prop('disabled', false);
                                    $('#txt_noposition').val("1");//added due to 17 march 2021 final UAT point
                                    $('#txt_noposition').prop('disabled', true);//added due to 17 march 2021 final UAT point
                                }
                                else if ($("#Selectjointype").val() == "Extension") {//added due to 17 march 2021 final UAT point
                                    $("#replacementdiv").hide();
                                    $('#txt_empid').val("");
                                    $('#txt_empnm').val(""); $('#ddl_venaddnew').val("");
                                    $('#txt_empid').prop('disabled', false);
                                }
                                else {
                                    $("#replacementdiv").hide();
                                    $('#txt_empid').prop('disabled', true);
                                }
                            });
                        </script>

                        <div class="col-sm-6">
                            <div class="form-group" id="replacementdiv" style="display: none">
                                <label class="col-form-label">Replacement Against: <span class="text-danger">*</span></label>
                                <select class="form-control" id="replacementid">
                                    <option value="NA">--Select--</option>
                                    <option value="HRMS">HRMS</option>
                                    <option value="SLA">SLA</option>
                                    <option value="CTC">CTC</option>
                                    <option value="GPA">GPA</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Department <span class="text-danger">*</span></label>
                                <asp:DropDownList runat="server" ID="ddl_deptaddnew" class="form-control" data-error-msg="Department Required" ClientIDMode="Static"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-form-label">Employee ID (UID) <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" data-error-msg="Emp Id. Required" id="txt_empid" disabled="disabled" />
                            </div>
                        </div>
                         <div class="col-md-6">
                            <div class="form-group">
                                <label>Function Code <span class="text-danger">*</span></label>
                                <asp:DropDownList runat="server" ID="ddl_functioncode" class="form-control" data-error-msg="Function Code Required" ClientIDMode="Static"></asp:DropDownList>
                            </div>
                        </div>                       
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-form-label">Employee Name <span class="text-danger">*</span></label>
                                <input class="form-control" type="text" data-error-msg="Name Required" id="txt_empnm" disabled="disabled" />
                            </div>
                        </div>
                         <div class="col-md-6">
                            <div class="form-group">
                                <label>Cost Center <span class="text-danger">*</span></label>
                                <asp:DropDownList runat="server" ID="ddl_costcenter" class="form-control" data-error-msg="Cost Center Required" ClientIDMode="Static"></asp:DropDownList>
                            </div>
                        </div>                        
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-form-label">Place of Posting <span class="text-danger">*</span></label>
                                <input class="form-control" type="text" id="placeofposting" disabled="disabled" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>GL <span class="text-danger">*</span></label>
                                <asp:DropDownList runat="server" ID="ddl_gl" class="form-control" data-error-msg="GL Required" ClientIDMode="Static"></asp:DropDownList>
                            </div>
                        </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-form-label">Vendor Name</label>
                                <asp:DropDownList runat="server" ID="ddl_venaddnew" class="form-control" data-error-msg="Vendor Required" ClientIDMode="Static" disabled="disabled"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-form-label">Justification <span class="text-danger">*</span></label>
                                <select class="form-control" data-error-msg="Justification Required" id="ddl_justification">
                                    <option>--Select--</option>
                                    <option>Shortage of Manpower</option>
                                    <option>New Job Profile</option>
                                    <option>New Project Approved by Management</option>
                                    <option>New Requirement-Additional Requirement</option>
                                    <option>Extension of Project Requirement</option>
                                </select>
                            </div>
                        </div>
                       
                        <div class="col-sm-6">
                            <div class="form-group" id="Div1">
                                <label class="col-form-label">Required Position: <span class="text-danger">*</span></label>
                                <asp:DropDownList runat="server" ID="ddl_reqpostion" ClientIDMode="Static" class="form-control" onchange="getposition(this)"></asp:DropDownList>
                            </div>
                        </div>

                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-form-label">Required No of Positions <span class="text-danger">*</span></label>
                                <input class="form-control" type="number" id="txt_noposition" min="0" oninput="this.value=Math.abs(this.value)" />
                            </div>
                        </div>

                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-form-label">Category of Wages <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="txt_categorywages" disabled="disabled" />
                            </div>
                        </div>

                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-form-label">Qualification <span class="text-danger">*</span></label>
                                <input class="form-control" type="text" id="txt_qualification" disabled="disabled" />
                            </div>
                        </div>

                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-form-label">Budget(SAP) <span class="text-danger">*</span></label>
                                <input class="form-control" type="text" id="txt_budget" style="color:red" disabled="disabled" />
                            </div>
                        </div>

                        <div class="col-sm-6" style="display:none">
                            <div class="form-group">
                                <label class="col-form-label">Budget Availability <span class="text-danger">*</span></label>
                                <select class="form-control" required="required" data-error-msg="Budget Availability Required" id="ddl_budgetavailibity">
                                    <option>--Select--</option>
                                    <option selected="selected">YES</option>
                                    <option>NO</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-12 form-scroll">
                            <fieldset class="scheduler-border">
                                <legend class="scheduler-border">Job Role/JD:</legend>
                                <div class="form-group form-scroll">
                                    <label class="col-form-label"></label>
                                    <asp:TextBox runat="server" TextMode="MultiLine" ID="txt_jobroleid" class="form-control" ClientIDMode="Static" Style="height: 100px;"></asp:TextBox>
                                </div>
                            </fieldset>
                        </div>
                        <div class="col-lg-12">
                            <fieldset class="scheduler-border">
                                <legend class="scheduler-border">Approval:</legend>
                                <div class="form-group">
                                    <label class="col-form-label">Requisitioner :</label>
                                    <asp:TextBox ID="ddl_Requisitioner" class="form-control" ReadOnly="true" runat="server" ClientIDMode="static" />
                                </div>
                                <div class="row">
                                    <div class="col-sm-6 form-group">
                                        <label class="col-form-label">Reviewer :<span class="text-danger">*</span></label>
                                        <asp:DropDownList runat="server" class="form-control" ID="ddl_Reviewer" ClientIDMode="Static" />
                                    </div>
                                    <div class="col-sm-6 form-group">
                                        <label class="col-form-label">Update Reviewer <span style="color: #fc6075">(select in-case reviewer name is wrong)</span> :</label>
                                        <asp:DropDownList runat="server" class="form-control" ID="ddl_Reviewerupdate" ClientIDMode="Static" />
                                    </div>
                                </div>
                                <div class="form-group" style="display: none">
                                    <label class="col-form-label">Nominate Interview Panel Member :</label>
                                    <input class="form-control" type="text" id="txt_interviewpanel" disabled="disabled" />
                                </div>
                                <div class="row">
                                    <div class="form-group col-sm-6">
                                        <label class="col-form-label">Approver :</label>
                                        <input class="form-control" type="text" id="txt_approver" disabled="disabled" />
                                    </div>
                                    <div class="form-group col-sm-6">
                                        <label class="col-form-label">Update Approver <span style="color: #fc6075">(select in-case approver name is wrong)</span>  :</label>
                                        <asp:DropDownList runat="server" class="form-control" ID="ddl_approverupdate" ClientIDMode="Static" />
                                    </div>
                                </div>
                            </fieldset>
                        </div>
                        <div class="col-sm-9">
                            <input type="file" class="btn add-btn" name="fileDocument" id="fileDocument" accept="image/*,application/pdf" style="display: none;" />
                        </div>
                        <div class="col-sm-3 pull-right">
                            <a class="btn btn-primary submit-btn pull-right" style="float: right" onclick="funcaddnewdatasave();">Submit</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <hr />
        <!-- /Add MRF Modal -->
        <div class="row" style="margin-left: 5px; display:none;">
            <asp:FileUpload ID="FileUpload" runat="server" CssClass="btn add-btn" Style="height: 36px;" />
            <asp:Button ID="btnUpload" runat="server" OnClick="btnUpload_Click" Text="Upload" CssClass="float-left" hidden="hidden" CausesValidation="False" />
            <div class="float-left" style="margin-left: 5px;">
                <asp:Label runat="server" ID="lbl_msg" ForeColor="Red"></asp:Label>
                <a id="A1" href="javascript:void(0);" class="btn add-btn" onclick="btnfire();return false;">Bulk Request Upload</a>
                <script> function btnfire() {
     document.getElementById("<%=btnUpload.ClientID %>").click();
 } function btnfiledwn() {
     document.getElementById("<%=filedownload.ClientID %>").click();
 }
                </script>
            </div>
            <asp:Button runat="server" ID="filedownload" OnClick="filedownload_Click" hidden="hidden" CausesValidation="False" />
            <div style="float: right; color: green; margin-left: 77%; margin-top: -2%;">Sample MRF File:</div>
            <i class="fa fa-file-excel-o float-right" style="font-size: 30px; margin-left: 90%; margin-top: -3%; color: green;" data-toggle="tooltip" title="Sample MRF File" onclick="btnfiledwn();return false;"></i>
        </div>
        <div class="row">
            <div class="col-lg-12 ">
                <div class="table-responsive">
                    <asp:GridView runat="server" ID="gv_uploaddata" ClientIDMode="Static" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="false" DataKeyNames="EmpId" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnRowDataBound="gv_uploaddata_RowDataBound" OnRowDeleting="GridView1_RowDeleting">
                        <Columns>
                            <asp:CommandField ShowEditButton="true" />
                            <asp:BoundField DataField="sno" HeaderText="S No" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                            <asp:BoundField DataField="MRFTYPE" HeaderText="MRF TYPE" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                            <asp:BoundField DataField="CIRCLE" HeaderText="CIRCLE" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                            <asp:BoundField DataField="DIVISION" HeaderText="DIVISION" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                            <asp:BoundField DataField="SUBDIVISION" HeaderText="SUBDIVISION" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                            <asp:BoundField DataField="POSITIONTERM" HeaderText="POSITION REQUIREMENT" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                            <asp:BoundField DataField="PERIOD" HeaderText="PERIOD OF REQUIREMENT" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                            <asp:BoundField DataField="REQUIREMENT" HeaderText="MANPOWER REQUIREMENT" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                            <asp:BoundField DataField="REPLACEMENTAGAINST" HeaderText="REPLACEMENT AGAINST" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                            <asp:BoundField DataField="DEPARTMENT" HeaderText="DEPARTMENT" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                            <asp:BoundField DataField="COSTCENTER" HeaderText="COST CENTER" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                            <asp:BoundField DataField="PLACEOFPOSTING" HeaderText="PLACE OF POSTING" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                            <asp:BoundField DataField="REQUIREDPOSTION" HeaderText="REQUIRED POSTION" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                            <asp:BoundField DataField="NOOFPOSITION" HeaderText="REQUIRED NO OF POSITION" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                            <asp:BoundField DataField="EMPID" HeaderText="EMPID" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                            <asp:BoundField DataField="EMPNAME" HeaderText="EMPNAME" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                            <asp:BoundField DataField="QUAL" HeaderText="QUAL" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                            <asp:BoundField DataField="CATEGORYOFWAGES" HeaderText="CATEGORY OF WAGES" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                            <asp:BoundField DataField="VENDOR" HeaderText="VENDOR" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                            <asp:BoundField DataField="REQBUDGET" HeaderText="REQUIRED BUDGET" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                            <asp:BoundField DataField="JUSTIFICATION" HeaderText="JUSTIFICATION" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                            <asp:BoundField DataField="BUDGETAVAILABILITY" HeaderText="BUDGET AVAILABILITY" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                            <asp:CommandField ShowDeleteButton="true" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-4"></div>
            <div class="col-lg-4">
                <asp:Button runat="server" ID="submit" class="btn add-btn" OnClick="submit_Click" Text="Submit" Style="float: left;" Visible="false" />
                <asp:TextBox runat="server" ID="txt_errorcnt" Visible="false"></asp:TextBox>
            </div>
            <div class="col-lg-4"></div>
        </div>
    </div>
    <script>
        var Saverecord = [];
        function funcaddnewdatasave() {
            if ($('#addmodalcontractmode').val() == "--Select--" || $('#ddl_circle').val() == "0" || $('#ddl_divaddnew').val() == "null" || $('#ddl_divaddnew').val() == "0" || $('#Selectjointype').val() == "--Select--" || $('#ddl_subdivaddnew').val() == "null" || $('#ddl_subdivaddnew').val() == "0" || $('#ddl_deptaddnew').val() == "0" || $('#ddl_functioncode').val()=="0" || $('#ddl_costcenter').val() == "null" || $('#ddl_costcenter').val() == "0" || $('#ddl_reqpostion').val() == "" || $('#ddl_justification').val() == "--Select--" || $('#txt_noposition').val() == "" || ($("#addmodalcontractmode").val() == "Short Term" && $('#ddl_period').val() == "NA")) {
                left("Please fill all the mandatory fileds");
            }
            else {
                if ($('#ddl_budgetavailibity').val() == "--Select--") {
                    left("Please Select Budget Availability");

                }
                else if ($('#ddl_budgetavailibity').val() == "NO") { left("Manpower Request can't be process due to no Budget Availability"); }
                else
                {
                    if ($('#ddl_mrfrtype').val() == "MRF") {
                        var rev = $('#ddl_Reviewerupdate').val() != "0" ? $('#ddl_Reviewerupdate').val() : $('#ddl_Reviewer').val() == "0" ? left("Please Select Reviewer") : $('#ddl_Reviewer').val();
                        if (rev == "0" || rev == null || rev == undefined) { left("Please Select Reviewer") } else {
                            Saverecord.push({
                                requisitionno: $('#txt_req_no').val(), mrftype: $('#ddl_mrfrtype').val(), positionrequirement: $('#addmodalcontractmode').val(), periodrequirement: $('#ddl_period').val(), circle: $('#ddl_circle').val(), division: $('#ddl_divaddnew').val(), manpowerrequirement: $('#Selectjointype').val(),
                                replacementagainst: $('#replacementid').val(), sudivision: $('#ddl_subdivaddnew').val(), department: $('#ddl_deptaddnew').val(), employeeid: $('#txt_empid').val(), costcenter: $('#ddl_costcenter').val(), employeename: $('#txt_empnm').val(), placeofposting: $('#placeofposting').val(), vendor: $('#ddl_venaddnew').val(),
                                requiredposition: $('#ddl_reqpostion').val(), justification: $('#ddl_justification').val(), requirednoofposition: $('#txt_noposition').val(), categoryofwages: $('#txt_categorywages').val(), qualification: $('#txt_qualification').val(), requiredbudget: $('#txt_budget').val(), budgetavailabilty: $('#ddl_budgetavailibity').val(),
                                jobroleid: $('#txt_jobroleid').val(), requistioner: $('#ddl_Requisitioner').val(), reviewer: rev, interviewpanelmember: $('#txt_interviewpanel').val(), approver: ($('#ddl_approverupdate').val() != "0") ? $('#ddl_approverupdate').val() : approverempid[0], insrrtby: '', insrtusing: 'ENTRYFORM',
                                reviwerinsrtdt: $('#ddl_functioncode').val(), reviwerinsrtby: '', reviwerapprmrk: '', approverinsrtdt: '', approverinsrtby: '', approverapprmrk: '', auditinsrtdt: '', auditinsrtby: '', auditrmrk: '', fnainsrtdt: '', fnainsrtby: '', fnarmrk: '', hrinsrtdt: '', hrinsrtby: '', hrrmrk: '', budgetinsrtdt: '', budgetinsrtby: '', budgetrmrk: '', chairmaninsrtdt: '', chairmaninsrtby: '', chairmanrmrk: '' //added $('#ddl_functioncode').val() dated 22 feb 2021 for uid purpose
                            })
                            if (parseInt(wageamount) * parseInt($('#txt_noposition').val()) < parseInt(sapavailablebudget)) {
                                $.ajax({
                                    type: "POST",
                                    url: "MRF.aspx/MRFformsave",
                                    dataType: "json",
                                    data: JSON.stringify({ typ: "1", Saverecord: Saverecord }),
                                    contentType: "application/json",
                                    success: function (data) {
                                        if (data.d.length > 0) {
                                            var response = eval(data.d);
                                            console.log("response", response);
                                            if (response.length > 0) {
                                                //alert(response[0].TXT);
                                                left(response[0].TXT);
                                                removemyloading();
                                            }
                                            removemyloading();
                                        }
                                    }
                                });
                            } else {
                                left("Manpower Request cannot be processed due to low Budget available in SAP,"+"\r\nAvailable Budget-" + parseInt(sapavailablebudget) + " ,\r\nRequired Budget-" + (parseInt(wageamount) * parseInt($('#txt_noposition').val())) + " for " + $('#txt_noposition').val() + " manpower");
                            }
                        }
                    }
                    if ($('#ddl_mrfrtype').val() == "INDENT") {
                        var fileUpload = $("#fileDocument").get(0);
                        var files = fileUpload.files;
                        if (files.length == "0") {
                            left('Indent Document Required!!!');
                        }
                        else {
                            // Create FormData object  
                            var fileData = new FormData();

                            // Looping over all files and add it to FormData object  
                            for (var i = 0; i < files.length; i++) {
                                fileData.append(files[i].name, files[i]);
                            }
                            var requisitionno = $('#txt_req_no').val();
                            var mrftype = $('#ddl_mrfrtype').val();
                            var positionrequirement = $('#addmodalcontractmode').val();
                            var periodrequirement = $('#ddl_period').val();
                            var circle = $('#ddl_circle').val();
                            var division = $('#ddl_divaddnew').val();
                            var manpowerrequirement = $('#Selectjointype').val();
                            var replacementagainst = $('#replacementid').val();
                            var sudivision = $('#ddl_subdivaddnew').val();
                            var department = $('#ddl_deptaddnew').val();
                            var employeeid = $('#txt_empid').val();
                            var costcenter = $('#ddl_costcenter').val();
                            var employeename = $('#txt_empnm').val();
                            var placeofposting = $('#placeofposting').val();
                            var vendor = $('#ddl_venaddnew').val();
                            var requiredposition = $('#ddl_reqpostion').val();
                            var justification = $('#ddl_justification').val();
                            var requirednoofposition = $('#txt_noposition').val();
                            var categoryofwages = $('#txt_categorywages').val();
                            var qualification = $('#txt_qualification').val();
                            var requiredbudget = $('#txt_budget').val();
                            var budgetavailabilty = $('#ddl_budgetavailibity').val();
                            var jobroleid = $('#txt_jobroleid').val();
                            var requistioner = $('#ddl_Requisitioner').val();
                            var reviewer = $('#ddl_Reviewerupdate').val() != "0" ? $('#ddl_Reviewerupdate').val() : $('#ddl_Reviewer').val() == "0" ? left("Please Select Reviewer") : $('#ddl_Reviewer').val();
                            if (reviewer == "0" || reviewer == null || reviewer == undefined) { left("Please Select Reviewer") } else {
                                var interviewpanelmember = $('#txt_interviewpanel').val();
                                var approver = ($('#ddl_approverupdate').val() != "0") ? $('#ddl_approverupdate').val() : approverempid;
                                var insrtusing = 'ENTRYFORM';
                                if ($('#addmodalcontractmode').val() == "--Select--" || $('#ddl_circle').val() == "0" || $('#ddl_divaddnew').val() == "null" || $('#ddl_divaddnew').val() == "0" || $('#Selectjointype').val() == "--Select--" || $('#ddl_subdivaddnew').val() == "null" || $('#ddl_subdivaddnew').val() == "0" || $('#ddl_deptaddnew').val() == "0" || $('#ddl_costcenter').val() == "null" || $('#ddl_costcenter').val() == "0" || $('#ddl_reqpostion').val() == "" || $('#ddl_justification').val() == "" || $('#txt_noposition').val() == "" || $('#ddl_functioncode').val()=="0")
                                { left("Please fill all the mandatory fileds"); } else {

                                    // Adding one more key to FormData object  
                                    fileData.append('requisitionno', requisitionno);
                                    fileData.append('mrftype', mrftype);
                                    fileData.append('positionrequirement', positionrequirement);
                                    fileData.append('periodrequirement', periodrequirement);
                                    fileData.append('circle', circle);
                                    fileData.append('division', division);
                                    fileData.append('manpowerrequirement', manpowerrequirement);
                                    fileData.append('replacementagainst', replacementagainst);
                                    fileData.append('sudivision', sudivision);
                                    fileData.append('department', department);
                                    fileData.append('employeeid', employeeid);
                                    fileData.append('costcenter', costcenter);
                                    fileData.append('employeename', employeename);
                                    fileData.append('placeofposting', placeofposting);
                                    fileData.append('vendor', vendor);
                                    fileData.append('requiredposition', requiredposition);
                                    fileData.append('justification', justification);
                                    fileData.append('requirednoofposition', requirednoofposition);
                                    fileData.append('categoryofwages', categoryofwages);
                                    fileData.append('qualification', qualification);
                                    fileData.append('requiredbudget', requiredbudget);
                                    fileData.append('budgetavailabilty', budgetavailabilty);
                                    fileData.append('jobroleid', jobroleid);
                                    fileData.append('requistioner', requistioner);
                                    fileData.append('reviewer', reviewer);
                                    fileData.append('interviewpanelmember', interviewpanelmember);
                                    fileData.append('approver', approver);
                                    fileData.append('insrtusing', insrtusing);
                                    fileData.append('docType', '19');
                                    fileData.append('reviwerinsrtdt', $('#ddl_functioncode').val());
                                    if (parseInt(wageamount) * parseInt($('#txt_noposition').val()) < parseInt(sapavailablebudget))
                                    {
                                    $.ajax({
                                        url: 'IndentNote.ashx',
                                        type: "POST",
                                        contentType: false, // Not to set any content header  
                                        processData: false, // Not to process data  
                                        data: fileData,
                                        beforesend: loadmyloading(),
                                        success: function (result) {
                                            debugger;
                                            left(result.name);
                                            removemyloading();
                                        },
                                        error: function (err) {
                                            alert(err.statusText);
                                            removemyloading();
                                        }
                                    });
                                    } else {
                                        left("Manpower Request cannot be processed due to low Budget available in SAP," + "\r\nAvailable Budget-" + parseInt(sapavailablebudget) + " ,\r\nRequired Budget-" + (parseInt(wageamount) * parseInt($('#txt_noposition').val())) + " for " + $('#txt_noposition').val() + " manpower");
                                    }

                                }
                            }
                        }
                    }
                }
            }
        }

        var ddl_subdivaddnewvar;
        function getsubdiv(obj) {
            $('#ddl_subdivaddnew').empty();
            var division = obj.value;
            $.ajax({
                type: "POST",
                url: "mrf.aspx/getsubdiv",
                dataType: "json",
                data: JSON.stringify({ typ: "6", ddlvalue: obj.value }),
                beforesend: loadmyloading(),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var getvalue = eval(data.d);
                        console.log("getvalue", getvalue);
                        if (getvalue.length > 0) {
                            ddl_subdivaddnewvar = document.getElementById("<%=ddl_subdivaddnew.ClientID %>");
                                AddOptionsubdiv("--Select--", "0");
                                for (var i = 0; i < getvalue.length; i++) {
                                    AddOptionsubdiv(getvalue[i].SUBDIVISION_NAME, getvalue[i].SUBDIVISION_CODE);
                                }

                            }
                        }
                        removemyloading();
                    }
                });
                // getcostcenter(); due to uat point auto based on empid
            }
            function AddOptionsubdiv(text, value) {
                var option = document.createElement('option');
                option.value = value;
                option.innerHTML = text;
                ddl_subdivaddnewvar.options.add(option);
            }


            var ddl_divaddnewvar;
            function getdiv(obj) {
                $('#ddl_divaddnew').empty();
                $('#ddl_subdivaddnew').empty();
                // $('#ddl_costcenter').empty();   UAT Point 
                var division = obj.value;
                $.ajax({
                    type: "POST",
                    url: "mrf.aspx/getdiv",
                    dataType: "json",
                    data: JSON.stringify({ typ: "5", ddlvalue: obj.value }),
                    beforesend: loadmyloading(),
                    contentType: "application/json",
                    success: function (data) {
                        if (data.d.length > 0) {
                            var getvalue = eval(data.d);
                            console.log("getvalue", getvalue);
                            if (getvalue.length > 0) {
                                ddl_divaddnewvar = document.getElementById("<%=ddl_divaddnew.ClientID %>");
                            AddOptiondiv("--Select--", "0");
                            for (var i = 0; i < getvalue.length; i++) {
                                AddOptiondiv(getvalue[i].DIVISION_NAME, getvalue[i].DIVISION_CODE);
                            }

                        }
                    }
                    removemyloading();
                }
            });
        }
        function AddOptiondiv(text, value) {
            var option = document.createElement('option');
            option.value = value;
            option.innerHTML = text;
            ddl_divaddnewvar.options.add(option);
        }

        //  UAT Point 
        //var ddlcostcenter;
        // function getcostcenter() {
        //     $('#ddl_costcenter').empty();           
        //     $.ajax({
        //         type: "POST",
        //         url: "mrf.aspx/costcenter",
        //         dataType: "json",
        //         data: JSON.stringify({ typ: "2", ddlvalue: $('#ddl_divaddnew').val() }),
        //         beforesend: loadmyloading(),
        //         contentType: "application/json",
        //         success: function (data) {
        //             if (data.d.length > 0) {
        //                 var getvalue = eval(data.d);
        //                 console.log("getvalue", getvalue);
        //                 if (getvalue.length > 0) {
        //                     ddlcostcenter = document.getElementById("<%=ddl_costcenter.ClientID %>");
        //                     AddOptioncostcenter("--Select--", "0");
        //                     for (var i = 0; i < getvalue.length; i++) {
        //                         AddOptioncostcenter(getvalue[i].COST_CENTER_C, getvalue[i].COST_CENTER);
        //                     }
        //
        //                 }
        //             }
        //             removemyloading();
        //         }
        //     });
        // }
        // function AddOptioncostcenter(text, value) {
        //     var option = document.createElement('option');
        //     option.value = value;
        //     option.innerHTML = text;
        //     ddlcostcenter.options.add(option);
        // }

        var wageamount = '0';
        function getposition(obj) {
            var division = obj.value;
            $('#txt_jobroleid').val("");
            $.ajax({
                type: "POST",
                url: "mrf.aspx/getsubdiv",
                dataType: "json",
                data: JSON.stringify({ typ: "4", ddlvalue: obj.value }),
                beforesend: loadmyloading(),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var getvalue = eval(data.d);
                        console.log("getvalue", getvalue);
                        if (getvalue.length > 0) {
                            $('#txt_categorywages').val(getvalue[0].WAGECAT);
                            $('#txt_qualification').val(getvalue[0].QUAL);
                            wageamount = getvalue[0].WAGESAMOUNT;
                            if (getvalue[0].JOB_DESC != null) {
                                var totaljd = getvalue[0].JOB_DESC.split('#');
                                var jddesc = "";
                                if (totaljd.length > 0) {
                                    for (var vcnt = 0; vcnt < totaljd.length; vcnt++) {
                                        jddesc = jddesc + totaljd[vcnt] + "\n";
                                    }
                                }
                                $('#txt_jobroleid').val("");
                                $('#txt_jobroleid').val(jddesc);
                                console.log("totaljd", totaljd);
                            }
                            removemyloading();
                        }
                    }
                    removemyloading();
                }
            });
        }
        var ddl_Reviewer;
        var approverid;
        var approverempid;
        $("#ddl_deptaddnew").change(function () {
            $.ajax({
                type: "POST",
                url: "MRF.aspx/checkbrpluid",
                dataType: "json",
                data: JSON.stringify({ empcode: $("#ddl_deptaddnew").val(), type: "1JK" }),
                beforesend: loadmyloading(),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 4) {
                        var getvalue = eval(data.d);
                        console.log("getvalue", getvalue);
                        if (getvalue.length > 0) {
                            var reviwer, reviewerid;
                            var approver;
                            reviwer = (_.groupBy(getvalue[0], 'REVIEWER'));
                            approver = (_.groupBy(getvalue[0], 'APPROVER'));
                            reviewerid = (_.groupBy(getvalue[0], 'REVIEWEREMPID'));
                            approverid = (_.groupBy(getvalue[0], 'APPROVEREMPID'));
                            var reviwerNames = Object.keys(reviwer);
                            var reviwer = Object.keys(reviewerid);
                            approverempid = Object.keys(approverid);
                            var approverNames = Object.keys(approver);
                            console.log(reviwerNames);
                            if (reviwerNames.length > 0) {
                                ddl_Reviewer = document.getElementById("<%=ddl_Reviewer.ClientID %>");
                                    $('#ddl_Reviewer').empty();
                                    AddOptionddl_Reviewer("--Select--", "0");
                                    for (var i = 0; i < reviwerNames.length; i++) {
                                        AddOptionddl_Reviewer(reviwerNames[i], reviwer[i]);
                                    }
                                }
                                if (approverNames.length > 0) {
                                    $('#txt_approver').val(approverNames[0]);
                                    $('#txt_interviewpanel').val("Anil Chilukuri,Sandeep Shrivastava,Sindhu Nair");
                                }

                            }
                        } else {
                            removemyloading();
                        }
                    removemyloading();
                }
            });
        });


            function AddOptionddl_Reviewer(text, value) {
                var option = document.createElement('option');
                option.value = value;
                option.innerHTML = text;
                ddl_Reviewer.options.add(option);
            }

            function searchemp() {
                var usernameempid = $('#txt_empid').val();
                if (usernameempid != "") {
                    // if ($('#replacementid').val() == "SLA") { added for all search dated 18 march 2021 final uat
                        $.ajax({
                            type: "POST",
                            url: "MRF.aspx/checkbrpluid",
                            dataType: "json",
                            data: JSON.stringify({ empcode: usernameempid, type: "1JJ" }),
                            beforesend: loadmyloading(),
                            contentType: "application/json",
                            success: function (data) {
                                if (data.d.length > 4) {
                                    var getvalue = eval(data.d);
                                    console.log("getvalue", getvalue);
                                    if (getvalue.length > 0) {
                                        $('#txt_empnm').val(getvalue[0][0].EMP_NM); $('#ddl_venaddnew').val(getvalue[0][0].VENDOR_CODE);
                                        $('#placeofposting').val(getvalue[0][0].DIVISION);
                                        //$('#txt_empnm').attr('disabled', 'disabled');         added for all search dated 18 march 2021 final uat
                                        //$('#ddl_venaddnew').attr('disabled', 'disabled');     added for all search dated 18 march 2021 final uat
                                        //$('#placeofposting').prop('disabled', 'disabled');    added for all search dated 18 march 2021 final uat
                                        $('#txt_empnm').prop('disabled', false);
                                        $('#ddl_venaddnew').prop('disabled', false);
                                        $('#placeofposting').prop('disabled', false);
                                    } else {
                                        $('#txt_empnm').val(""); $('#ddl_venaddnew').val(""); $('#placeofposting').val("");
                                        $('#txt_empnm').prop('disabled', false);
                                        $('#ddl_venaddnew').prop('disabled', false);
                                        $('#placeofposting').prop('disabled', false);
                                    }
                                    removemyloading();
                                } else {
                                    $('#txt_empnm').val(""); $('#ddl_venaddnew').val(""); $('#placeofposting').val("");
                                    $('#txt_empnm').prop('disabled', false);
                                    $('#ddl_venaddnew').prop('disabled', false);
                                    $('#placeofposting').prop('disabled', false);
                                    removemyloading();
                                }
                                removemyloading();
                            }
                        });
                        //}  added for all search dated 18 march 2021 final uat
                    //else {
                    //    $('#txt_empnm').prop('disabled', false);
                    //    $('#ddl_venaddnew').prop('disabled', false);
                    //    $('#placeofposting').prop('disabled', false);
                    //    return;
                        //} added for all search dated 18 march 2021 final uat
                } else {
                    $('#txt_empnm').prop('disabled', true);
                    $('#ddl_venaddnew').prop('disabled', true);
                    $('#placeofposting').prop('disabled', true);
                    return;
                }
            }

            //points added based on UAT observation

            $("#ddl_mrfrtype").change(function () {
                if ($("#ddl_mrfrtype").val() == "MRF") {
                    $('#fileDocument').hide()
                }
                if ($("#ddl_mrfrtype").val() == "INDENT") {
                    $('#fileDocument').show()
                }

            });

            $("#replacementid").change(function () {
                $('#txt_empid').val("");
                $('#txt_empnm').val(""); $('#ddl_venaddnew').val("");
                if ($("#replacementid").val() == "SLA") {
                    //$('#txt_empnm').attr('disabled', 'disabled');              added for all search dated 18 march 2021 final uat
                    //$('#ddl_venaddnew').attr('disabled', 'disabled');          added for all search dated 18 march 2021 final uat
                    //$('#placeofposting').prop('disabled', 'disabled');         added for all search dated 18 march 2021 final uat

                }
            });


            $('#txt_empid').on('keypress', function (event) {
                if (event.keyCode == '13') {
                    debugger;
                    if ($('#txt_empid').val() != null) {
                        searchemp();
                        console.log('keypress');
                    }
                    return;
                }
            });
            $('#txt_empid').on('blur', function () {
                debugger;
                if ($('#txt_empid').val() != null) {
                    searchemp();
                    console.log('blur');
                }
                return;
            });

            //points added based on UAT observation
            //dated 28-oct-2020 pint added gl and costcenter


            $("#ddl_costcenter").change(function () {
                if (($("#ddl_costcenter").val() != "0") && ($("#ddl_gl").val() != "0")) {
                    checksapbudget();
                }
            });
            $("#ddl_gl").change(function () {
                if (($("#ddl_costcenter").val() != "0") && ($("#ddl_gl").val() != "0")) {
                    checksapbudget();
                }
            });

            var sapavailablebudget = 0;           
            function checksapbudget() {
                $('#txt_budget').val("");
                $('#txt_budget').empty();
                $.ajax({
                    type: "POST",
                    url: "mrf.aspx/checksapbudget",
                    dataType: "json",
                    data: JSON.stringify({ cc: $('#ddl_costcenter').val(), gl: $('#ddl_gl').val() }),
                    beforesend: loadmyloading(),
                    contentType: "application/json",
                    success: function (data) {
                        if (data.d.length > 0) {
                            var getvalue = eval(data.d);
                            console.log("getvalue", getvalue);
                            if (getvalue.length > 0) {
                                console.log(getvalue);
                                if (getvalue[0].FLAG == "0") {
                                    $('#txt_budget').val("Total Buget: " + getvalue[0].TOTAL_BDGT + ", Avl Budget: " + getvalue[0].AVLE_BDGT);
                                    sapavailablebudget = getvalue[0].AVLE_BDGT;
                                }
                                if (getvalue[0].FLAG == "1") {
                                    $('#txt_budget').val(getvalue[0].MESSAGE);
                                }
                              }
                          }
                          removemyloading();
                      }
            });
              }



    </script>
</asp:Content>

