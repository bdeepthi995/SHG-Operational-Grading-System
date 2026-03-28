<%@ page import="java.util.*" %>
<%
    String error = (String) request.getAttribute("error");
    if (error == null) {
        error = "An unknown error occurred. Please try again.";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Error - SHG Grading System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .error-card {
            border-radius: 20px;
            background: white;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="error-card p-4 text-center">
                    <div class="display-1">!</div>
                    <h2 class="text-danger">Error</h2>
                    <p class="lead"><%= error %></p>
                    <hr>
                    <a href="index.html" class="btn btn-primary btn-lg w-100">Try Again</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>