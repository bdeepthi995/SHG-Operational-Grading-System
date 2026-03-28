package com.gqt;

import java.sql.*;
import java.util.*;

public class SHGModel {
    
    private String url = "jdbc:mysql://localhost:3306/shg_grading_system";
    private String userName = "root";
    private String password = "admin";
    private Connection con = null;
    private PreparedStatement pstmt = null;
    private ResultSet res = null;
    
    private int groupId;
    private String groupName;
    private String leader;
    private String formedDate;
    private List<String> members;
    
    private double meetingScore;
    private double repaymentScore;
    private double finalScore;
    private String grade;
    private int meetingAttended;
    private int meetingTotal;
    private int repaymentPaid;
    private int repaymentTotal;
    private long meetingTimeTaken;
    private long repaymentTimeTaken;
    private List<String> meetingMissed;
    private List<String> repaymentMissed;
    private double loanAmount;
    private double interestRate;
    private double totalAmount;
    private double monthlyPerMember;
    
    public SHGModel() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, userName, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
    public int getGroupId() { return groupId; }
    public void setGroupId(int groupId) { this.groupId = groupId; }
    
    public String getGroupName() { return groupName; }
    public void setGroupName(String groupName) { this.groupName = groupName; }
    
    public String getLeader() { return leader; }
    public void setLeader(String leader) { this.leader = leader; }
    
    public String getFormedDate() { return formedDate; }
    public void setFormedDate(String formedDate) { this.formedDate = formedDate; }
    
    public List<String> getMembers() { return members; }
    public void setMembers(List<String> members) { this.members = members; }
    
    public double getMeetingScore() { return meetingScore; }
    public void setMeetingScore(double meetingScore) { this.meetingScore = meetingScore; }
    
    public double getRepaymentScore() { return repaymentScore; }
    public void setRepaymentScore(double repaymentScore) { this.repaymentScore = repaymentScore; }
    
    public double getFinalScore() { return finalScore; }
    public void setFinalScore(double finalScore) { this.finalScore = finalScore; }
    
    public String getGrade() { return grade; }
    public void setGrade(String grade) { this.grade = grade; }
    
    public int getMeetingAttended() { return meetingAttended; }
    public void setMeetingAttended(int meetingAttended) { this.meetingAttended = meetingAttended; }
    
    public int getMeetingTotal() { return meetingTotal; }
    public void setMeetingTotal(int meetingTotal) { this.meetingTotal = meetingTotal; }
    
    public int getRepaymentPaid() { return repaymentPaid; }
    public void setRepaymentPaid(int repaymentPaid) { this.repaymentPaid = repaymentPaid; }
    
    public int getRepaymentTotal() { return repaymentTotal; }
    public void setRepaymentTotal(int repaymentTotal) { this.repaymentTotal = repaymentTotal; }
    
    public long getMeetingTimeTaken() { return meetingTimeTaken; }
    public void setMeetingTimeTaken(long meetingTimeTaken) { this.meetingTimeTaken = meetingTimeTaken; }
    
    public long getRepaymentTimeTaken() { return repaymentTimeTaken; }
    public void setRepaymentTimeTaken(long repaymentTimeTaken) { this.repaymentTimeTaken = repaymentTimeTaken; }
    
    public List<String> getMeetingMissed() { return meetingMissed; }
    public void setMeetingMissed(List<String> meetingMissed) { this.meetingMissed = meetingMissed; }
    
    public List<String> getRepaymentMissed() { return repaymentMissed; }
    public void setRepaymentMissed(List<String> repaymentMissed) { this.repaymentMissed = repaymentMissed; }
    
    public double getLoanAmount() { return loanAmount; }
    public void setLoanAmount(double loanAmount) { this.loanAmount = loanAmount; }
    
    public double getInterestRate() { return interestRate; }
    public void setInterestRate(double interestRate) { this.interestRate = interestRate; }
    
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    
    public double getMonthlyPerMember() { return monthlyPerMember; }
    public void setMonthlyPerMember(double monthlyPerMember) { this.monthlyPerMember = monthlyPerMember; }
    
    
    public boolean validateGroup(int groupId, String leader) {
        try {
            pstmt = con.prepareStatement("SELECT * FROM shg_groups WHERE group_id = ? AND leader_name = ?");
            pstmt.setInt(1, groupId);
            pstmt.setString(2, leader);
            res = pstmt.executeQuery();
            
            if (res.next()) {
                this.groupId = res.getInt("group_id");
                this.groupName = res.getString("group_name");
                this.leader = res.getString("leader_name");
                this.formedDate = res.getString("formed_date");
                loadMembers();
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Load members for the current group
    private void loadMembers() {
        members = new ArrayList<>();
        try {
            pstmt = con.prepareStatement("SELECT member_name FROM group_members WHERE group_id = ?");
            pstmt.setInt(1, groupId);
            res = pstmt.executeQuery();
            
            while (res.next()) {
                members.add(res.getString("member_name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void calculateMeetingScore(List<String> attended, long timeTaken) {
        meetingTotal = members.size();
        meetingAttended = attended.size();
        meetingTimeTaken = timeTaken;
        
        meetingMissed = new ArrayList<>(members);
        meetingMissed.removeAll(attended);
        
        double attendanceScore = ((double) meetingAttended / meetingTotal) * 7;
        double timeScore = ((60 - Math.min(timeTaken, 60)) / 60.0) * 3;
        meetingScore = attendanceScore + timeScore;
    }
    
    public void calculateRepaymentScore(List<String> paid, long timeTaken) {
        repaymentTotal = members.size();
        repaymentPaid = paid.size();
        repaymentTimeTaken = timeTaken;
        
        repaymentMissed = new ArrayList<>(members);
        repaymentMissed.removeAll(paid);
        
        double attendanceScore = ((double) repaymentPaid / repaymentTotal) * 7;
        double timeScore = ((60 - Math.min(timeTaken, 60)) / 60.0) * 3;
        repaymentScore = attendanceScore + timeScore;
    }
    
    public void calculateLoanDetails(double loanAmount, double interest) {
        this.loanAmount = loanAmount;
        this.interestRate = interest;
        this.totalAmount = loanAmount + (loanAmount * interest / 100);
        this.monthlyPerMember = (totalAmount / 12) / members.size();
    }
    
    public void calculateFinalGrade() {
        finalScore = (meetingScore + repaymentScore) / 2;
        
        if (finalScore >= 8.5) grade = "A";
        else if (finalScore >= 7.0) grade = "B";
        else if (finalScore >= 5.0) grade = "C";
        else grade = "D";
    }
    
    public void closeResources() {
        try {
            if (res != null) res.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}