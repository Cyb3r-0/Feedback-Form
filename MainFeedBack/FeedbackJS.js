$.noConflict();
jQuery(document).ready(function ($) {
    $('#form1').validate({
    });
});
$(document).ready(function () {
    $('#form1').validate({
        rules: {
            txtCustomerName: {
                required: true,
                minlength: 3,
                maxlength: 100
            },
            txtComment: {
                required: true,
                maxlength: 500
            }
        },
        messages: {
            txtCustomerName: {
                required: "Customer Name is required.",
                minlength: "Customer Name should be at least 3 characters.",
                maxlength: "Customer Name should not exceed 100 characters."
            },
            txtComment: {
                required: "Comment is required.",
                maxlength: "Comment should not exceed 500 characters."
            }
        },
        submitHandler: function (form) {
            $.ajax({
                url: 'Feedback.aspx/SaveData',
                type: 'POST',
                data: $(form).serialize(),
                success: function (response) {
                    console.log('Data saved successfully:', response);
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        }
    });
});
function validateSubmittedDate() {
    var isValid = true;
    var submittedDate = document.getElementById('<%= txtSubmittedDate.ClientID %>').value;
    var ErrorMessageSubmittedDate = "";
    if (submittedDate === "") {
        ErrorMessageSubmittedDate = "Submitted Date is required.";
    } else {
        var today = new Date();
        var selectedDate = new Date(submittedDate);
        if (selectedDate > today) {
            ErrorMessageSubmittedDate = "Future dates are not allowed.";
            document.getElementById('<%= txtSubmittedDate.ClientID %>').value = '';
        }
    }
    var SPnErrSubmittedDate = document.getElementById('<%= SPnErrSubmittedDate.ClientID %>');
    if (SPnErrSubmittedDate) {
        SPnErrSubmittedDate.innerText = ErrorMessageSubmittedDate;
        SPnErrSubmittedDate.style.display = ErrorMessageSubmittedDate ? 'inline' : 'none';
    }
    isValid = isValid && ErrorMessageSubmittedDate === "";
    return isValid;
}
function validateForm() {
    validateSubmittedDate();
    var SPnErrCustomerName = document.getElementById('<%= SPnErrCustomerName.ClientID %>');
    if (SPnErrCustomerName) {
        SPnErrCustomerName.innerText = ErrorMessageCustomerName;
        SPnErrCustomerName.style.display = ErrorMessageCustomerName ? 'inline' : 'none';
    }
    isValid = isValid && ErrorMessageCustomerName === "";

    return isValid;
}
//$(document).ready(function () {
//    $('#btnUpdate').click(function () {
//        updateFeedback();
//    });
//
//    function updateFeedback() {
//        alert("updateFeedback");
//        var feedbackID = $('#hdnFeedbackID').val();
//        var customerName = $('#txtCustomerName').val();
//        var email = $('#txtEmail').val();
//        var comment = $('#txtComment').val();
//        var rating = $('#txtRating').val();
//        var submittedDate = $('#txtSubmittedDate').val();
//
//        $.ajax({
//            type: 'POST',
//            url: 'Feedback.aspx/UpdateFeedback', 
//            contentType: 'application/json; charset=utf-8',
//            data: JSON.stringify({
//                feedbackID: feedbackID,
//                customerName: customerName,
//                email: email,
//                comment: comment,
//                rating: rating,
//                submittedDate: submittedDate
//            }),
//            dataType: 'json',
//            success: function (response) {
//                console.log(response.d);
//                alert('Feedback updated successfully.');
//            },
//            error: function (error) {
//                console.log(error);
//                alert('Error updating feedback.');
//            }
//        });
//    }
//});
