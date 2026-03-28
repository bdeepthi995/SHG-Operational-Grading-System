<%@ page import="com.gqt.SHGModel" %>
<%
    SHGModel model = (SHGModel) session.getAttribute("model");
    if (model == null) {
        response.sendRedirect("index.html");
        return;
    }
    boolean meetingDone = model.getMeetingScore() > 0;
    boolean repaymentDone = model.getRepaymentScore() > 0;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - SHG Grading System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .dashboard-card {
            border-radius: 20px;
            transition: transform 0.3s, box-shadow 0.3s;
            cursor: pointer;
            background: white;
            border: none;
        }
        .dashboard-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
        }
        .navbar {
            background: rgba(255,255,255,0.95);
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .completed-badge {
            position: absolute;
            top: 10px;
            right: 10px;
        }
        .card-disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }
        .card-disabled:hover {
            transform: none;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <span class="navbar-brand fw-bold">SHG Grading System</span>
            <div class="ms-auto">
                <span class="badge bg-primary p-2">Group: <%= model.getGroupName() %></span>
                
            </div>
        </div>
    </nav>
    
    <div class="container mt-4">
        <div class="row">
            <div class="col-12 mb-4">
                <div class="alert alert-success">
                    <strong>Welcome, <%= model.getLeader() %>!</strong> You are logged in as leader of 
                    <strong><%= model.getGroupName() %></strong> (ID: <%= model.getGroupId() %>)
                    <br>Total Members: <strong><%= model.getMembers().size() %></strong>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-6 mb-4">
                <div class="dashboard-card p-4 text-center position-relative <%= meetingDone ? "card-disabled" : "" %>" 
                     onclick="<%= !meetingDone ? "location.href='meeting.jsp'" : "" %>">
                    <% if(meetingDone) { %>
                        <div class="completed-badge">
                            <span class="badge bg-success">Completed</span>
                        </div>
                    <% } %>
                    <div class="display-1"></div>
                    <h3 class="mt-3">Start Meeting</h3>
                    <p class="text-muted">Track attendance and meeting duration</p>
                    <% if(meetingDone) { %>
                        <div class="mt-3">
                            <span class="badge bg-info">Score: <%= String.format("%.2f", model.getMeetingScore()) %></span>
                        </div>
                    <% } else { %>
                        <div class="mt-3">
                            <span class="badge bg-info">Total Members: <%= model.getMembers().size() %></span>
                        </div>
                    <% } %>
                </div>
            </div>
            <div class="col-md-6 mb-4">
                <div class="dashboard-card p-4 text-center position-relative <%= repaymentDone ? "card-disabled" : "" %>" 
                     onclick="<%= !repaymentDone ? "location.href='repayment.jsp'" : "" %>">
                    <% if(repaymentDone) { %>
                        <div class="completed-badge">
                            <span class="badge bg-success">Completed</span>
                        </div>
                    <% } %>
                    <div class="display-1"></div>
                    <h3 class="mt-3">Loan Repayment</h3>
                    <p class="text-muted">Track repayment and calculate scores</p>
                    <% if(repaymentDone) { %>
                        <div class="mt-3">
                            <span class="badge bg-info">Score: <%= String.format("%.2f", model.getRepaymentScore()) %></span>
                        </div>
                    <% } else { %>
                        <div class="mt-3">
                            <span class="badge bg-success">Monthly Tracking</span>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
        
        <div class="row mt-2">
            <div class="col-12">
                <div class="dashboard-card p-4 text-center" onclick="location.href='FinalGrade'">
                    <div class="display-1"></div>
                    <h3>View Final Grade</h3>
                    <p class="text-muted">Calculate overall performance grade</p>
                    <% if(meetingDone && repaymentDone) { %>
                        <span class="badge bg-warning text-dark">Ready to Calculate!</span>
                    <% } else { %>
                        <span class="badge bg-secondary">Complete both sections first</span>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</body>
</html>