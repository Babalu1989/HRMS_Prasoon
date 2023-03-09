<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="Clearance.aspx.cs" Inherits="Clearance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <asp:FileUpload ID="FileUpload" runat="server" CssClass="btn add-btn" Style="height: 36px; margin-top: 10px;" />
        <asp:Button ID="btnUpload" runat="server" OnClick="btnUpload_Click" Text="Upload" CssClass="float-left" hidden="hidden" CausesValidation="False" />
        <div class="float-left" style="margin-top: 1%; margin-left: 5px;">
            <asp:Label runat="server" ID="lbl_msg" ForeColor="Red"></asp:Label>
            <a href="#" class="btn add-btn" data-toggle="modal" data-target="#add_employee"><i class="fa fa-plus"></i>Entry Form</a>
            <div style="float: right; margin-top: 8px;">&nbsp;&nbsp;&nbsp;OR&nbsp;&nbsp;&nbsp;</div>
            <a id="A1" href="javascript:void(0);" class="btn add-btn" onclick="btnfire();return false;">Upload</a>
            <script> function btnfire() {
     document.getElementById("<%=btnUpload.ClientID %>").click();

 } function btnfiledwn() {
     document.getElementById("<%=filedownload.ClientID %>").click();

 }

            </script>
        </div>
        <asp:Button runat="server" ID="filedownload" OnClick="filedownload_Click" hidden="hidden" CausesValidation="False" />
        <i class="fa fa-file-excel-o float-right" style="font-size: 30px; margin-left: 90%; margin-top: -3%; color: green;" data-toggle="tooltip" title="Sample File" onclick="btnfiledwn();return false;"></i>
    </div>
    <div class="row">
        <div class="col-lg-12 ">
            <div class="table-responsive">
                <asp:GridView runat="server" ID="gv_uploaddata" ClientIDMode="Static" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="false" DataKeyNames="EmpId" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnRowDataBound="gv_uploaddata_RowDataBound" OnRowDeleting="GridView1_RowDeleting">
                    <Columns>
                        <asp:CommandField ShowEditButton="true" />
                        <asp:BoundField DataField="SNo" HeaderText="SNo" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="EmpId" HeaderText="EmpId" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="Name" HeaderText="Name" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="Roles" HeaderText="Roles" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="Company" HeaderText="Company" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="DOB" HeaderText="DOB(DDMMYYYY)" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="Aadhaar" HeaderText="Aadhaar" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="DOJ" HeaderText="DOJ(DDMMYYYY)" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="Department" HeaderText="Department" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="Location" HeaderText="Location" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="DOS" HeaderText="DOS(DDMMYYYY)" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="Reason for Seperation" HeaderText="Reason for Seperation" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="Mobile" HeaderText="Mobile" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="Email" HeaderText="Email" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="L1 Empid" HeaderText="L1 Empid" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="L1 Name" HeaderText="L1 Name" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="L1 Mobile" HeaderText="L1 Mobile" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="L1 Email" HeaderText="L1 Email" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
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


    <div id="add_employee" class="modal custom-modal fade" role="dialog">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Form Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>EmpId<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" value="" id="empid" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Name<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" value="" id="name" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Roles<span class="text-danger">*</span></label>
                                <select class="form-control" id="roles">
                                    <option>--Select--</option>
                                    <option>Normal</option>
                                    <option>Special</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Company/Vendor<span class="text-danger">*</span></label>
                                <asp:DropDownList runat="server" ID="ddl_vendor_popup" class="form-control" data-error-msg="Vendor Required" ClientIDMode="Static"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="col-form-label">Birth Date <span class="text-danger">*</span></label>
                                <div class="cal-icon">
                                    <input class="form-control datetimepicker" type="text" maxlength="9" data-error-msg="Birth Date Required" id="addmodaldob" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Aadhaar<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" value="" id="aadhar" maxlength="10" onkeypress="return validatenumber(event)" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="col-form-label">Date of Joining<span class="text-danger">*</span></label>
                                <div class="cal-icon">
                                    <input class="form-control datetimepicker" type="text" maxlength="9" data-error-msg="DOJ Required" id="doj" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Department<span class="text-danger">*</span></label>
                                <asp:DropDownList runat="server" ID="ddl_department_popup" class="form-control" ClientIDMode="Static"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Location<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" value="" id="location" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="col-form-label">Date of Seperation<span class="text-danger">*</span></label>
                                <div class="cal-icon">
                                    <input class="form-control datetimepicker" type="text" maxlength="9" data-error-msg="DOS Required" id="dos" />
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-group">
                                <label>Reason for Seperation<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" value="" id="ros" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Mobile<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" value="" id="mobile" maxlength="10" onkeypress="return validatenumber(event)" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Email<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" value="" id="email" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>L1 Empid<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" value="" id="liempid" maxlength="10" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>L1 Name<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" value="" id="liname" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>L1 Mobile<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" value="" id="limobile" maxlength="10" onkeypress="return validatenumber(event)" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>L1 Email<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" value="" id="liemail" />
                            </div>
                        </div>

                    </div>
                    <div class="submit-section">
                        <button class="btn btn-primary submit-btn" onclick="function_clearance_insert();">Submit</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <script>
        $('#gv_uploaddata').DataTable();
        function function_clearance_insert() {
            $.ajax({
                type: "POST",
                url: "Clearance.aspx/clearancedsave",
                dataType: "json",
                data: JSON.stringify({ typ: "101", empid: $('#empid').val(), name: $('#name').val(), roles: $('#roles').val(), company: $('#ddl_vendor_popup').val(), dob: $('#addmodaldob').val(), aadhar: $('#aadhar').val(), doj: $('#doj').val(), department: $('#ddl_department_popup').val(), location: $('#location').val(), dos: $('#dos').val(), dosreason: $('#ros').val(), mobile: $('#mobile').val(), email: $('#email').val(), liempid: $('#liempid').val(), liname: $('#liname').val(), limobile: $('#limobile').val(), liemail: $('#liemail').val() }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var getvalue = eval(data.d);
                        alert("getvalue", getvalue);
                        if (getvalue.length > 0) {
                            left("Successfully Saved!!!!");
                        }
                    }
                }
            });
        }
    </script>
</asp:Content>

