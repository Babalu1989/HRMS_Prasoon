<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="BulkSMS.aspx.cs" Inherits="Clearance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        input {
            width: 100%;
        }
    </style>
    <div class="row">
        <div class="col-sm-4">
            <asp:FileUpload ID="FileUpload" runat="server" CssClass="btn add-btn" Style="height: 36px; margin-top: 10px;" />
            <asp:Button ID="btnUpload" runat="server" OnClick="btnUpload_Click" Text="Upload" CssClass="float-left" hidden="hidden" />
               <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Upload" CssClass="float-left" hidden="hidden" />
        </div>
        <div class="col-sm-6">
            <div class="float-left" style="margin-top: 1%; margin-left: 5px;">
                <a href="#" class="btn add-btn" onclick="btnsubmit();return false;">Submit</a>
                <div style="float: right; margin-top: 8px;">&nbsp;&nbsp;&nbsp;&nbsp;</div>
                <a id="A1" href="javascript:void(0);" class="btn add-btn" onclick="btnfire();return false;">Verify</a>
            </div>
            <script>
                function btnfire() {
                  document.getElementById("<%=btnUpload.ClientID %>").click();
                  } 
                function btnsubmit() {
                    document.getElementById("<%=Button1.ClientID %>").click();
                }
                function btnfiledwn() {
                    document.getElementById("<%=filedownload.ClientID %>").click();
                }
            </script>
        </div>
         <div class="col-sm-2">
         <asp:Button runat="server" ID="filedownload" OnClick="filedownload_Click"  hidden="hidden" CausesValidation="False" />
        <i class="fa fa-file-excel-o float-right" style="font-size: 30px; margin-left:90%; margin-top:-3%; color: green;" data-toggle="tooltip" title="Sample SMS File" onclick="btnfiledwn();return false;"></i>
             </div>
    </div>
    <div class="row">
        <div class="col-lg-12 ">
            <div class="table-responsive">
                <asp:GridView runat="server" ID="gv_uploaddata" ClientIDMode="Static" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="false" DataKeyNames="Mobile" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating">
                    <Columns>
                        <asp:CommandField ShowEditButton="true" />
                        <asp:BoundField DataField="SNo" HeaderText="SNo" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="Mobile" HeaderText="Mobile" HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="Message" HeaderText="Message" HeaderStyle-CssClass="col-lg-9" ItemStyle-CssClass="col-lg-9" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
    <script>
        $('#gv_uploaddata').DataTable();
    </script>
</asp:Content>

