package SHGGradingSystem;

import java.util.*;

public class SHGService implements SHGOperations {

    private SHGGroup group;
    private GradeRecord record = new GradeRecord();
    private Scanner sc = new Scanner(System.in);

    private SHGGroup validateGroup() throws Exception {
        List<SHGGroup> groups = JsonUtil.loadGroups();

        System.out.print("Enter Group ID: ");
        int gid = sc.nextInt();
        sc.nextLine();

        System.out.print("Enter Leader Name: ");
        String leader = sc.nextLine();

        for (SHGGroup g : groups) {
            if (g.groupId == gid && g.leader.equalsIgnoreCase(leader)) {
                return g;
            }
        }
        System.out.println("Invalid group details!");
        return null;
    }

    // ---------------- MEETING ----------------
    @Override
    public void startMeeting() throws Exception {
        group = validateGroup();
        if (group == null) return;

        System.out.println("\n--- MEETING STARTED ---");
        System.out.println("Members: " + group.members);
        System.out.println("Enter names (1 minute). Type 'done' if finished.");

        Set<String> attended = Collections.synchronizedSet(new HashSet<>());
        long startTime = System.currentTimeMillis();
        boolean[] running = { true };

        Thread inputThread = new Thread(() -> {
            while (running[0]) {
                String name = sc.nextLine();
                if (name.equalsIgnoreCase("done")) break;
                if (group.members.contains(name))
                    attended.add(name);
            }
        });

        inputThread.start();

        while (System.currentTimeMillis() - startTime < 60000 &&
               attended.size() < group.members.size()) {
            Thread.sleep(200);
        }

        running[0] = false;
        inputThread.join(100);

        long timeTaken = (System.currentTimeMillis() - startTime) / 1000;

        List<String> missed = new ArrayList<>(group.members);
        missed.removeAll(attended);

        record.meetingScore =
                ((double) attended.size() / group.members.size()) * 7 +
                ((60 - Math.min(timeTaken, 60)) / 60.0) * 3;

        System.out.println("\n--- MEETING SUMMARY ---");
        System.out.println("Total Members    : " + group.members.size());
        System.out.println("Attended         : " + attended.size());
        System.out.println("Missed           : " + missed);
        System.out.println("Time Taken       : " + timeTaken + " sec");
        System.out.println("Meeting Score    : " + record.meetingScore);
    }

    // ---------------- REPAYMENT ----------------
    @Override
    public void startRepayment() throws Exception {

        if (group == null) {
            System.out.println("Conduct meeting first!");
            return;
        }

        sc = new Scanner(System.in); // ✅ CLEAR BUFFER

        System.out.print("Enter total loan amount: ");
        double loan = sc.nextDouble();

        System.out.print("Enter interest (%): ");
        double interest = sc.nextDouble();
        sc.nextLine();

        int months = 12;
        double total = loan + (loan * interest / 100);
        double perMember = (total / months) / group.members.size();

        System.out.println("Monthly per member: Rs. " + perMember);

        System.out.println("\n--- REPAYMENT STARTED ---");
        System.out.println("Enter names (1 minute)");

        Set<String> paid = Collections.synchronizedSet(new HashSet<>());
        long startTime = System.currentTimeMillis();
        boolean[] running = { true };

        Thread inputThread = new Thread(() -> {
            while (running[0]) {
                String name = sc.nextLine();
                if (group.members.contains(name))
                    paid.add(name);
            }
        });

        inputThread.start();

        while (System.currentTimeMillis() - startTime < 60000 &&
               paid.size() < group.members.size()) {
            Thread.sleep(200);
        }

        running[0] = false;
        inputThread.join(100);

        long timeTaken = (System.currentTimeMillis() - startTime) / 1000;

        List<String> missed = new ArrayList<>(group.members);
        missed.removeAll(paid);

        record.repaymentScore =
                ((double) paid.size() / group.members.size()) * 7 +
                ((60 - Math.min(timeTaken, 60)) / 60.0) * 3;

        System.out.println("\n--- REPAYMENT SUMMARY ---");
        System.out.println("Paid Members     : " + paid.size());
        System.out.println("Not Paid         : " + missed);
        System.out.println("Time Taken       : " + timeTaken + " sec");
        System.out.println("Repayment Score  : " + record.repaymentScore);
    }

    // ---------------- FINAL ----------------
    @Override
    public void showFinalGrade() {

        record.finalScore = (record.meetingScore + record.repaymentScore) / 2;

        if (record.finalScore >= 8.5) record.grade = "A";
        else if (record.finalScore >= 7) record.grade = "B";
        else if (record.finalScore >= 5) record.grade = "C";
        else record.grade = "D";

        System.out.println("\n--- FINAL RESULT ---");
        System.out.println("Group        : " + group);
        System.out.println("Meeting      : " + record.meetingScore);
        System.out.println("Repayment    : " + record.repaymentScore);
        System.out.println("Final Score  : " + record.finalScore);
        System.out.println("GRADE        : " + record.grade);
    }
}
