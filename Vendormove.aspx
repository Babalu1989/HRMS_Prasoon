<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="Vendormove.aspx.cs" Inherits="Vendormove" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .subject-info-box-1, .subject-info-box-2 {
            float: left;
            width: 45%;
        }

            .subject-info-box-1 select, .subject-info-box-2 select {
                height: 200px;
                padding: 0;
            }

                .subject-info-box-1 select option, .subject-info-box-2 select option {
                    padding: 4px 10px 4px 10px;
                }

                    .subject-info-box-1 select option:hover, .subject-info-box-2 select option:hover {
                        background: #eee;
                    }

        .subject-info-arrows {
            float: left;
            width: 10%;
            margin-top: 4%;
        }

            .subject-info-arrows input {
                width: 70%;
                margin-bottom: 5px;
            }
    </style>
    <div class="row">
        <span class="float-left" style="margin-top: 1%;">Division: &nbsp;&nbsp;</span>
        <div class="float-left" style="margin-top: 0%;">
            <asp:DropDownList runat="server" ID="ddl_div" CssClass="form-control" ClientIDMode="Static"></asp:DropDownList>
        </div>
        <span class="float-left" style="margin-top: 1%;">&nbsp;&nbsp;Sub-Division: &nbsp;&nbsp;</span>
        <div class="float-left" style="margin-top: 0%;">
            <asp:DropDownList runat="server" ID="ddl_subdivision" CssClass="form-control" ClientIDMode="Static">
                <asp:ListItem Value="" Text="--Select--"></asp:ListItem>
            </asp:DropDownList>
        </div>
        <span class="float-left" style="margin-top: 1%;">&nbsp;&nbsp;Vendor: &nbsp;&nbsp;</span>
        <div class="float-left" style="margin-top: 0%; width: 30%;">
            <asp:DropDownList runat="server" ID="ddl_vendor" CssClass="form-control" ClientIDMode="Static" Style="width: 100%;">
                <asp:ListItem Value="" Text="--Select--"></asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>
    <div class="clearfix"></div>
    <div class="row">
        <fieldset class="col-md-5">
            <legend>Employee List<label id="listcnt" style="color: green; margin-left: 30px"></label></legend>
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="">
                        <%--subject-info-box-1--%>
                        <select multiple="multiple" id='lstBox1' class="form-control">
                        </select>
                    </div>
                </div>
            </div>
        </fieldset>

        <div class="col-md-2 subject-info-arrows text-center">
            <input type='button' id='btnAllRight' value='>>' class="btn btn-default" /><br />
            <input type='button' id='btnRight' value='>' class="btn btn-default" /><br />
            <input type='button' id='btnLeft' value='<' class="btn btn-default" /><br />
            <input type='button' id='btnAllLeft' value='<<' class="btn btn-default" />
        </div>

        <fieldset class="col-md-5">
            <legend>To be Update Employee List</legend>
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="">
                        <%--subject-info-box-2--%>
                        <select multiple="multiple" id='lstBox2' class="form-control">
                        </select>
                    </div>
                </div>
            </div>
        </fieldset>
        <div class="clearfix"></div>
    </div>
    <style>
        label.btn span {
            font-size: 1.5em;
        }

        label input[type="radio"] ~ i.fa.fa-circle-o {
            color: #c8c8c8;
            display: inline;
        }

        label input[type="radio"] ~ i.fa.fa-dot-circle-o {
            display: none;
        }

        label input[type="radio"]:checked ~ i.fa.fa-circle-o {
            display: none;
        }

        label input[type="radio"]:checked ~ i.fa.fa-dot-circle-o {
            color: #7AA3CC;
            display: inline;
        }

        label:hover input[type="radio"] ~ i.fa {
            color: #7AA3CC;
        }

        label input[type="checkbox"] ~ i.fa.fa-square-o {
            color: #c8c8c8;
            display: inline;
        }

        label input[type="checkbox"] ~ i.fa.fa-check-square-o {
            display: none;
        }

        label input[type="checkbox"]:checked ~ i.fa.fa-square-o {
            display: none;
        }

        label input[type="checkbox"]:checked ~ i.fa.fa-check-square-o {
            color: #7AA3CC;
            display: inline;
        }

        label:hover input[type="checkbox"] ~ i.fa {
            color: #7AA3CC;
        }

        div[data-toggle="buttons"] label.active {
            color: #7AA3CC;
        }

        div[data-toggle="buttons"] label {
            display: inline-block;
            padding: 6px 12px;
            margin-bottom: 0;
            font-size: 14px;
            font-weight: normal;
            line-height: 2em;
            text-align: left;
            white-space: nowrap;
            vertical-align: top;
            cursor: pointer;
            background-color: none;
            border: 0px solid #c8c8c8;
            border-radius: 3px;
            color: #c8c8c8;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            -o-user-select: none;
            user-select: none;
        }

            div[data-toggle="buttons"] label:hover {
                color: #7AA3CC;
            }

            div[data-toggle="buttons"] label:active, div[data-toggle="buttons"] label.active {
                -webkit-box-shadow: none;
                box-shadow: none;
            }
    </style>
    <div class="row" style="margin-top: 2%">
        <div class="col-sm-2">
            <label class="btn active">
                <input type="radio" name='gender1' checked="checked" style="display: none" value="vendor" onclick="checkradiovaue();" /><i class="fa fa-circle-o fa-2x"></i><i class="fa fa-dot-circle-o fa-2x"></i> <span>Vendor</span>
            </label>
        </div>
        <div class="col-sm-7">
            <span class="float-left" style="margin-top: 1%;">Update Vendor: &nbsp;&nbsp;</span>
            <div class="float-left" style="margin-top: 0%;">
                <asp:DropDownList runat="server" ID="ddl_updatevendor" CssClass="form-control" ClientIDMode="Static" Style="width: 100%;">
                    <asp:ListItem Value="" Text="--Select--"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
        <div class="col-sm-3" style="margin-top: -2%;">
            <span class="float-left" style="margin-top: 1%;">Effective Date:</span><input class="form-control datetimepicker" type="text" required="required" data-error-msg="Effective Date Required" id="effectivedate" autocomplete="off" />
        </div>
    </div>
    <div class="row" style="margin-top: 2%">
        <div class="col-sm-2">
            <label class="btn">
                <input type="radio" name='gender1' style="display: none" value="Division" onclick="checkradiovaue();" /><i class="fa fa-circle-o fa-2x"></i><i class="fa fa-dot-circle-o fa-2x"></i><span> Division</span>
            </label>
        </div>
        <div class="col-sm-8">
            <span class="float-left" style="margin-top: 1%;">Update Division: &nbsp;&nbsp;</span>
            <div class="float-left" style="margin-top: 0%;">
                <asp:DropDownList runat="server" ID="ddl_update_div" CssClass="form-control" ClientIDMode="Static" disabled="disabled"></asp:DropDownList>
            </div>
            <span class="float-left" style="margin-top: 1%;">Update Sub-Division:</span>
            <div class="float-left" style="margin-top: 0%;">
                <asp:DropDownList runat="server" ID="ddl_update_subdiv" CssClass="form-control" ClientIDMode="Static" disabled="disabled">
                    <asp:ListItem Value="" Text="--Select--"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
        <div class="col-sm-2 float-left" style="margin-left: -3%;">
            <button class="btn btn-primary submit-btn float-left" onclick="functionupdate();return false;">Update</button>
        </div>
    </div>
    <div class="row" style="margin-top: 2%">
        <div class="col-sm-2">
            <label class="btn">
                <input type="radio" name='gender1' style="display: none" value="NOJ" onclick="checkradiovaue();" /><i class="fa fa-circle-o fa-2x"></i><i class="fa fa-dot-circle-o fa-2x"></i><span> NOJ</span>
            </label>
        </div>
        <div class="col-sm-7">
            <span class="float-left" style="margin-top: 1%;">Update Nature of job: &nbsp;&nbsp;</span>
            <div class="float-left" style="margin-top: 0%;">
                  <asp:DropDownList ID="ddl_noj" runat="server" class="form-control" ClientIDMode="Static" disabled="disabled"></asp:DropDownList>
            </div>
        </div>
    </div>
    <script>    
        function strDes(a, b) {
            if (a.value > b.value) return 1;
            else if (a.value < b.value) return -1;
            else return 0;
        }

        console.clear();
        (function () {
            $('#btnRight').click(function (e) {
                var selectedOpts = $('#lstBox1 option:selected');
                if (selectedOpts.length == 0) {
                    left("Nothing to move.");
                    e.preventDefault();
                }

                $('#lstBox2').append($(selectedOpts).clone());
                $(selectedOpts).remove();
                e.preventDefault();
            });

            $('#btnAllRight').click(function (e) {
                var selectedOpts = $('#lstBox1 option');
                if (selectedOpts.length == 0) {
                    left("Nothing to move.");
                    e.preventDefault();
                }

                $('#lstBox2').append($(selectedOpts).clone());
                $(selectedOpts).remove();
                e.preventDefault();
            });

            $('#btnLeft').click(function (e) {
                var selectedOpts = $('#lstBox2 option:selected');
                if (selectedOpts.length == 0) {
                    left("Nothing to move.");
                    e.preventDefault();
                }

                $('#lstBox1').append($(selectedOpts).clone());
                $(selectedOpts).remove();
                e.preventDefault();
            });

            $('#btnAllLeft').click(function (e) {
                var selectedOpts = $('#lstBox2 option');
                if (selectedOpts.length == 0) {
                    left("Nothing to move.");
                    e.preventDefault();
                }

                $('#lstBox1').append($(selectedOpts).clone());
                $(selectedOpts).remove();
                e.preventDefault();
            });
        }(jQuery));

        var ddlCountries;
        ddlCountries = document.getElementById("<%=ddl_subdivision.ClientID %>");
        $("#ddl_div").change(function () {
            ddlCountries.options.length = 0;
            AddOption("--Select--", "");
            $.ajax({
                type: "POST",
                url: "Vendormove.aspx/bindsubdiv",
                dataType: "json",
                data: JSON.stringify({ div: $("#ddl_div").val() }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var getvalue = eval(data.d);
                        console.log("getvalue", getvalue);
                        for (var i = 0; i < getvalue.length ; i++) {
                            AddOption(getvalue[i].SUB_DIV, getvalue[i].SUB_DIV_CODE);

                        }
                    }
                }
            });
        });

        function AddOption(text, value) {
            debugger;
            var option = document.createElement('option');
            option.value = value;
            option.innerHTML = text;
            ddlCountries.options.add(option);
        }

        var listitem;
        listitem = document.getElementById("lstBox1");
        $("#ddl_vendor").change(function () {
            listitem.options.length = 0;
            empdatalist();
        });
        $("#ddl_div").change(function () {
            listitem.options.length = 0;
            empdatalist();
        });
        $("#ddl_subdivision").change(function () {
            listitem.options.length = 0;
            empdatalist();
        });

        function empdatalist() {
            $.ajax({
                type: "POST",
                url: "Vendormove.aspx/oldemplist",
                dataType: "json",
                data: JSON.stringify({ div: $("#ddl_div").val(), subdiv: $("#ddl_subdivision").val(), ven: $("#ddl_vendor").val() }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var getvalue = eval(data.d);
                        console.log("getvalue", getvalue);
                        $('#listcnt')[0].textContent = "( " + getvalue.length + " )";
                        for (var i = 0; i < getvalue.length ; i++) {
                            AddOptionlist(getvalue[i].EMP_NM + " (" + getvalue[i].AADHAR + "," + getvalue[i].UIDNO + "," + getvalue[i].DIV_CODE + "," + getvalue[i].SUB_DIV + ")", getvalue[i].AADHAR);

                        }
                    }
                }
            });
        }
        function AddOptionlist(text, value) {
            debugger;
            var option = document.createElement('option');
            option.value = value;
            option.innerHTML = text;
            listitem.options.add(option);
        }


        function functionupdate() {
            if ($('#effectivedate').val() == "") { left("Effective Date Required!!!") } else {
                if ($("input[name='gender1']:checked").val() == "vendor") {
                    var updatedemplist = [];
                    for (cnt = 0; cnt < $('#lstBox2')[0].options.length; cnt++) {
                        updatedemplist.push({ typ: "8", aadhar: $('#lstBox2')[0].options[cnt].value, vendor: $('#ddl_updatevendor').val(), division: $('#ddl_update_div').val(), subivision: $('#ddl_update_subdiv').val(), effectivedate: $('#effectivedate').val() });
                    }
                    if ($('#effectivedate').val() == "") { left("Effective Date Required!!!") } else {
                        $.ajax({
                            type: "POST",
                            url: "Vendormove.aspx/updatelist",
                            dataType: "json",
                            data: JSON.stringify({ newlist: updatedemplist }),
                            contentType: "application/json",
                            success: function (data) {
                                if (data.d.length > 0) {
                                    var getvalue = eval(data.d);
                                    console.log("getvalue", getvalue);
                                    left(getvalue[0].TXT);
                                }
                            }
                        });
                    }
                }
                if ($("input[name='gender1']:checked").val() == "Division") {
                    var updatedemplist = [];
                    for (cnt = 0; cnt < $('#lstBox2')[0].options.length; cnt++) {
                        updatedemplist.push({ typ: "8A", aadhar: $('#lstBox2')[0].options[cnt].value, vendor: $('#ddl_updatevendor').val(), division: $('#ddl_update_div').val(), subivision: $('#ddl_update_subdiv').val(), effectivedate: $('#effectivedate').val() });
                    }
                    if ($('#effectivedate').val() == "") { left("Effective Date Required!!!") } else {
                        $.ajax({
                            type: "POST",
                            url: "Vendormove.aspx/updatelist",
                            dataType: "json",
                            data: JSON.stringify({ newlist: updatedemplist }),
                            contentType: "application/json",
                            success: function (data) {
                                if (data.d.length > 0) {
                                    var getvalue = eval(data.d);
                                    console.log("getvalue", getvalue);
                                    left(getvalue[0].TXT);
                                }
                            }
                        });
                    }
                }
                if ($("input[name='gender1']:checked").val() == "NOJ") {
                    var updatedemplist = [];
                    for (cnt = 0; cnt < $('#lstBox2')[0].options.length; cnt++) {
                        updatedemplist.push({ typ: "8C", aadhar: $('#lstBox2')[0].options[cnt].value, vendor: $('#ddl_noj').val(), division: $('#ddl_update_div').val(), subivision: $('#ddl_update_subdiv').val(), effectivedate: $('#effectivedate').val() });
                    }
                    if ($('#effectivedate').val() == "") { left("Effective Date Required!!!") } else {
                        $.ajax({
                            type: "POST",
                            url: "Vendormove.aspx/updatelist",
                            dataType: "json",
                            data: JSON.stringify({ newlist: updatedemplist }),
                            contentType: "application/json",
                            success: function (data) {
                                if (data.d.length > 0) {
                                    var getvalue = eval(data.d);
                                    console.log("getvalue", getvalue);
                                    left(getvalue[0].TXT);
                                }
                            }
                        });
                    }
                }
            }
        }
        function checkradiovaue() {
            if ($("input[name='gender1']:checked").val() == "Division") {
                $('#ddl_updatevendor').prop('disabled', true);
                $('#ddl_update_div').prop('disabled', false); $('#ddl_update_subdiv').prop('disabled', false); $('#ddl_noj').prop('disabled', true);
            } else if ($("input[name='gender1']:checked").val() == "vendor") {
                $('#ddl_updatevendor').prop('disabled', false); $('#ddl_update_div').prop('disabled', true); $('#ddl_update_subdiv').prop('disabled', true); $('#ddl_noj').prop('disabled', true);
            } else if ($("input[name='gender1']:checked").val() == "NOJ") {
                $('#ddl_updatevendor').prop('disabled', true); $('#ddl_update_div').prop('disabled', true); $('#ddl_update_subdiv').prop('disabled', true); $('#ddl_noj').prop('disabled', false);
            }
        }




        var ddl_update_subdiv;
        ddl_update_subdiv = document.getElementById("<%=ddl_update_subdiv.ClientID %>");
        $("#ddl_update_div").change(function () {
            ddl_update_subdiv.options.length = 0;
            AddOption("--Select--", "");
            $.ajax({
                type: "POST",
                url: "Vendormove.aspx/bindsubdiv",
                dataType: "json",
                data: JSON.stringify({ div: $("#ddl_update_div").val() }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var getvalue = eval(data.d);
                        console.log("getvalue", getvalue);
                        for (var i = 0; i < getvalue.length ; i++) {
                            AddOptionddl_update_subdiv(getvalue[i].SUB_DIV, getvalue[i].SUB_DIV_CODE);

                        }
                    }
                }
            });
        });

        function AddOptionddl_update_subdiv(text, value) {
            debugger;
            var option = document.createElement('option');
            option.value = value;
            option.innerHTML = text;
            ddl_update_subdiv.options.add(option);
        }

    </script>
</asp:Content>

