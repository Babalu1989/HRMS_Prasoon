<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="Message.aspx.cs" Inherits="Message" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        $(function () {
            if ($.cookie("name") != null && $.cookie("designation") != null) {
                $("#boldname").text($.cookie("name")); $("#name").text($.cookie("name"));
                $("#designation").text($.cookie("designation"));
                $("#dob").text($.cookie("dob"));
                $("#mail").text($.cookie("email"));
                $("#hdnaadhar").val($.cookie("aadhar"));
                $("#hdnmobile").val($.cookie("phone"));
                document.getElementById("profile").src = $.cookie("img");
                $("#phone").text($.cookie("phone"));
                $.removeCookie("name");
                $.removeCookie("designation");
                $.removeCookie("dob");
                $.removeCookie("phone");
            }
        });
    </script>
    <input type="hidden" id="hdnaadhar" />
    <input type="hidden" id="hdnmobile"/>
    <div class="row">
        <!-- Chat Main Row -->
        <div class="chat-main-row">

            <!-- Chat Main Wrapper -->
            <div class="chat-main-wrapper"> 
                <!-- Chats View -->
                <div class="col-lg-9 message-view task-view">
                    <div class="chat-window">
                        <div class="chat-contents">
                            <div class="chat-content-wrap" style="margin-top: 60px;">
                                <div class="chat-wrap-inner">
                                    <div class="chat-box">                                         
                                        <div class="chats" id="chats">
                                            <h4 class="page-title"><a href="AllEmployee" class="btn btn-xs btn-link btn-toggle-fullwidth"><i class="fa fa-arrow-left"></i></a>Messages</h4>
                                            <%--	<div class="chat chat-right">
														<div class="chat-body">
															<div class="chat-bubble">
																<div class="chat-content">
																	<p>Hello. What can I do for you?</p>
																	<span class="chat-time">8:30 am</span>
																</div>															
															</div>
														</div>
													</div>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="chat-footer">
                            <div class="message-bar">
                                <div class="message-inner">
                                    <a class="link attach-icon" href="#" data-toggle="modal" data-target="#drag_files">
                                        <img src="assets/img/attachment.png" alt=""></a>
                                    <div class="message-area">
                                        <div class="input-group">
                                            <textarea class="form-control" placeholder="Type message..." id="txttypemessage"></textarea>
                                            <span class="input-group-append"  onclick="functionsmssend();">
                                                <a class="btn btn-custom"><i class="fa fa-send"></i></a>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /Chats View -->

                <!-- Chat Right Sidebar -->
                <div class="col-lg-3 message-view chat-profile-view chat-sidebar" id="task_window">
                    <div class="chat-window video-window">
                        <div class="fixed-header">
                            <ul class="nav nav-tabs nav-tabs-bottom">
                                <li class="nav-item"><a class="nav-link" href="#calls_tab" data-toggle="tab">Calls</a></li>
                                <li class="nav-item"><a class="nav-link active" href="#profile_tab" data-toggle="tab">Profile</a></li>
                            </ul>
                        </div>
                        <div class="tab-content chat-contents">
                            <div class="content-full tab-pane" id="calls_tab">
                                <div class="chat-wrap-inner">
                                    <div class="chat-box">
                                        <div class="chats">
                                            <div class="chat chat-left">
                                                <div class="chat-avatar">
                                                    <a href="profile.html" class="avatar">
                                                        <img alt="" src="assets/img/profiles/avatar-02.jpg">
                                                    </a>
                                                </div>
                                                <div class="chat-body">
                                                    <div class="chat-bubble">
                                                        <div class="chat-content">
                                                            <span class="task-chat-user">You</span> <span class="chat-time">8:35 am</span>
                                                            <div class="call-details">
                                                                <i class="material-icons">phone_missed</i>
                                                                <div class="call-info">
                                                                    <div class="call-user-details">
                                                                        <span class="call-description">Jeffrey Warden missed the call</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="chat chat-left">
                                                <div class="chat-avatar">
                                                    <a href="profile.html" class="avatar">
                                                        <img alt="" src="assets/img/profiles/avatar-02.jpg">
                                                    </a>
                                                </div>
                                                <div class="chat-body">
                                                    <div class="chat-bubble">
                                                        <div class="chat-content">
                                                            <span class="task-chat-user">John Doe</span> <span class="chat-time">8:35 am</span>
                                                            <div class="call-details">
                                                                <i class="material-icons">call_end</i>
                                                                <div class="call-info">
                                                                    <div class="call-user-details"><span class="call-description">This call has ended</span></div>
                                                                    <div class="call-timing">Duration: <strong>5 min 57 sec</strong></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="chat-line">
                                                <span class="chat-date">January 29th, 2019</span>
                                            </div>
                                            <div class="chat chat-left">
                                                <div class="chat-avatar">
                                                    <a href="profile.html" class="avatar">
                                                        <img alt="" src="assets/img/profiles/avatar-05.jpg">
                                                    </a>
                                                </div>
                                                <div class="chat-body">
                                                    <div class="chat-bubble">
                                                        <div class="chat-content">
                                                            <span class="task-chat-user">Richard Miles</span> <span class="chat-time">8:35 am</span>
                                                            <div class="call-details">
                                                                <i class="material-icons">phone_missed</i>
                                                                <div class="call-info">
                                                                    <div class="call-user-details">
                                                                        <span class="call-description">You missed the call</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="chat chat-left">
                                                <div class="chat-avatar">
                                                    <a href="profile.html" class="avatar">
                                                        <img alt="" src="assets/img/profiles/avatar-02.jpg">
                                                    </a>
                                                </div>
                                                <div class="chat-body">
                                                    <div class="chat-bubble">
                                                        <div class="chat-content">
                                                            <span class="task-chat-user">You</span> <span class="chat-time">8:35 am</span>
                                                            <div class="call-details">
                                                                <i class="material-icons">ring_volume</i>
                                                                <div class="call-info">
                                                                    <div class="call-user-details">
                                                                        <a href="#" class="call-description call-description--linked" data-qa="call_attachment_link">Calling John Smith ...</a>
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
                            </div>
                            <div class="content-full tab-pane show active" id="profile_tab">
                                <div class="display-table">
                                    <div class="table-row">
                                        <div class="table-body">
                                            <div class="table-content">
                                                <div class="chat-profile-img">
                                                    <%--<div class="edit-profile-img">																
																<%--<span class="change-img" >Change Image</span>
                                                                                                                      
															</div>--%>
                                                    <img id="profile" class="profile-img" alt="" />
                                                    <h3 class="user-name m-t-10 mb-0"><span id="boldname"></span></h3>
                                                    <small class="text-muted"><span id="designation"></span></small>
                                                </div>
                                                <div class="chat-profile-info">
                                                    <ul class="user-det-list">
                                                        <li>
                                                            <span>Employee Name:</span>
                                                            <span class="float-right text-muted" id="name"></span>
                                                        </li>
                                                        <li>
                                                            <span>DOB:</span>
                                                            <span class="float-right text-muted" id="dob"></span>
                                                        </li>
                                                        <li>
                                                            <span>Email:</span>
                                                            <span class="float-right" id="mail" style="color: blue"></span>
                                                        </li>
                                                        <li>
                                                            <span>Phone:</span>
                                                            <span class="float-right text-muted" id="phone"></span>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /Chat Right Sidebar -->

            </div>
            <!-- /Chat Main Wrapper -->

        </div>
        <!-- /Chat Main Row -->
    </div>
    <script>
        $(document).ready(function () {
            messagedata();
        });
        function messagedata() {
            debugger;
            $.ajax({
                type: "POST",
                url: "Message.aspx/chatmessage",
                dataType: "json",
                data: JSON.stringify({ empcode: $('#hdnaadhar').val(), type: "7A" }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var getvalue = eval(data.d);                        
                        if (getvalue.length > 0) {
                            debugger;
                            var messagevlaue = '';                            
                            if (getvalue[0][0].MSG_CODE == "1") {
                                //messagevlaue += ' <div class="chat chat-right"><div class="chat-body"><div class="chat-bubble"><div class="chat-content">';
                                //messagevlaue += '<p>' + getvalue[0][0].TXT + '</p><span class="chat-time"></span>';
                                //messagevlaue += '</div>';
                                //messagevlaue += '</div>';
                                //messagevlaue += '</div></div>';
                            } else {
                                if (getvalue[0].length == "1") {
                                    messagevlaue += ' <div class="chat chat-right"><div class="chat-body"><div class="chat-bubble"><div class="chat-content">';
                                    if (getvalue[0][0].STATUS == "0") {
                                        messagevlaue += '<p>' + getvalue[0][0].MESSAGE + '</p><span class="chat-time">' + getvalue[0][0].REQUESTDATE + '</span><i class="fa fa-check text-success"></i></span>';
                                    } else {
                                        messagevlaue += '<p>' + getvalue[0][0].MESSAGE + '</p><span class="chat-time">' + getvalue[0][0].REQUESTDATE + '</span><i class="fa fa-check text-success"></i><i class="fa fa-check text-success"></i></span>';
                                    }
                                    messagevlaue += '</div>';
                                    messagevlaue += '</div>';
                                    messagevlaue += '</div></div>';

                                } else {
                                    for (z = 0; z < getvalue[0].length; z++) {
                                        messagevlaue += ' <div class="chat chat-right"><div class="chat-body"><div class="chat-bubble"><div class="chat-content">';
                                        if (getvalue[0][z].STATUS == "0") {
                                            messagevlaue += '<p>' + getvalue[0][z].MESSAGE + '</p><span class="chat-time">' + getvalue[0][z].REQUESTDATE + '</span><i class="fa fa-check text-success"></i></span>';
                                        } else {
                                            messagevlaue += '<p>' + getvalue[0][z].MESSAGE + '</p><span class="chat-time">' + getvalue[0][z].REQUESTDATE + '</span><i class="fa fa-check text-success"></i><i class="fa fa-check text-success"></i></span>';
                                        }
                                        messagevlaue += '</div>';
                                        messagevlaue += '</div>';
                                        messagevlaue += '</div></div>';
                                    }
                                }
                            }
                            $('#chats').append(messagevlaue);
                        }

                    }
                }
            });
        }

        function functionsmssend() {
            $.ajax({
                type: "POST",
                url: "Message.aspx/smssend",
                dataType: "json",
                data: JSON.stringify({ empcode: $('#hdnaadhar').val(), type: "7", mobile: $('#hdnmobile').val(),message:$('#txttypemessage').val() }),
                contentType: "application/json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var response = eval(data.d);
                        console.log("response", response);
                        alert(response[0][0].TXT);
                    }
                }
            });
        }
    </script>
</asp:Content>

