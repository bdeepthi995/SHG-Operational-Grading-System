package SHGGradingSystem;

import org.json.*;
import java.nio.file.*;
import java.util.*;

public class JsonUtil {

    public static List<SHGGroup> loadGroups() throws Exception {
        String content = Files.readString(Paths.get("data/groups.json"));
        JSONArray arr = new JSONArray(content);

        List<SHGGroup> groups = new ArrayList<>();

        for (int i = 0; i < arr.length(); i++) {
            JSONObject o = arr.getJSONObject(i);
            SHGGroup g = new SHGGroup();
            g.groupId = o.getInt("groupId");
            g.groupName = o.getString("groupName");
            g.leader = o.getString("leader");
            g.formedDate = o.getString("formedDate");

            JSONArray m = o.getJSONArray("members");
            g.members = new ArrayList<>();
            for (int j = 0; j < m.length(); j++)
                g.members.add(m.getString(j));

            groups.add(g);
        }
        return groups;
    }
}
