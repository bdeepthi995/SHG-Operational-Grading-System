<%@ page import="com.gqt.SHGModel, java.util.*" %>
<%
    SHGModel model = (SHGModel) session.getAttribute("model");
    if (model == null) {
        response.sendRedirect("index.html");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Repayment Results - SHG Grading System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .score-card {
            background: linear-gradient(135deg, #17a2b8, #138496);
            border-radius: 20px;
            padding: 30px;
            text-align: center;
            color: white;
        }
        .score-number {
            font-size: 48px;
            font-weight: bold;
        }
        .details-card {
            background: white;
            border-radius: 20px;
            padding: 20px;
            margin-top: 20px;
        }
        .loan-card {
            background: linear-gradient(135deg, #ffc107, #fd7e14);
            border-radius: 20px;
            padding: 20px;
            color: white;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="loan-card">
                    <h4>Loan Details</h4>
                    <div class="row">
                        <div class="col-md-4">
                            <strong>Loan Amount:</strong><br>
                            Rs <%= String.format("%.2f", model.getLoanAmount()) %>
                        </div>
                        <div class="col-md-4">
                            <strong>Interest Rate:</strong><br>
                            <%= model.getInterestRate() %>% 
                        </div>
                        <div class="col-md-4">
                            <strong>Total Payable:</strong><br>
                            Rs <%= String.format("%.2f", model.getTotalAmount()) %>
                        </div>
                    </div>
                    <div class="mt-3 text-center">
                        <strong>Monthly Payment per Member:</strong> Rs <%= String.format("%.2f", model.getMonthlyPerMember()) %>
                    </div>
                </div>
                
                <div class="score-card">
                    <h3>REPAYMENT SCORE</h3>
                    <div class="score-number"><%= String.format("%.2f", model.getRepaymentScore()) %> / 10</div>
                    <p class="mt-2">Excellent repayment discipline!</p>
                </div>
                
                <div class="details-card">
                    <h4 class="mb-3">Payment Summary</h4>
                    <table class="table table-bordered">
                        <tr>
                            <th>Total Members</th>
                            <td><%= model.getRepaymentTotal() %></td>
                        </tr>
                        <tr>
                            <th>Paid</th>
                            <td><%= model.getRepaymentPaid() %></td>
                        </tr>
                        <tr>
                            <th>Not Paid</th>
                            <td>
                                <%= model.getRepaymentMissed() %>
                                <% if(model.getRepaymentMissed().isEmpty()) { %>
                                    <span class="text-success">All members paid!</span>
                                <% } %>
                            </td>
                        </tr>
                        <tr>
                            <th>Time Taken</th>
                            <td><%= model.getRepaymentTimeTaken() %> seconds</td>
                        </tr>
                    </table>
                    
                    <h4 class="mt-4">Score Breakdown</h4>
                    <table class="table table-bordered">
                        <tr>
                            <th>Attendance Score</th>
                            <td><%= String.format("%.2f", ((double)model.getRepaymentPaid() / model.getRepaymentTotal()) * 7) %></td>
                        </tr>
                        <tr>
                            <th>Time Score</th>
                            <td><%= String.format("%.2f", ((60 - Math.min(model.getRepaymentTimeTaken(), 60)) / 60.0) * 3) %></td>
                        </tr>
                        <tr class="table-success">
                            <th>Total Score</th>
                            <th><%= String.format("%.2f", model.getRepaymentScore()) %> / 10</th>
                        </tr>
                    </table>
                    
                    <div class="d-grid gap-2 mt-4">
                        <a href="dashboard.jsp" class="btn btn-primary btn-lg">Back to Dashboard</a>
                        <a href="FinalGrade" class="btn btn-success btn-lg">View Final Grade</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>