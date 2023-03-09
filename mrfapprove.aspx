<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="mrfapprove.aspx.cs" Inherits="mrfapprove" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <input type="file" name="fileDocument" id="fileDocument" accept="image/*,application/pdf" hidden="hidden" onchange="onChange_fileDocument(this)" />
    <input type="hidden" name="hdn_RequestNo" id="hdn_RequestNo" value="" />
    <input type="hidden" name="hdn_mgmtrmrk" id="hdn_mgmtrmrk" value="" />
    <input type="hidden" name="hdn_mgmtdt" id="hdn_mgmtdt" value="" />

    <input type="file" name="fileDocumentCV" id="fileDocumentCV" accept="application/zip,application/rar" hidden="hidden" onchange="onChange_fileDocumentCV(this)" />
    <input type="hidden" name="hdn_RequestNoCV" id="hdn_RequestNoCV" value="" />
    <% System.Data.DataTable dt = (System.Data.DataTable)Session["dtVendor"];%>
    <% if (dt != null && dt.Rows.Count > 0)
       { %>
    <input type="text" id="search" style="float: right" />
    <div class="">
        <table border="1" id="gvMain" style="color: #333333; border-collapse: collapse; height: auto !important; max-height: 250px !important" class="table-freeze-multi" data-cols-number="2">
            <tr class="GridViewScrollHeader">
                <th scope="col">
                    <label>
                        <%--<input type="checkbox" id="radApproveAll" title="Approve all" onclick="approveAll(this)" />Approve All--%>Action
                    </label>
                </th>
                <th scope="col">Requisition No.</th>
                <th scope="col">Status</th>
                <th scope="col">Position</th>
                <th scope="col">No of Positions</th>
                <th scope="col">Position Requirement</th>
                <th scope="col">Period(Month)</th>
                <th scope="col">Circle</th>
                <th scope="col">Division</th>
                <th scope="col">Category of Wages</th>
                <th scope="col">Qualification</th>
                <%-- <th scope="col">Job Role</th>--%>
                <th scope="col">Justification</th>
                <th scope="col">Budget(SAP)</th>
                <th scope="col">Budget Availability</th>
                <th scope="col">Manpower Requirement</th>
                <th scope="col">Replacement Against</th>
                <th scope="col">Subdivision</th>
                <th scope="col">Department</th>
                <th scope="col">Employee ID</th>
                <th scope="col">Cost Center</th>
                <th scope="col">Emp Name</th>
                <th scope="col">Place of Posting</th>
                <th scope="col">Vendor</th>
                <th scope="col">Requisitioner</th>
                <th scope="col">Request Date</th>
                <th scope="col">Requisitioner Emp ID</th>
                <th scope="col">Reviewer Emp ID</th>
                <th scope="col">Approver Emp ID</th>
                <th scope="col">Mode of Entry</th>
                <%if (Session["EMP_TYPE"].ToString() != "Reviewer")
                  {%>
                <th scope="col">Reviewed Date</th>
                <th scope="col">Reviewed By</th>
                <th scope="col">Reviewer's Remarks</th>
                <%} %>
                <%if (Session["EMP_TYPE"].ToString() != "Reviewer" && Session["EMP_TYPE"].ToString() != "Approver")
                  {%>
                <th scope="col">Approval Date</th>
                <th scope="col">Approved By</th>
                <th scope="col">Approver's Remarks</th>
                <%} %>
                <th scope="col">Committe Date</th>
                <th scope="col">Committe Remarks</th>
                <%if (Session["EMP_TYPE"].ToString() == "SLA")
                  {%><th scope="col">View</th>
                <th scope="col">Management's Remarks</th>
                <th scope="col">Management Date</th>
                <th scope="col">Upload</th>
                <th scope="col">Upload CV(Zip)</th>
                <%} %>
            </tr>
            <% for (int i = 0; i < dt.Rows.Count; i++)
               { %>
            <tr class="GridViewScrollItem">

                <%if (Session["EMP_TYPE"].ToString() == "SLA" && dt.Rows[i]["APPLICATIONSTATUS"].ToString() == "17" || Session["EMP_TYPE"].ToString() == "SLA" && dt.Rows[i]["APPLICATIONSTATUS"].ToString() == "18" || Session["EMP_TYPE"].ToString() == "SLA" && dt.Rows[i]["APPLICATIONSTATUS"].ToString() == "27")
                  {%><td></td>
                <%}
                  else
                  {%>
                <td>
                    <label>
                        <input type="radio" class="approve" id="approve" name="<%=("chk")+i %>" value="<%=(Session["EMP_TYPE"].ToString()=="Reviewer")?"1":(Session["EMP_TYPE"].ToString()=="Approver")?"3":(Session["EMP_TYPE"].ToString()=="HOD")?"5":(Session["EMP_TYPE"].ToString()=="Audit")?"7":(Session["EMP_TYPE"].ToString()=="F&A")?"9":(Session["EMP_TYPE"].ToString()=="HR")?"11":(Session["EMP_TYPE"].ToString()=="Budget")?"13":(Session["EMP_TYPE"].ToString()=="Chairman")?"15":(Session["EMP_TYPE"].ToString()=="SLA")?"24":""%>" onclick="chkOnClick('<%=i%>    ');" data-value="<%=i %>" />
                        <% 
                      if (dt.Rows[i]["APPLICATIONSTATUS"].ToString() == "8" || dt.Rows[i]["APPLICATIONSTATUS"].ToString() == "10" || dt.Rows[i]["APPLICATIONSTATUS"].ToString() == "12" || dt.Rows[i]["APPLICATIONSTATUS"].ToString() == "14")
                      {%>Re -Evaluate<%}
                      else if (dt.Rows[i]["APPLICATIONSTATUS"].ToString() == "15" || dt.Rows[i]["APPLICATIONSTATUS"].ToString() == "24" || dt.Rows[i]["APPLICATIONSTATUS"].ToString() == "25")
                      {%>On-Hold<%}                     
                      else
                      {%>Approve<%}%></label>

                    <input type="hidden" name="hdnApproveRemarks" value="" id='<%="hdnApproveRemarks_"+i %>' />
                    <label>
                        <input type="radio" class="reject" id="reject" name="<%=("chk")+i %>" value="<%=(Session["EMP_TYPE"].ToString()=="Reviewer")?"2":(Session["EMP_TYPE"].ToString()=="Approver")?"4":(Session["EMP_TYPE"].ToString()=="HOD")?"6":(Session["EMP_TYPE"].ToString()=="Audit")?"8":(Session["EMP_TYPE"].ToString()=="F&A")?"10":(Session["EMP_TYPE"].ToString()=="HR")?"12":(Session["EMP_TYPE"].ToString()=="Budget")?"14":(Session["EMP_TYPE"].ToString()=="Chairman")?"16":(Session["EMP_TYPE"].ToString()=="SLA")?"25":""%>" onclick="chkOnClick('<%=i%>    ');" data-value="<%=i %>" />Reject</label>
                    <input type="hidden" name="hdnRejectRemarks" value="" id='<%="hdnRejectRemarks_"+i %>' />
                    <input type="hidden" name="hdnStatus" value="" id='<%="hdnStatus"+i %>' />
                    <%} %>
                    <script type="text/javascript">                       
                        function chkOnClick(obj) {
                            debugger;
                            var radiobutton = "";
                            var chk="chk"+obj
                            radiobutton = $('input[name='+chk+']:checked').val();
                            var hdnRejectRemarks = 'hdnRejectRemarks_' + $('input[name='+chk+']:checked').data('value');
                            var hdnStatus = '#hdnStatus' + $('input[name='+chk+']:checked').data('value');
                            if (radiobutton == "2"||radiobutton == "4"||radiobutton == "6"||radiobutton == "8"||radiobutton == "10"||radiobutton == "12"||radiobutton == "14"||radiobutton == "16"||radiobutton == "25") {
                                $('#hdnCount').val(hdnRejectRemarks);
                                $("#exampleModal").modal("show");                           
                                $(hdnStatus).val(radiobutton);                                                                   
                            }
                            else {
                                var radiobuttonapprove = "";
                                var chkapprove="chk"+obj
                                radiobuttonapprove = $('input[name='+chkapprove+']:checked').val();
                                var hdnRejectRemarks = 'hdnRejectRemarks_' + $('input[name='+chkapprove+']:checked').data('value');
                                // var hdnApproveRemarks = 'hdnApproveRemarks_' + $('input[name='+chkapprove+']:checked').data('value');  
                                var hdnStatus = '#hdnStatus' + $('input[name='+chkapprove+']:checked').data('value');
                                if (radiobuttonapprove == "1"||radiobuttonapprove == "3"||radiobuttonapprove == "5"||radiobuttonapprove == "7"||radiobuttonapprove == "9"||radiobuttonapprove == "11"||radiobuttonapprove == "13"||radiobuttonapprove == "15"||radiobuttonapprove == "24") {
                                    $('#hdncountapprove').val(hdnRejectRemarks);
                                    $("#exampleModalapprove").modal("show"); 
                                    $(hdnStatus).val(radiobuttonapprove); 
                                }                                                            
                            }
                        }
                    </script>
                </td>
                <td><a href="javascript:" onclick="backendcall('<% Response.Write(dt.Rows[i]["REQUISITIONNO"].ToString()); %>')"><% Response.Write(dt.Rows[i]["REQUISITIONNO"].ToString()); %></a></td>
                <td><% Response.Write(dt.Rows[i]["Status"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["REQUIREDPOSITION"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["REQUIREDNOOFPOSITION"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["POSITIONREQUIREMENT"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["PERIODREQUIREMENT"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["CIRCLE"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["DIVISION"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["CATEGORYOFWAGES"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["QUALIFICATION"].ToString()); %></td>
                <%--<td style="word-wrap:break-word !important"><% Response.Write(dt.Rows[i]["JOBROLEID"].ToString()); %></td>--%>
                <td><% Response.Write(dt.Rows[i]["JUSTIFICATION"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["REQUIREDBUDGET"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["BUDGETAVAILABILTY"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["MANPOWERREQUIREMENT"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["REPLACEMENTAGAINST"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["SUDIVISION"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["DEPARTMENT"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["EMPLOYEEID"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["COSTCENTER"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["EMPLOYEENAME"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["PLACEOFPOSTING"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["VENDOR"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["REQUISTIONER"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["INSRTDT"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["INSRRTBY"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["REVIEWERID"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["APPROVERID"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["INSRTUSING"].ToString()); %></td>
                <%if (Session["EMP_TYPE"].ToString() != "Reviewer")
                  {%>
                <td><% Response.Write(dt.Rows[i]["REVIWERINSRTDT"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["REVIWERINSRTBY"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["REVIWERAPPRMRK"].ToString()); %></td>
                <%} %>
                <%if (Session["EMP_TYPE"].ToString() != "Reviewer" && Session["EMP_TYPE"].ToString() != "Approver")
                  {%>
                <td><% Response.Write(dt.Rows[i]["APPROVERINSRTDT"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["APPROVERINSRTBY"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["APPROVERAPPRMRK"].ToString()); %></td>
                <%} %>
                <td><% Response.Write(dt.Rows[i]["CHAIRMANINSRTDT"].ToString()); %></td>
                <td><% Response.Write(dt.Rows[i]["CommitteRemarks"].ToString()); %></td>

                <% 
                   if (Session["EMP_TYPE"].ToString() == "SLA" && dt.Rows[i]["APPLICATIONSTATUS"].ToString() == "15" || Session["EMP_TYPE"].ToString() == "SLA" && dt.Rows[i]["APPLICATIONSTATUS"].ToString() == "24")
                   {%>
                <td>
                    <button type="button" class="btn btn-danger  btn-sm" onclick="Download('<% Response.Write(dt.Rows[i]["REQUISITIONNO"].ToString()); %>');return false;"><i class="fa fa-download"></i></button>
                </td>
                <td>
                    <input type="text" id='<%="txt_managementrmrk_"+i %>' class="form-control" /></td>
                <td>
                    <input type="text" id='<%="txt_managementdate_"+i %>' class="form-control datetimepicker" readonly="readonly" style="background-color: white !important" /></td>
                <td>
                    <button type="button" class="btn btn-danger  btn-sm" onclick="Upload('<% Response.Write(dt.Rows[i]["REQUISITIONNO"].ToString()); %>',$('#<%="txt_managementrmrk_"+i %>').val(),$('#<%="txt_managementdate_"+i %>').val());return false;"><i class="fa fa-upload"></i></button>
                </td>
                <%}%>
                <% else
                   {%>
                <%}%>

                <% if (Session["EMP_TYPE"].ToString() == "SLA" && dt.Rows[i]["APPLICATIONSTATUS"].ToString() == "27")
                   {%><td></td>
                <td></td>
                <td></td>
                <td></td>
                <td>
                    <button type="button" class="btn btn-danger  btn-sm" onclick="UploadCV('<% Response.Write(dt.Rows[i]["REQUISITIONNO"].ToString()); %>');return false;"><i class="fa fa-upload"></i></button>
                </td>
                <%}%>
            </tr>

            <% }
       } %>
        </table>
        <asp:Label runat="server" ID="lbl_message" class=" col-sm-12 pull-right text-danger" Style="text-align: center"></asp:Label>
        <div class="col-lg-12" id="interviewdiv" runat="server" visible="false">
            <div class="row">
                <div class="form-group col-sm-6">
                    <label class="col-form-label">Interview Chairman:</label>
                    <asp:DropDownList runat="server" ID="ddl_chairman" CssClass="form-control" ClientIDMode="Static"></asp:DropDownList>
                </div>
                <div class="form-group col-sm-6">
                    <label class="col-form-label">Interview Member:</label>
                    <asp:TextBox runat="server" ID="txt_interviewmember" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                </div>
            </div>
        </div>
        <div class="col-lg-12" id="costdiv" runat="server" visible="false">
            <div class="form-group">
                <label class="col-form-label">Cost Benefit:<span class="text-danger">*</span></label>
                <asp:TextBox runat="server" ID="txt_costbenefit" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
            </div>
        </div>
        <div class="col-lg-12" id="ddl_provisiondiv" runat="server" visible="false">
            <div class="form-group">
                <label class="col-form-label">Provision:<span class="text-danger">*</span></label>
                <select class="form-control" id="ddl_provision">
                    <option value="NA">--Select--</option>
                    <option value="Transfer">Transfer</option>
                    <option value="Additional">Additional</option>
                    <option value="Transfer/ Additional">Transfer/ Additional</option>
                    <option value="Budget Provision">Budget Provision</option>
                </select>
            </div>
        </div>
        <div class="col-lg-12" id="ddl_hrdiv" runat="server" visible="false">
            <div class="row">
                <div class="form-group col-sm-4">
                    <label class="col-form-label">Provision:<span class="text-danger">*</span></label>
                    <select class="form-control" id="ddl_hrprovision">
                        <option value="NA">--Select--</option>
                        <option value="Internal">Internal</option>
                        <option value="External">External</option>
                    </select>
                </div>
                  <script>
                      $("#ddl_hrprovision").change(function () {
                          if ($("#ddl_hrprovision").val() == "Internal") {
                              $("#ddl_hrprovisionid").show();
                              $("#ddl_hrprovisionname").show();
                              $("#ddl_hrprovisionempid").val("");
                              $("#ddl_hrprovisionempname").val("");
                          } else {
                              $("#ddl_hrprovisionid").hide();
                              $("#ddl_hrprovisionname").hide();
                              $("#ddl_hrprovisionempid").val("");
                              $("#ddl_hrprovisionempname").val("");
                          }
                      });
                        </script>
                <div class="form-group col-sm-4" id="ddl_hrprovisionid" style="display: none">
                    <label class="col-form-label">Employee ID:<span class="text-danger">*</span></label>
                    <asp:TextBox runat="server" ID="ddl_hrprovisionempid" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                </div>
                <div class="form-group col-sm-4" id="ddl_hrprovisionname" style="display: none">
                    <label class="col-form-label">Employee Name:</label>
                    <asp:TextBox runat="server" ID="ddl_hrprovisionempname" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                </div>               
            </div>
        </div>
        <div class="col-sm-12 pull-right" style="text-align: center">
            <asp:Button ID="btn_Save" runat="server" Text="Save" class="btn btn-primary submit-btn" ClientIDMode="Static" OnClientClick="save();return false;" Visible="false" />
        </div>


    </div>
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Reject Remarks</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:TextBox ID="txtRejectRemarks" TextMode="MultiLine" CssClass="form-control" ClientIDMode="Static" runat="server" />
                            <input type="hidden" name="hdnCount" value="" id="hdnCount" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <input type="button" name="btnModelOk" value="OK" onclick="RejctRemarksOK();return false;" class="btn btn-danger" />
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="exampleModalapprove" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="H2">Remarks</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:TextBox ID="txtApproveRemarks" TextMode="MultiLine" CssClass="form-control" ClientIDMode="Static" runat="server" />
                            <input type="hidden" name="hdncountapprove" value="" id="hdncountapprove" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <input type="button" name="btnModelOk" value="OK" onclick="ApproveRemarksOK();return false;" class="btn btn-danger" />
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

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
                                    <div class="row" id="gridtablediv"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function popups(msg) {                    
            document.getElementById("<%=lbl_msg.ClientID %>").innerHTML = msg;
            $("#alertMessage").modal("show");
        }

        function save() {
            var count=0;
            debugger
            //string reqid, string emp_code, string status, string rejectRemarks
            var emp_code = '<%=Session["EMP_CODE"].ToString()%>';
            var div_code = '<%=Session["DIV_code"].ToString()%>';
            var emp_typ='<%=Session["EMP_TYPE"].ToString()%>';
            var status = '';//$('input[name=chk]:checked').val();
            var reqid = '';
            var approveReject=[];
            var IsApprove=0;
            IsApprove+=$("input:radio.approve:checked").length;
            IsApprove+=$("input:radio.reject:checked").length;
            if(IsApprove>0)
            {   //loadmyloading();
                $('.GridViewScrollItem').each(function (key,arr)  
                { 
                    console.log(arr);                  
                    var IsrejctApprove=0;
                    var rejectRemarks=$('#hdnRejectRemarks_'+key).val();
                    $(arr).find("td:first-child input[class=reject]").each(function (i, chk) {
                        console.log("reject"+i, chk.name );
                        var rates = document.getElementsByName(chk.name);                        
                        for(var i = 0; i < rates.length; i++){
                            if(rates[i].checked){
                                IsrejctApprove ++;
                            }
                        }                        
                    });
                    var ApproveRemarks=$('#hdnRejectRemarks_'+key).val();
                    $(arr).find("td:first-child input[class=approve]").each(function (i, chk) {
                        console.log("approve"+i, chk);                       
                        var rates = document.getElementsByName(chk.name);                        
                        for(var i = 0; i < rates.length; i++){
                            if(rates[i].checked){
                                IsrejctApprove ++;
                            }
                        }
                        
                    });                   
                    console.log("IsrejctApprove",IsrejctApprove);
                    if(IsrejctApprove>0)
                    {
                        $(arr).find("td:first-child input[name=hdnStatus]").each(function (i, chk) {
                            console.log(i, $(chk).val());
                            status = $(chk).val();
                        });
                        $(arr).find("td:nth-child(2)").each(function (i, chk) {
                            reqid = $(chk)[0].innerText.trim();
                        }); 

                        var intcost='';
                        if(emp_typ=='Approver')
                        {intcost=$('#ddl_chairman').val()+ " , "+ $('#txt_interviewmember').val();}
                        if(emp_typ=='F&A')
                        {intcost=$('#txt_costbenefit').val();}
                        if(emp_typ=='Budget')
                        {intcost=$('#ddl_provision').val();}
                        if(emp_typ=='HR')
                        {
                            intcost =$('#ddl_hrprovision').val() + "&" + $('#ddl_hrprovisionempid').val() + "&" + $('#ddl_hrprovisionempname').val();                                                       
                            
                        }
                        
                        if((emp_typ=="app"||emp_typ=="F&A"||emp_typ=='HR' || emp_typ=='Budget') && (intcost==''||intcost=='NA')){ left("Please fill all the mandatory fileds");}else{
                            var approveRejectItem={ reqid: reqid,emp_typ:emp_typ, emp_code: emp_code, status:status,  rejectRemarks:rejectRemarks,ApproveRemarks:ApproveRemarks,interviewmember:intcost };
                            approveReject.push(approveRejectItem);
                        }
                    }
                    
                });    

                if(approveReject.length>0)
                {
                    console.log(JSON.stringify(approveReject));

                    $.ajax({

                        url: 'MRFapprove.aspx/Save',

                        type: "POST",

                        dataType: "json",

                        data: JSON.stringify({approveReject:approveReject}),

                        contentType: "application/json; charset=utf-8",

                        success: function (data) {

                            console.log(data);
                            if (data.d[0].MSG_CODE == "0" || data.d[0].MSG_CODE == 0) {
                                left(data.d[0].TXT);
                                removemyloading();                                
                            }   else {
                                left(data.d[0].TXT);
                                removemyloading();                                
                            }   
                        }, error: function (err) {
                            console.log(err);
                            removemyloading();
                        }
                    });
                }               
            }
            else{
                popups("Please select at least one record!!!");
            }
        }
        function clearFunction(key,count) {
            if(($('.GridViewScrollItem').length-1)==key)
            { 
                removemyloading();
                if(count>1)
                {
                    left("Approved");
                           
                } 
            }
        }
        function RejctRemarksOK() {
            
            // hdnRejectRemarks_
            var rejctRemarksCount = $('#hdnCount').val();
            var txtRejectRemarks = $('#txtRejectRemarks').val();
            if (txtRejectRemarks == null || txtRejectRemarks == "") {
                right("Please enter reject remarks !!!")
            } else {
                $('#' + rejctRemarksCount).val(txtRejectRemarks);
                $('#txtRejectRemarks').val("");
                $("#exampleModal").modal("hide");              
            }
        }
        
        function ApproveRemarksOK() {
            debugger;
            // hdnRejectRemarks_
            var ApproveRemarksCount = $('#hdncountapprove').val();
            var txtApproveRemarks = $('#txtApproveRemarks').val();
            if (txtApproveRemarks == null || txtApproveRemarks == "") {               
                right("Please enter remarks !!!")
            } else {
                $('#' + ApproveRemarksCount).val(txtApproveRemarks);
                $('#txtApproveRemarks').val("");
                $("#exampleModalapprove").modal("hide");
                
            }
        }
        function approveAll(ele) {         
          
            if (ele.checked) {            
                $('.approve').prop("checked",true);
                $('.approve').each(function( key,data) {
                    chkOnClick(key)
                })                
            } else {               
                $('.approve').prop("checked",false);
                $('.approve').each(function( key,data) {
                    chkOnClick(key)
                })              
            }            
        }

        function Download(requestNo) {
            console.log(requestNo);
            $.ajax({

                url: 'MRFapprove.aspx/createpdf',

                type: "POST",

                dataType: "json",

                data: JSON.stringify({refno:requestNo}),

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
            var blob = new Blob([byte], { type: "application/pdf" });
            var link = document.createElement('a');
            link.href = window.URL.createObjectURL(blob);
            var fileName = reportName;
            link.download = fileName;
            link.click();
        };


        function Upload(requestNo,mgmtrmrk,mgmtdt) {
            console.log(requestNo);           
            $("#hdn_RequestNo").val(requestNo);   
            
            $("#hdn_mgmtrmrk").val(mgmtrmrk);
            $("#hdn_mgmtdt").val(mgmtdt);

            if($("#hdn_mgmtrmrk").val()==""|| $("#hdn_mgmtdt").val()=="")
            {
                popups("Management's Remarks and Management Date should be filled!!!");
            }
            else
            { 
                $('#fileDocument').trigger('click');
            }
        } 
        function onChange_fileDocument(obj) {          
            var fileUpload = $("#fileDocument").get(0);  
            var files = fileUpload.files;  
              
            // Create FormData object  
            var fileData = new FormData();  
  
            // Looping over all files and add it to FormData object  
            for (var i = 0; i < files.length; i++) {  
                fileData.append(files[i].name, files[i]);  
            }  
            var requestNo = $("#hdn_RequestNo").val();
            // Adding one more key to FormData object  
            fileData.append('requestNo', requestNo);           
            fileData.append('docType', '17');
            fileData.append('Managementrmrk',  $("#hdn_mgmtrmrk").val());
            fileData.append('ManagementDt',  $("#hdn_mgmtdt").val());
            

            $.ajax({  
                url: 'approvalnote.ashx',
                type: "POST",  
                contentType: false, // Not to set any content header  
                processData: false, // Not to process data  
                data: fileData,
                beforesend:loadmyloading(),
                success: function (result) {
                    debugger;
                    left(result.name);
                    $("#hdn_RequestNoFile").val("");
                    $("#hdn_CANOFile").val("");                   
                    removemyloading();
                },  
                error: function (err) {  
                    alert(err.statusText);
                    removemyloading();
                }  
            });  
         
        }

        function UploadCV(requestNo)
        {
            console.log(requestNo);           
            $("#hdn_RequestNoCV").val(requestNo);            
            $('#fileDocumentCV').trigger('click');
        }



        function onChange_fileDocumentCV(obj) {          
            var fileUpload = $("#fileDocumentCV").get(0);  
            var files = fileUpload.files;  
              
            // Create FormData object  
            var fileData = new FormData();  
  
            // Looping over all files and add it to FormData object  
            for (var i = 0; i < files.length; i++) {  
                fileData.append(files[i].name, files[i]);  
            }  
            var requestNo = $("#hdn_RequestNoCV").val();
            // Adding one more key to FormData object  
            fileData.append('requestNo', requestNo);           
            fileData.append('docType', '18');
            fileData.append('Managementrmrk', '');
            fileData.append('ManagementDt', '');
            
            $.ajax({  
                url: 'approvalnote.ashx',
                type: "POST",  
                contentType: false, // Not to set any content header  
                processData: false, // Not to process data  
                data: fileData,
                beforesend:loadmyloading(),
                success: function (result) {
                    debugger;
                    left(result.name);
                    $("#hdn_RequestNoFile").val("");
                    $("#hdn_CANOFile").val("");                   
                    removemyloading();
                },  
                error: function (err) {  
                    alert(err.statusText);
                    removemyloading();
                }  
            }); 
        }
    </script>


    <script>
        function backendcall(obj) {           
            var mrfid = obj;
            $.ajax({
                type: "POST",
                url: "mrfapprove.aspx/bindmoredata",
                dataType: "json",
                data: JSON.stringify({ typ: "20", id: mrfid}),
                contentType: "application/json",
                beforesend:loadmyloading(),
                success: function (data) {
                    if (data.d.length > 0) {  
                        $('#gridtablediv').html('');
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
                                    if(key=="Job Role" || key.includes("Intrim")){
                                        th += '<div class="col-md-12"><div class="form-group"><label>' + key + '</label><textarea  rows="2" cols="20" class="form-control" disabled="disabled">'+fault[i][key] +'</textarea></div></div>';                                   
                                    }else{
                                        th += '<div class="col-md-6"><div class="form-group"><label>' + key + '</label><input type="text"  class="form-control" disabled="disabled" value="'+fault[i][key] +'"/></div></div>';                                   
                                    }
                                }
                            }                           
                        }                   
                        gridtable += '  ' + th + '';
                        $('#gridtablediv').append(gridtable);

                    }
                    removemyloading();
                }
            });
            $('#MRFinformation').modal('show');            
        }


        $(document).ready(function () { $('#search').keyup(function () {
            search_table($(this).val());
        })
        
            function search_table(value) {            

                $('table tr').each(function(records) {                   
                    
                    if(records!==0){
                        $("table tr:has(td)").each(function () {
                            var id = $(this).text().toLowerCase();
                            if(id.toLowerCase().indexOf(value.toLowerCase())>=0)
                            {
                                $(this).show();
                            }else{
                                $(this).hide();
                            }
                        }
                        );
                  
                    
                    }
                });
            }
        });

        $('#ddl_hrprovisionempid').on('keypress', function (event) {
            if(event.keyCode=='13'){
                getcandidate();
            }
        });
        $('#ddl_hrprovisionempid').on('blur', function () {            
                getcandidate();            
        });

        function getcandidate() {
            var usernameempid = $('#ddl_hrprovisionempid').val();
            if (usernameempid != "") {              
                $.ajax({
                    type: "POST",
                    url: "mrfapprove.aspx/checkbrpluid",
                    dataType: "json",
                    data: JSON.stringify({ empcode: usernameempid, type: "1JJ" }),
                    beforesend: loadmyloading(),
                    contentType: "application/json",
                    success: function (data) {
                        if (data.d.length > 4) {
                            var getvalue = eval(data.d);
                            console.log("getvalue", getvalue);
                            if (getvalue.length > 0) {
                                $('#ddl_hrprovisionempname').val(getvalue[0][0].EMP_NM); 
                            } else {
                                $('#ddl_hrprovisionempname').val(""); 
                            }
                            removemyloading();
                        } else {
                            $('#ddl_hrprovisionempname').val(""); 
                            removemyloading();
                        }
                        removemyloading();
                    }
                });
            }
    
        }
    </script>
</asp:Content>

