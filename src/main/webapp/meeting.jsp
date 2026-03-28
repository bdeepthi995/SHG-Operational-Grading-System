<%@ page import="com.gqt.SHGModel, java.util.*" %>
<%
    SHGModel model = (SHGModel) session.getAttribute("model");
    if (model == null) {
        response.sendRedirect("index.html");
        return;
    }
    List<String> members = model.getMembers();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Meeting Attendance - SHG Grading System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .timer {
            font-size: 48px;
            font-weight: bold;
            font-family: monospace;
            background: #f8f9fa;
            padding: 20px;
            border-radius: 15px;
            display: inline-block;
        }
        .timer-warning {
            color: #dc3545;
            animation: blink 1s infinite;
        }
        @keyframes blink {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }
        .member-checkbox {
            padding: 12px;
            margin: 8px;
            border-radius: 10px;
            background: #f8f9fa;
            transition: all 0.3s;
        }
        .member-checkbox:hover {
            background: #e9ecef;
            transform: translateX(5px);
        }
        .member-checkbox input {
            transform: scale(1.2);
            margin-right: 10px;
        }
        .card {
            border-radius: 20px;
            overflow: hidden;
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <div class="card shadow-lg">
            <div class="card-header bg-primary text-white">
                <h3 class="mb-0">Meeting Attendance Tracking</h3>
            </div>
            <div class="card-body">
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="alert alert-info">
                            <strong>Group:</strong> <%= model.getGroupName() %><br>
                            <strong>Total Members:</strong> <%= members.size() %><br>
                            <strong>Leader:</strong> <%= model.getLeader() %>
                        </div>
                    </div>
                    <div class="col-md-6 text-center">
                        <div class="timer" id="timer">01:00</div>
                        <div class="mt-2">
                            <small class="text-muted">Time remaining to mark attendance</small>
                        </div>
                    </div>
                </div>
                
                <form id="meetingForm" action="StartMeeting" method="post">
                    <h5 class="mb-3">Mark Attended Members:</h5>
                    <div class="row">
                        <% for (String member : members) { %>
                        <div class="col-md-4">
                            <div class="member-checkbox">
                                <input type="checkbox" name="attended" value="<%= member %>" id="member_<%= member %>">
                                <label for="member_<%= member %>" class="ms-2"><%= member %></label>
                            </div>
                        </div>
                        <% } %>
                    </div>
                    
                    <input type="hidden" name="timeTaken" id="timeTaken" value="60">
                    
                    <div class="mt-4">
                        <button type="submit" class="btn btn-success btn-lg w-100" id="submitBtn">
                            Submit Attendance
                        </button>
                        <button type="button" class="btn btn-secondary btn-lg w-100 mt-2" onclick="location.href='dashboard.jsp'">
                            Back to Dashboard
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script>
        let timeLeft = 60;
        const timerElement = document.getElementById('timer');
        const timeTakenInput = document.getElementById('timeTaken');
        const submitBtn = document.getElementById('submitBtn');
        
        function updateTimer() {
            var minutes = Math.floor(timeLeft / 60);
            var seconds = timeLeft % 60;
            var minutesStr = minutes.toString().padStart(2, '0');
            var secondsStr = seconds.toString().padStart(2, '0');
            timerElement.textContent = minutesStr + ":" + secondsStr;
            
            if (timeLeft <= 10 && timeLeft > 0) {
                timerElement.classList.add('timer-warning');
            }
            
            if (timeLeft <= 0) {
                timerElement.textContent = "00:00";
                timerElement.classList.add('timer-warning');
                submitBtn.click();
            } else {
                timeLeft--;
                setTimeout(updateTimer, 1000);
            }
        }
        
        updateTimer();
        
        document.getElementById('meetingForm').addEventListener('submit', function() {
            var timeElapsed = 60 - timeLeft;
            document.getElementById('timeTaken').value = timeElapsed;
        });
    </script>
</body>
</html>