<%@ page import="com.gqt.SHGModel" %>
<%
    SHGModel model = (SHGModel) session.getAttribute("model");
    if (model == null) {
        response.sendRedirect("index.html");
        return;
    }
    
    String gradeColor = "";
    if (model.getGrade().equals("A")) gradeColor = "success";
    else if (model.getGrade().equals("B")) gradeColor = "info";
    else if (model.getGrade().equals("C")) gradeColor = "warning";
    else gradeColor = "danger";
%>
<!DOCTYPE html>
<html>
<head>
    <title>Final Grade - SHG Grading System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .grade-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            text-align: center;
            margin-bottom: 20px;
        }
        .grade-letter {
            font-size: 80px;
            font-weight: bold;
            padding: 20px;
            border-radius: 50%;
            display: inline-block;
            width: 150px;
            height: 150px;
            line-height: 110px;
        }
        .grade-success { background: linear-gradient(135deg, #28a745, #20c997); color: white; }
        .grade-info { background: linear-gradient(135deg, #17a2b8, #138496); color: white; }
        .grade-warning { background: linear-gradient(135deg, #ffc107, #fd7e14); color: white; }
        .grade-danger { background: linear-gradient(135deg, #dc3545, #c82333); color: white; }
        .score-number {
            font-size: 48px;
            font-weight: bold;
        }
        .details-card {
            background: white;
            border-radius: 20px;
            padding: 20px;
        }
        .progress {
            height: 30px;
            border-radius: 15px;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="grade-card">
                    <h2>FINAL GRADE</h2>
                    <div class="grade-letter grade-<%= gradeColor %>">
                        <%= model.getGrade() %>
                    </div>
                    <div class="score-number mt-3">
                        <%= String.format("%.2f", model.getFinalScore()) %> / 10
                    </div>
                    <p class="mt-2">
                        <% if(model.getGrade().equals("A")) { %>
                            Excellent Performance! Keep up the great work!
                        <% } else if(model.getGrade().equals("B")) { %>
                            Good Performance! Room for improvement!
                        <% } else if(model.getGrade().equals("C")) { %>
                            Average Performance. Need more participation!
                        <% } else { %>
                            Needs Improvement. Focus on attendance and repayment!
                        <% } %>
                    </p>
                </div>
                
                <div class="details-card">
                    <h4 class="mb-3">Performance Breakdown</h4>
                    
                    <div class="mb-3">
                        <label>Meeting Score: <%= String.format("%.2f", model.getMeetingScore()) %> / 10</label>
                        <div class="progress">
                            <div class="progress-bar bg-success" style="width: <%= (model.getMeetingScore() / 10) * 100 %>%">
                                <%= String.format("%.0f", (model.getMeetingScore() / 10) * 100) %>% 
                            </div>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label>Repayment Score: <%= String.format("%.2f", model.getRepaymentScore()) %> / 10</label>
                        <div class="progress">
                            <div class="progress-bar bg-info" style="width: <%= (model.getRepaymentScore() / 10) * 100 %>%">
                                <%= String.format("%.0f", (model.getRepaymentScore() / 10) * 100) %>% 
                            </div>
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <label>Final Score: <%= String.format("%.2f", model.getFinalScore()) %> / 10</label>
                        <div class="progress">
                            <div class="progress-bar bg-warning" style="width: <%= (model.getFinalScore() / 10) * 100 %>%">
                                <%= String.format("%.0f", (model.getFinalScore() / 10) * 100) %>% 
                            </div>
                        </div>
                    </div>
                    
                    <table class="table table-bordered">
                        <tr>
                            <th>Group Name</th>
                            <td><%= model.getGroupName() %></td>
                        </tr>
                        <tr>
                            <th>Group ID</th>
                            <td><%= model.getGroupId() %></td>
                        </tr>
                        <tr>
                            <th>Leader</th>
                            <td><%= model.getLeader() %></td>
                        </tr>
                        <tr>
                            <th>Meeting Attendance</th>
                            <td><%= model.getMeetingAttended() %>/<%= model.getMeetingTotal() %> members</td>
                        </tr>
                        <tr>
                            <th>Meeting Time</th>
                            <td><%= model.getMeetingTimeTaken() %> seconds</td>
                        </tr>
                        <tr>
                            <th>Repayment Participation</th>
                            <td><%= model.getRepaymentPaid() %>/<%= model.getRepaymentTotal() %> members</td>
                        </tr>
                        <tr>
                            <th>Repayment Time</th>
                            <td><%= model.getRepaymentTimeTaken() %> seconds</td>
                        </tr>
                        <tr>
                            <th>Loan Amount</th>
                            <td>Rs <%= String.format("%.2f", model.getLoanAmount()) %></td>
                        </tr>
                        <tr>
                            <th>Total Payable</th>
                            <td>Rs <%= String.format("%.2f", model.getTotalAmount()) %></td>
                        </tr>
                    </table>
                    
                    <div class="d-grid gap-2 mt-4">
                        <a href="index.html" class="btn btn-primary btn-lg">Back to Home</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>