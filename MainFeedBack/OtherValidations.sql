	<connectionStrings>
		<add name="MyConnectinString" connectionString="Data Source=DESKTOP-H3E2MN6;Initial Catalog=Trail2024;uid=TarunServer07; Password= Tarun@#07;" providerName="System.Data.SqlClient" />
	</connectionStrings>


//For getting int value in postive only no negative and no 0

<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
    ControlToValidate="TextBox1"
    ValidationExpression="^[1-9][0-9]*$"
    ErrorMessage="Value must be a positive integer"></asp:RegularExpressionValidator>
<asp:Button ID="Button1" runat="server" Text="Submit" />


//Stating date and end date validation
<asp:TextBox ID="TextBoxA" runat="server"></asp:TextBox>
<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
    ControlToValidate="TextBoxA"
    ErrorMessage="Start date is required"></asp:RequiredFieldValidator>
<asp:TextBox ID="TextBoxB" runat="server"></asp:TextBox>
<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
    ControlToValidate="TextBoxB"
    ErrorMessage="End date is required"></asp:RequiredFieldValidator>
<asp:CustomValidator ID="CustomValidator1" runat="server" 
    ControlToValidate="TextBoxB"
    ClientValidationFunction="ValidateEndDate"
    OnServerValidate="CustomValidator1_ServerValidate"
    ErrorMessage="End date cannot be before start date"></asp:CustomValidator>
<asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" />

<script type="text/javascript">
    function ValidateEndDate(sender, args) {
        var startDate = document.getElementById('<%= TextBoxA.ClientID %>').value;
        var endDate = document.getElementById('<%= TextBoxB.ClientID %>').value;

        if (new Date(endDate) >= new Date(startDate)) {
            args.IsValid = true;
        } else {
            args.IsValid = false;
        }
    }
</script>


protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
{
    DateTime startDate;
    DateTime endDate;

    if (DateTime.TryParse(TextBoxA.Text, out startDate) && DateTime.TryParse(TextBoxB.Text, out endDate))
    {
        if (endDate >= startDate)
        {
            args.IsValid = true;
            return;
        }
    }
    args.IsValid = false;
}

protected void Button1_Click(object sender, EventArgs e)
{
    if (Page.IsValid)
    {
        // Perform your logic here when the input is valid.
    }
}