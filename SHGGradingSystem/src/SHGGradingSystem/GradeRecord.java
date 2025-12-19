package SHGGradingSystem;

import java.util.List;

public class GradeRecord {
    double meetingScore;
    double repaymentScore;
    double finalScore;
    String grade;

    List<String> meetingMissed;
    List<String> repaymentMissed;
    long meetingTime;
    long repaymentTime;
}
