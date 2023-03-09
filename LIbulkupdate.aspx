<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="LIbulkupdate.aspx.cs" Inherits="LIbulkupdate" %>

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
    <!--
  Blog entry: https://esausilva.com/2016/01/29/move-items-between-two-listbox-using-jquery-html-select-tag/

  I recommend using my plug in instead: https://esausilva.com/2016/02/28/jquery-selectlistactions-js-plugin-to-move-items-between-two-select-lists-remove-select-list-items-and-move-up-and-down-select-list-items/
-->
    <div class="row">
        <span class="float-left" style="margin-top: 1%;">&nbsp;&nbsp;Reporting Officer: &nbsp;&nbsp;</span>
        <div class="float-left" style="margin-top: 0%; width: 30%;">
            <asp:DropDownList runat="server" ID="ddl_li" CssClass="form-control" ClientIDMode="Static" Style="width: 100%;">
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
        <div class="col-md-5">
            <span class="float-left" style="margin-top: 1%;">Update Reporting Officer: &nbsp;&nbsp;</span>
            <div class="float-left" style="margin-top: 0%;">
                <asp:DropDownList runat="server" ID="ddl_updateLI" CssClass="form-control" ClientIDMode="Static" Style="width: 100%;">
                    <asp:ListItem Value="" Text="--Select--"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
        <div class="col-md-4">         
            <span class="float-left" style="margin-top: 1%;">Effective Date: &nbsp;&nbsp;</span>
            <div class="float-left" style="margin-top: 0%;">
                <input class="form-control datetimepicker" type="text" required="required" data-error-msg="Effective Date Required" id="effectivedate" autocomplete="off" />
            </div>
        </div>
        <div class="col-md-3 float-left">
            <button class="btn btn-primary submit-btn float-left" onclick="functionupdate();return false;">Update</button>
        </div>
    </div>
    <script>
        /*
 * Original example found here: http://www.jquerybyexample.net/2012/05/how-to-move-items-between-listbox-using.html
 * Modified by Esau Silva to support 'Move ALL items to left/right' and add better stylingon on Jan 28, 2016.
 * 
 */
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

                /* -- Uncomment for optional sorting --
                var box2Options = $('#lstBox2 option');
                var box2OptionsSorted;
                box2OptionsSorted = box2Options.toArray().sort(strDes);
                $('#lstBox2').empty();
                box2OptionsSorted.forEach(function(opt){
                  $('#lstBox2').append(opt);
                })
                */

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


        var listitem;
        listitem = document.getElementById("lstBox1");
        $("#ddl_li").change(function () {
            listitem.options.length = 0;
            empdatalist();
        });

        function empdatalist() {
            $.ajax({
                type: "POST",
                url: "LIbulkupdate.aspx/oldemplist",
                dataType: "json",
                data: JSON.stringify({ report: $("#ddl_li").val() }),
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
            if ($('#ddl_updateLI').val() == "0") {
                left("Update Reporting Officer Should be Selected!!!");
            } else {
                var updatedemplist = [];
                if ($('#effectivedate').val() == "") { left("Effective Date Required!!!") } else {
                for (cnt = 0; cnt < $('#lstBox2')[0].options.length; cnt++) {
                    updatedemplist.push({ typ: "8B", aadhar: $('#lstBox2')[0].options[cnt].value, updateli: $('#ddl_updateLI').val(), effectivedate: $('#effectivedate').val() });
                }              
                    $.ajax({
                        type: "POST",
                        url: "LIbulkupdate.aspx/updatelist",
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
    </script>
</asp:Content>

