<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="testdropdown.aspx.cs" Inherits="testdropdown" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <link href="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.2/css/bootstrap.css" rel="stylesheet"/>
<link href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css" rel="stylesheet"/>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.2/js/bootstrap.js"></script>
<script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
<table id="example" class="display" cellspacing="0" width="100%">
  <thead>
    <tr>
      <th> ID</th>  
      <th> Modifier</th>  
      <th> Created Time</th> 
      <th> Modified Time</th> 
      <th> Edit</th> 
      <th> <div class="dropdown">
          <button id="dLabel" type="button" data-toggle="dropdown" 
                  aria-haspopup="true" aria-expanded="false">
            Dropdown trigger
            <span class="caret"></span>
          </button>
          <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
            <li><a href="#">Action</a></li>
            <li><a href="#">Another action</a></li>
          </ul>
        </div></th>  
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>100</td>
      <td>Admin</td>
      <td>10/06/2014</td>
      <td>11/02/2015</td>
      <td>
        <button type="button" class="btn btn-primary btn-sm">
          Edit
        </button>
      </td>      
      <td>
        asldkfj
      </td>
    </tr>
        <tr>
      <td>100</td>
      <td>Admin</td>
      <td>10/06/2014</td>
      <td>11/02/2015</td>
      <td>
        <button type="button" class="btn btn-primary btn-sm">
          Edit
        </button>
      </td>      
      <td>
        asldkfj
      </td>
    </tr>
        <tr>
      <td>100</td>
      <td>Admin</td>
      <td>10/06/2014</td>
      <td>11/02/2015</td>
      <td>
        <button type="button" class="btn btn-primary btn-sm">
          Edit
        </button>
      </td>      
      <td>
        asldkfj
      </td>
    </tr>
        <tr>
      <td>100</td>
      <td>Admin</td>
      <td>10/06/2014</td>
      <td>11/02/2015</td>
      <td>
        <button type="button" class="btn btn-primary btn-sm">
          Edit
        </button>
      </td>      
      <td>
        asldkfj
      </td>
    </tr>
        <tr>
      <td>100</td>
      <td>Admin</td>
      <td>10/06/2014</td>
      <td>11/02/2015</td>
      <td>
        <button type="button" class="btn btn-primary btn-sm">
          Edit
        </button>
      </td>      
      <td>
        asldkfj
      </td>
    </tr>
        <tr>
      <td>100</td>
      <td>Admin</td>
      <td>10/06/2014</td>
      <td>11/02/2015</td>
      <td>
        <button type="button" class="btn btn-primary btn-sm">
          Edit
        </button>
      </td>      
      <td>
        asldkfj
      </td>
    </tr>
        <tr>
      <td>100</td>
      <td>Admin</td>
      <td>10/06/2014</td>
      <td>11/02/2015</td>
      <td>
        <button type="button" class="btn btn-primary btn-sm">
          Edit
        </button>
      </td>      
      <td>
        asldkfj
      </td>
    </tr>
        <tr>
      <td>100</td>
      <td>Admin</td>
      <td>10/06/2014</td>
      <td>11/02/2015</td>
      <td>
        <button type="button" class="btn btn-primary btn-sm">
          Edit
        </button>
      </td>      
      <td>
        asldkfj
      </td>
    </tr>
        <tr>
      <td>100</td>
      <td>Admin</td>
      <td>10/06/2014</td>
      <td>11/02/2015</td>
      <td>
        <button type="button" class="btn btn-primary btn-sm">
          Edit
        </button>
      </td>      
      <td>
        asldkfj
      </td>
    </tr>
        <tr>
      <td>100</td>
      <td>Admin</td>
      <td>10/06/2014</td>
      <td>11/02/2015</td>
      <td>
        <button type="button" class="btn btn-primary btn-sm">
          Edit
        </button>
      </td>      
      <td>
        asldkfj
      </td>
    </tr>
        <tr>
      <td>100</td>
      <td>Admin</td>
      <td>10/06/2014</td>
      <td>11/02/2015</td>
      <td>
        <button type="button" class="btn btn-primary btn-sm">
          Edit
        </button>
      </td>      
      <td>
        asldkfj
      </td>
    </tr>
        <tr>
      <td>100</td>
      <td>Admin</td>
      <td>10/06/2014</td>
      <td>11/02/2015</td>
      <td>    
          Edit   
      </td>      
      <td>
        asldkfj
      </td>
    </tr>
    
    
  </tbody>                        
</table>
    <script>
        $(document).ready(function () {
            $('#example').DataTable({
                scrollY: "300px",
                scrollCollapse: true,
                paging: false,
                stripeClasses: [],
                targets: 'no-sort',
                bSort: false,
                order: [],
                searching: false,

                bInfo: false,
            });
        });
    </script>
</asp:Content>

