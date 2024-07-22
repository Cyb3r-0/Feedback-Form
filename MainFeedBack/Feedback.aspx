<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Feedback.aspx.cs" Inherits="test.MainFeedBack.Feedback" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>FeedBack Form</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/jquery.validate.min.js"></script>
    <link href="Feedback.css" rel="stylesheet" />
    <script src="FeedbackJS.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="container">
                <div>
                    <asp:Label Text="FeedBack Form" Font-Bold="true" Font-Size="50px" CssClass="classForLblHeading" runat="server"></asp:Label>
                </div>
                <div class="form-group">
                    <asp:Label ID="lblCustumer" Text="Customer Name:" runat="server"></asp:Label>
                    <asp:TextBox ID="txtCustomerName" ValidationGroup="Add" runat="server" CssClass="form-control"></asp:TextBox>
                    <span id="SPnErrCustomerName" runat="server" style="color: red;"></span>
                    <asp:RequiredFieldValidator ID="rqCustumer" Style="color: red;" Display="Dynamic" ControlToValidate="txtCustomerName"
                        ErrorMessage="*Customer Name is required." ValidationGroup="Add" runat="server"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="regexCustomer" Style="color: red;" Display="Dynamic" ControlToValidate="txtCustomerName"
                        ValidationExpression="^.{3,100}$" ErrorMessage="*Customer Name should be between 3 and 100 characters." ValidationGroup="Add" runat="server"></asp:RegularExpressionValidator>

                </div>
                <div class="form-group">
                    <asp:Label ID="lblEmail" Text="Email:" runat="server"></asp:Label>
                    <asp:TextBox ID="txtEmail" ValidationGroup="Add" runat="server" CssClass="form-control"></asp:TextBox>
                    <span id="SPnErrEmail" runat="server" style="color: red;"></span>
                    <asp:RequiredFieldValidator ID="rqCustumerEmail" Style="color: red;" Display="Dynamic" ControlToValidate="txtEmail"
                        ErrorMessage="*Customer Name is required." ValidationGroup="Add" runat="server"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="rgEmail" Style="color: red;" runat="server" Display="Dynamic" ControlToValidate="txtEmail" ValidationGroup="Add" ErrorMessage="*Invalid email address format." ValidationExpression="\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b"></asp:RegularExpressionValidator>
                </div>
                <div class="form-group">
                    <asp:Label ID="lblRating" Text="Rating:" runat="server"></asp:Label>
                    <asp:TextBox ID="txtRating" ValidationGroup="Add" runat="server" CssClass="form-control"></asp:TextBox>
                    <span id="SPnErrRating" runat="server" style="color: red;"></span>
                    <asp:RequiredFieldValidator ID="rqRating" Style="color: red;" Display="Dynamic" ControlToValidate="txtRating"
                        ErrorMessage="*Rating is required." ValidationGroup="Add" runat="server"></asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="rvRating" Style="color: red;" Display="Dynamic" ControlToValidate="txtRating"
                        ErrorMessage="*Rating must be between 1 and 5." MinimumValue="1" MaximumValue="5" Type="Integer"
                        ValidationGroup="Add" runat="server"></asp:RangeValidator>
                </div>
                <div class="form-group">
                    <asp:Label ID="lblSubmittedDate" Text="Submitted Date" runat="server"></asp:Label>
                    <asp:TextBox ID="txtSubmittedDate" ValidationGroup="Add" runat="server" type="date" onchange="validateSubmittedDate()" CssClass="form-control"></asp:TextBox>
                    <span id="SPnErrSubmittedDate" style="color: red;" runat="server"></span>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Style="color: red;" Display="Dynamic" ControlToValidate="txtSubmittedDate"
                        ErrorMessage="*Submitted Date is required." ValidationGroup="Add" runat="server"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <asp:Label ID="lblComment" Text="Comment:" runat="server"></asp:Label>
                    <asp:TextBox ID="txtComment" ValidationGroup="Add" runat="server" MaxLength="500" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" Style="color: red;" Display="Dynamic" ControlToValidate="txtComment"
                        ErrorMessage="*Comments is required." ValidationGroup="Add" runat="server"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" Style="color: red;" Display="Dynamic" ControlToValidate="txtComment"
                        ValidationExpression="^[\s\S]{0,500}$" ErrorMessage="*Comment should not exceed 500 characters." ValidationGroup="Add" runat="server"></asp:RegularExpressionValidator>

                </div>
                <div class="go">
                    <asp:Button ID="btnSubmitted" OnClick="btnSubmitted_Click" OnClientClick="return validateALL();" Text="Submit" Width="50%" ValidationGroup="Add" runat="server" CssClass="form-control"></asp:Button>
                    <asp:Button ID="btnUpdate" OnClick="btnUpdate_Click" OnClientClick="return validateALL();" Visible="false" Text="Update" Width="50%" ValidationGroup="Add" runat="server" CssClass="form-control"></asp:Button>
                </div>
            </div>
        </div>
        <div class="Table feedbackdata">
            <h1>FeedBack Data</h1>
            <div class="grid-container table-responsive" id="repeaterGrid">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Feedback ID</th>
                            <th>Customer Name</th>
                            <th>Email</th>
                            <th>Comment</th>
                            <th>Rating</th>
                            <th>Submitted Date</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptFeedback" OnItemCommand="rptFeedback_ItemCommand" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td class="tda"><%# Eval("FeedbackID") %></td>
                                    <td class="tdb"><%# Eval("CustomerName") %></td>
                                    <td class="tda"><%# Eval("Email") %></td>
                                    <td class="comment-cell"><%# Eval("Comment") %></td>
                                    <td class="tda"><%# Eval("Rating") %></td>
                                    <td class="tdb"><%# Eval("SubmittedDate", "{0:yyyy-MM-dd}") %></td>
                                    <td>
                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CommandArgument='<%# Eval("FeedbackID") %>'>Edit</asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("FeedbackID") %>'>Delete</asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                    <tfoot class="pagenationClass">
                        <tr>
                            <td colspan="7">
                                <asp:Label ID="lblpagen" Text="Page Index: " runat="server"></asp:Label>
                                <asp:Repeater ID="rptPagination" OnItemCommand="rptPagination_ItemCommand" runat="server">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkPageIndex" runat="server" CommandName="Page" CommandArgument='<%# Container.DataItem %>'><%# Container.DataItem %></asp:LinkButton>
                                        &nbsp;
                   
                                    </ItemTemplate>
                                </asp:Repeater>
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="lstsearchOption">
                    <asp:Label ID="lblSearch" runat="server" Text="Search by Customer Name:"></asp:Label>
                    <asp:TextBox ID="txtSearchCustomerName" runat="server"></asp:TextBox>

                    <asp:Label ID="Label1" runat="server" Text=" And Rating:"></asp:Label>
                    <asp:DropDownList ID="ddlSearchRating" CssClass="dropdown" runat="server">
                        <asp:ListItem Text="   Select Rating   " Value=""></asp:ListItem>
                        <asp:ListItem Text="1" Value="1"></asp:ListItem>
                        <asp:ListItem Text="2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="3" Value="3"></asp:ListItem>
                        <asp:ListItem Text="4" Value="4"></asp:ListItem>
                        <asp:ListItem Text="5" Value="5"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="rptbutton Search">
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
        </div>
        <asp:HiddenField ID="hdnFeedbackID" runat="server" />
    </form>
</body>
</html>


