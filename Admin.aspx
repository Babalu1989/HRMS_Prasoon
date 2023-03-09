<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="rolerightsdiv">
        <table class="form" align="left" style="font-family: Verdana; font-size: small; margin-left: 10px;">
            <tr>
                <td colspan="3" style="text-align:left">
                    <h4 class="page-title" style="color: #ff9b44">Role & Rights</h4>                    
                </td>
            </tr>
            <tr>
                <td>
                    <span class="small_text fade_text">Employee Code</span>
                    <asp:TextBox class="form-control" ID="txt_empidrole" runat="server" ClientIDMode="Static"></asp:TextBox>
                </td>
                <td>
                    <i class="fa fa-search" aria-hidden="true" style="margin-top: 22px!important; color: #ff9b44; font-size: 25px" onclick="rolesearch(); return false;"></i>
                </td>
                <td>
                    <span class="small_text fade_text">Employee Name</span>
                    <asp:TextBox ID="txt_empnamerole" runat="server" class="form-control" ClientIDMode="Static" disabled Style="width: 200px"></asp:TextBox>
                </td>
            </tr>
             <tr>
                <td colspan="3" style="text-align: center;margin-bottom:10px;"></td></tr>
            <tr>
                <td colspan="3" style="text-align: center">
                    <table>
                        <tr>
                            <td>
                                <asp:TreeView ID="TreeView1" ClientIDMode="Static" runat="server" ShowCheckBoxes="All" ShowLines="true" LeafNodeStyle-ForeColor="Green" Style="margin-top: 10%; padding-left: 70px" CssClass="tree"></asp:TreeView>
                                <script type="text/javascript">
                                    $(function () {
                                        $("[id*=TreeView1] input[type=checkbox]").bind("click", function () {

                                            var table = $(this).closest("table");
                                            if (table.next().length > 0 && table.next()[0].tagName == "DIV") {
                                                //Is Parent CheckBox
                                                var childDiv = table.next();
                                                var isChecked = $(this).is(":checked");
                                                $("input[type=checkbox]", childDiv).each(function () {
                                                    if (isChecked) {
                                                        $(this).prop("checked", true);
                                                    } else {
                                                        $(this).prop("checked", false);
                                                    }
                                                });
                                            } else {
                                                //Is Child CheckBox
                                                var parentDIV = $(this).closest("DIV");
                                                if ($("input[type=checkbox]", parentDIV).length == $("input[type=checkbox]:checked", parentDIV).length) {
                                                    $("input[type=checkbox]", parentDIV.prev()).prop("checked", true);
                                                } else {
                                                    $("input[type=checkbox]", parentDIV.prev()).prop("checked", false);
                                                }
                                            }
                                        });
                                    })

                                </script>

                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td style="text-align: right; margin-left: 150px">
                                <asp:Button ID="btn_roleupdate" runat="server" Text="Update" class="btn btn-primary submit-btn pull-right" Style="margin-bottom: 10px; display: none; margin-left: 25px" border-radius="25px 25px 25px 25px" ClientIDMode="Static" OnClientClick="return GetselectedNodes();" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <script>
        var PreviousSelected = [];
        function rolesearch() {

            var empcode = $('#txt_empidrole').val();
            if (empcode == "") {
                left("First Fill Data");
            }
            else {
                //  loadmyloading();
                //$.each($("[id*=TreeView1] a"), function (j, node) {
                //    console.log(j,node)
                //});
                $("input[type=checkbox]").prop("checked", false);
                $.ajax({

                    url: 'Admin.aspx/rolesearch',

                    type: "POST",

                    dataType: "json",

                    data: JSON.stringify({ empcode: empcode }),

                    contentType: "application/json; charset=utf-8",

                    success: function (data) {
                        //  console.log(data.length);
                        if (data.d[0].EMPNAME != undefined) {
                            //   removemyloading();
                            // console.log(data.d[0].Role)
                            $('#btn_roleupdate').show();
                            $('#txt_empnamerole').val(data.d[0].EMPNAME);
                            $.each(data.d[0].Role, function (i, role) {
                                //   $('.TreeView1_0')[0].href.substring($('.TreeView1_0')[0].href.indexOf(",") + 3, $('.TreeView1_0')[0].href.length - 2)
                                $.each($('.TreeView1_0'), function (j, node) {
                                    //  console.log(j, node);
                                    var submenuId = node.href.substring(node.href.indexOf(",") + 3, node.href.length - 2)
                                    if (submenuId.includes("\\")) {
                                        submenuId = submenuId.split('\\')[submenuId.split('\\').length - 1];
                                    }

                                    // console.log(j, submenuId);
                                    if (role.SUBMENUID == submenuId) {
                                        //  console.log(submenuId, "true");
                                        //$(this).prop("checked", false);
                                        //$('#' + node.parentNode.children[0].id).attr("checked", "checked");
                                        PreviousSelected.push(submenuId);
                                        $('#' + node.parentNode.children[0].id).prop("checked", true);
                                    }
                                    var parentDIV = $(node).closest("DIV");
                                    //  console.log(parentDIV);
                                    if ($("input[type=checkbox]", parentDIV).length == $("input[type=checkbox]:checked", parentDIV).length) {
                                        //  $("input[type=checkbox]", parentDIV.prev()).attr("checked", "checked");
                                        $("input[type=checkbox]", parentDIV.prev()).prop("checked", true);
                                    }

                                });

                            });

                        }
                        else {
                            left(data.d[0].TXT);
                            $('#btn_roleupdate').hide();
                        }
                    }, error: function (err) {
                        console.log(err);
                    }

                });
            }
        }
        var currentSelected = [];
        function GetselectedNodes() {

            var selected = "";
            var unselected = "";
            var tree = document.getElementById("<%=TreeView1.ClientID%>");
            var checkboxes = tree.getElementsByTagName("INPUT");

            $.each($("[id*=TreeView1] input[type=checkbox]:checked"), function (i, checkedBox) {

                var text = checkedBox.nextSibling.innerHTML;
                //var value = checkboxes[i].title;
                var value = checkedBox.nextSibling.href.substring(checkedBox.nextSibling.href.indexOf(",") + 3, checkedBox.nextSibling.href.length - 2);
                // console.log(i, value);
                if (value.includes("\\")) {
                    value = value.split('\\')[value.split('\\').length - 1];
                    if (PreviousSelected.includes(value)) {
                        console.log("remove", value);
                        // PreviousSelected.pop(value);
                        PreviousSelected.remove(value);

                    } else {
                        currentSelected.push(value);
                    }
                }
            });
            var updatedRight = [];
            if (PreviousSelected.length > 0) {
                console.log("PreviousSelected", PreviousSelected.length);
                for (var i = 0; i < PreviousSelected.length; i++) {
                    updatedRight.push({ Status: 'INACTIVE', SubmenuId: PreviousSelected[i] })
                }

            }
            if (currentSelected.length > 0) {
                console.log("currentSelected", currentSelected.length);
                for (var i = 0; i < currentSelected.length; i++) {
                    updatedRight.push({ Status: 'ACTIVE', SubmenuId: currentSelected[i] })
                }
            }
            var empcode = $('#txt_empidrole').val();
            var updationuser = "";
            if (empcode == "") {
                left("First Fill Data");
            }
            else {
                $.ajax({

                    url: 'Admin.aspx/updaterole',

                    type: "POST",

                    dataType: "json",

                    data: JSON.stringify({ empcode: empcode, updationuser: updationuser, updatedRight: updatedRight }),

                    contentType: "application/json; charset=utf-8",

                    success: function (data) {
                        console.log(data.length);
                        if (data.d[0].MSG_CODE == 0) {
                            left(data.d[0].TXT);
                        }
                        else {
                            left(data.d[0].TXT);
                        }
                    }, error: function (err) {
                        console.log(err);
                    }

                });
            }






            return false;
        }

        Array.prototype.remove = function () {
            var what, a = arguments, L = a.length, ax;
            while (L && this.length) {
                what = a[--L];
                while ((ax = this.indexOf(what)) !== -1) {
                    this.splice(ax, 1);
                }
            }
            return this;
        };

    </script>
</asp:Content>

