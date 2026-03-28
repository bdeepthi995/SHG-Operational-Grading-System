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
    <title>Meeting Results - SHG Grading System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .score-card {
            background: linear-gradient(135deg, #28a745, #20c997);
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
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="score-card">
                    <h3>MEETING SCORE</h3>
                    <div class="score-number"><%= String.format("%.2f", model.getMeetingScore()) %> / 10</div>
                    <p class="mt-2">Great job! Keep up the attendance and punctuality.</p>
                </div>
                
                <div class="details-card">
                    <h4 class="mb-3">Attendance Summary</h4>
                    <table class="table table-bordered">
                         <tr>
                            <th>Total Members</th>
                            <td><%= model.getMeetingTotal() %></td>
                         </tr>
                         <tr>
                            <th>Attended</th>
                            <td><%= model.getMeetingAttended() %></td>
                         </tr>
                         <tr>
                            <th>Missed</th>
                            <td>
                                <%= model.getMeetingMissed() %>
                                <% if(model.getMeetingMissed().isEmpty()) { %>
                                    <span class="text-success">All members attended!</span>
                                <% } %>
                            </td>
                         </tr>
                         <tr>
                            <th>Time Taken</th>
                            <td><%= model.getMeetingTimeTaken() %> seconds</td>
                         </tr>
                    </table>
                    
                    <h4 class="mt-4">Score Breakdown</h4>
                    <table class="table table-bordered">
                        <tr>
                            <th>Attendance Score</th>
                            <td><%= String.format("%.2f", ((double)model.getMeetingAttended() / model.getMeetingTotal()) * 7) %></td>
                        </tr>
                        <tr>
                            <th>Time Score</th>
                            <td><%= String.format("%.2f", ((60 - Math.min(model.getMeetingTimeTaken(), 60)) / 60.0) * 3) %></td>
                        </tr>
                        <tr class="table-success">
                            <th>Total Score</th>
                            <th><%= String.format("%.2f", model.getMeetingScore()) %> / 10</th>
                        </tr>
                    </table>
                    
                    <div class="d-grid gap-2 mt-4">
                        <a href="dashboard.jsp" class="btn btn-primary btn-lg">Back to Dashboard</a>
                        <a href="repayment.jsp" class="btn btn-success btn-lg">Proceed to Loan Repayment</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>