<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-sm-12">
            <table class="table table-striped custom-table datatable dataTable no-footer" id="DataTables_Table_0" role="grid" aria-describedby="DataTables_Table_0_info">
                <thead>
                    <tr role="row">
                        <th class="sorting_asc" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" style="width: 254px;">Name</th>
                        <th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Employee ID: activate to sort column ascending" style="width: 182px;">Employee ID</th>
                        <th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Email: activate to sort column ascending" style="width: 338px;">Email</th>
                        <th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Mobile: activate to sort column ascending" style="width: 122px;">Mobile</th>
                        <th class="text-nowrap sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Join Date: activate to sort column ascending" style="width: 146px;">Join Date</th>
                        <th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Role: activate to sort column ascending" style="width: 206px;">Role</th>
                        <th class="text-right no-sort sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Action: activate to sort column ascending" style="width: 109px;">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr role="row" class="odd">
                        <td class="sorting_1">
                            <h2 class="table-avatar">
                                <a href="profile.html" class="avatar">
                                    <img alt="" src="assets/img/profiles/avatar-13.jpg"></a>
                                <a href="profile.html">Bernardo Galaviz <span>Web Developer</span></a>
                            </h2>
                        </td>
                        <td>FT-0007</td>
                        <td>bernardogalaviz@example.com</td>
                        <td>9876543210</td>
                        <td>1 Jan 2013</td>
                        <td>
                            <div class="dropdown">
                                <a href="" class="btn btn-white btn-sm btn-rounded dropdown-toggle" data-toggle="dropdown" aria-expanded="false">Web Developer </a>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="#">Software Engineer</a>
                                    <a class="dropdown-item" href="#">Software Tester</a>
                                    <a class="dropdown-item" href="#">Frontend Developer</a>
                                    <a class="dropdown-item" href="#">UI/UX Developer</a>
                                </div>
                            </div>
                        </td>
                        <td class="text-right">
                            <div class="dropdown dropdown-action">
                                <a href="#" class="action-icon dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="material-icons">more_vert</i></a>
                                <div class="dropdown-menu dropdown-menu-right">
                                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#edit_employee"><i class="fa fa-pencil m-r-5"></i>Edit</a>
                                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#delete_employee"><i class="fa fa-trash-o m-r-5"></i>Delete</a>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr role="row" class="even">
                        <td class="sorting_1">
                            <h2 class="table-avatar">
                                <a href="profile.html" class="avatar">
                                    <img alt="" src="assets/img/profiles/avatar-12.jpg"></a>
                                <a href="profile.html">Jeffrey Warden <span>Web Developer</span></a>
                            </h2>
                        </td>
                        <td>FT-0006</td>
                        <td>jeffreywarden@example.com</td>
                        <td>9876543210</td>
                        <td>16 Jun 2013</td>
                        <td>
                            <div class="dropdown">
                                <a href="" class="btn btn-white btn-sm btn-rounded dropdown-toggle" data-toggle="dropdown" aria-expanded="false">Web Developer </a>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="#">Software Engineer</a>
                                    <a class="dropdown-item" href="#">Software Tester</a>
                                    <a class="dropdown-item" href="#">Frontend Developer</a>
                                    <a class="dropdown-item" href="#">UI/UX Developer</a>
                                </div>
                            </div>
                        </td>
                        <td class="text-right">
                            <div class="dropdown dropdown-action">
                                <a href="#" class="action-icon dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="material-icons">more_vert</i></a>
                                <div class="dropdown-menu dropdown-menu-right">
                                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#edit_employee"><i class="fa fa-pencil m-r-5"></i>Edit</a>
                                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#delete_employee"><i class="fa fa-trash-o m-r-5"></i>Delete</a>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr role="row" class="odd">
                        <td class="sorting_1">
                            <h2 class="table-avatar">
                                <a href="profile.html" class="avatar">
                                    <img alt="" src="assets/img/profiles/avatar-02.jpg"></a>
                                <a href="profile.html">John Doe <span>Web Designer</span></a>
                            </h2>
                        </td>
                        <td>FT-0001</td>
                        <td>johndoe@example.com</td>
                        <td>9876543210</td>
                        <td>1 Jan 2013</td>
                        <td>
                            <div class="dropdown">
                                <a href="" class="btn btn-white btn-sm btn-rounded dropdown-toggle" data-toggle="dropdown" aria-expanded="false">Web Developer </a>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="#">Software Engineer</a>
                                    <a class="dropdown-item" href="#">Software Tester</a>
                                    <a class="dropdown-item" href="#">Frontend Developer</a>
                                    <a class="dropdown-item" href="#">UI/UX Developer</a>
                                </div>
                            </div>
                        </td>
                        <td class="text-right">
                            <div class="dropdown dropdown-action">
                                <a href="#" class="action-icon dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="material-icons">more_vert</i></a>
                                <div class="dropdown-menu dropdown-menu-right">
                                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#edit_employee"><i class="fa fa-pencil m-r-5"></i>Edit</a>
                                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#delete_employee"><i class="fa fa-trash-o m-r-5"></i>Delete</a>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr role="row" class="even">
                        <td class="sorting_1">
                            <h2 class="table-avatar">
                                <a href="profile.html" class="avatar">
                                    <img alt="" src="assets/img/profiles/avatar-10.jpg"></a>
                                <a href="profile.html">John Smith <span>Android Developer</span></a>
                            </h2>
                        </td>
                        <td>FT-0003</td>
                        <td>johnsmith@example.com</td>
                        <td>9876543210</td>
                        <td>1 Apr 2014</td>
                        <td>
                            <div class="dropdown">
                                <a href="" class="btn btn-white btn-sm btn-rounded dropdown-toggle" data-toggle="dropdown" aria-expanded="false">Web Developer </a>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="#">Software Engineer</a>
                                    <a class="dropdown-item" href="#">Software Tester</a>
                                    <a class="dropdown-item" href="#">Frontend Developer</a>
                                    <a class="dropdown-item" href="#">UI/UX Developer</a>
                                </div>
                            </div>
                        </td>
                        <td class="text-right">
                            <div class="dropdown dropdown-action">
                                <a href="#" class="action-icon dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="material-icons">more_vert</i></a>
                                <div class="dropdown-menu dropdown-menu-right">
                                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#edit_employee"><i class="fa fa-pencil m-r-5"></i>Edit</a>
                                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#delete_employee"><i class="fa fa-trash-o m-r-5"></i>Delete</a>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr role="row" class="odd">
                        <td class="sorting_1">
                            <h2 class="table-avatar">
                                <a href="profile.html" class="avatar">
                                    <img alt="" src="assets/img/profiles/avatar-05.jpg"></a>
                                <a href="profile.html">Mike Litorus <span>IOS Developer</span></a>
                            </h2>
                        </td>
                        <td>FT-0004</td>
                        <td>mikelitorus@example.com</td>
                        <td>9876543210</td>
                        <td>1 Apr 2014</td>
                        <td>
                            <div class="dropdown">
                                <a href="" class="btn btn-white btn-sm btn-rounded dropdown-toggle" data-toggle="dropdown" aria-expanded="false">Web Developer </a>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="#">Software Engineer</a>
                                    <a class="dropdown-item" href="#">Software Tester</a>
                                    <a class="dropdown-item" href="#">Frontend Developer</a>
                                    <a class="dropdown-item" href="#">UI/UX Developer</a>
                                </div>
                            </div>
                        </td>
                        <td class="text-right">
                            <div class="dropdown dropdown-action">
                                <a href="#" class="action-icon dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="material-icons">more_vert</i></a>
                                <div class="dropdown-menu dropdown-menu-right">
                                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#edit_employee"><i class="fa fa-pencil m-r-5"></i>Edit</a>
                                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#delete_employee"><i class="fa fa-trash-o m-r-5"></i>Delete</a>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr role="row" class="even">
                        <td class="sorting_1">
                            <h2 class="table-avatar">
                                <a href="profile.html" class="avatar">
                                    <img alt="" src="assets/img/profiles/avatar-09.jpg"></a>
                                <a href="profile.html">Richard Miles <span>Web Developer</span></a>
                            </h2>
                        </td>
                        <td>FT-0002</td>
                        <td>richardmiles@example.com</td>
                        <td>9876543210</td>
                        <td>18 Mar 2014</td>
                        <td>
                            <div class="dropdown">
                                <a href="" class="btn btn-white btn-sm btn-rounded dropdown-toggle" data-toggle="dropdown" aria-expanded="false">Web Developer </a>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="#">Software Engineer</a>
                                    <a class="dropdown-item" href="#">Software Tester</a>
                                    <a class="dropdown-item" href="#">Frontend Developer</a>
                                    <a class="dropdown-item" href="#">UI/UX Developer</a>
                                </div>
                            </div>
                        </td>
                        <td class="text-right">
                            <div class="dropdown dropdown-action">
                                <a href="#" class="action-icon dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="material-icons">more_vert</i></a>
                                <div class="dropdown-menu dropdown-menu-right">
                                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#edit_employee"><i class="fa fa-pencil m-r-5"></i>Edit</a>
                                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#delete_employee"><i class="fa fa-trash-o m-r-5"></i>Delete</a>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr role="row" class="odd">
                        <td class="sorting_1">
                            <h2 class="table-avatar">
                                <a href="profile.html" class="avatar">
                                    <img alt="" src="assets/img/profiles/avatar-11.jpg"></a>
                                <a href="profile.html">Wilmer Deluna <span>Team Leader</span></a>
                            </h2>
                        </td>
                        <td>FT-0005</td>
                        <td>wilmerdeluna@example.com</td>
                        <td>9876543210</td>
                        <td>22 May 2014</td>
                        <td>
                            <div class="dropdown">
                                <a href="" class="btn btn-white btn-sm btn-rounded dropdown-toggle" data-toggle="dropdown" aria-expanded="false">Web Developer </a>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="#">Software Engineer</a>
                                    <a class="dropdown-item" href="#">Software Tester</a>
                                    <a class="dropdown-item" href="#">Frontend Developer</a>
                                    <a class="dropdown-item" href="#">UI/UX Developer</a>
                                </div>
                            </div>
                        </td>
                        <td class="text-right">
                            <div class="dropdown dropdown-action">
                                <a href="#" class="action-icon dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="material-icons">more_vert</i></a>
                                <div class="dropdown-menu dropdown-menu-right">
                                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#edit_employee"><i class="fa fa-pencil m-r-5"></i>Edit</a>
                                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#delete_employee"><i class="fa fa-trash-o m-r-5"></i>Delete</a>
                                </div>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>


     <!-- Edit Employee Modal -->
    <div id="edit_employee" class="modal custom-modal fade" role="dialog">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Employee</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-form-label">First Name <span class="text-danger">*</span></label>
                                    <input class="form-control" value="John" type="text">
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-form-label">Last Name</label>
                                    <input class="form-control" value="Doe" type="text">
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-form-label">Username <span class="text-danger">*</span></label>
                                    <input class="form-control" value="johndoe" type="text">
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-form-label">Email <span class="text-danger">*</span></label>
                                    <input class="form-control" value="johndoe@example.com" type="email">
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-form-label">Password</label>
                                    <input class="form-control" value="johndoe" type="password">
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-form-label">Confirm Password</label>
                                    <input class="form-control" value="johndoe" type="password">
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-form-label">Employee ID <span class="text-danger">*</span></label>
                                    <input type="text" value="FT-0001" readonly class="form-control floating">
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-form-label">Joining Date <span class="text-danger">*</span></label>
                                    <div class="cal-icon">
                                        <input class="form-control datetimepicker" type="text">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-form-label">Phone </label>
                                    <input class="form-control" value="9876543210" type="text">
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-form-label">Company</label>
                                    <select class="select">
                                        <option>Global Technologies</option>
                                        <option>Delta Infotech</option>
                                        <option selected>International Software Inc</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Department <span class="text-danger">*</span></label>
                                    <select class="select">
                                        <option>Select Department</option>
                                        <option>Web Development</option>
                                        <option>IT Management</option>
                                        <option>Marketing</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Designation <span class="text-danger">*</span></label>
                                    <select class="select">
                                        <option>Select Designation</option>
                                        <option>Web Designer</option>
                                        <option>Web Developer</option>
                                        <option>Android Developer</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="table-responsive m-t-15">
                            <table class="table table-striped custom-table">
                                <thead>
                                    <tr>
                                        <th>Module Permission</th>
                                        <th class="text-center">Read</th>
                                        <th class="text-center">Write</th>
                                        <th class="text-center">Create</th>
                                        <th class="text-center">Delete</th>
                                        <th class="text-center">Import</th>
                                        <th class="text-center">Export</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Holidays</td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Leaves</td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Clients</td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Projects</td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Tasks</td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Chats</td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Assets</td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Timing Sheets</td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input checked="" type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                        <td class="text-center">
                                            <input type="checkbox">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="submit-section">
                            <button class="btn btn-primary submit-btn">Save</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- /Edit Employee Modal -->

</asp:Content>

