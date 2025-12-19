package SHGGradingSystem;

import java.util.List;

public class SHGGroup {

    int groupId;
    String groupName;
    String leader;
    String formedDate;
    List<String> members;

    @Override
    public String toString() {
        return groupName + " (" + groupId + ")";
    }
}
