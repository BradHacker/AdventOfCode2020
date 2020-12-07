import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.Scanner;

public class Solution2 {
    FileInputStream input;
    HashMap<String, Bag> bags;
    HashMap<Bag, String> relationships;

    public Solution2(String inputPath) {
        this.bags = new HashMap<>();
        this.relationships = new HashMap<>();
        try {
            this.input = new FileInputStream(inputPath);
        } catch (FileNotFoundException ex) {
            System.out.println(ex.getMessage());
        }
    }

    public static void main(String[] args) {
        Solution2 sol2 = new Solution2("input.txt");
        sol2.parseInput();
        int numShinyBagContains = sol2.numberBagsContained(sol2.bags.get("shiny gold"));
        System.out.println("Shiny gold bag contains " + numShinyBagContains + " other bags");
    }

    public void parseInput() {
        Scanner scan = new Scanner(this.input);
        while (scan.hasNextLine()) {
            String line = scan.nextLine().replace("bags", "").replace("bag", "");
            String[] parts = line.split(" contain ");
            Bag bag = new Bag(parts[0].strip());
            this.bags.put(parts[0].strip(), bag);
            this.relationships.put(bag, parts[1]);
        }
        System.out.println("" + this.bags.size() + " bags imported");
        this.relationships.forEach((bag, relationships) -> {
            if (!relationships.strip().equals("no other .")) {
                String[] relations = relationships.split(", ");
                for (String relation : relations) {
                    try {
                        int number = Integer.parseInt(relation.substring(0, 1));
                        String bagName = relation.substring(1).replace(".", "").strip();
                        bag.addContains(this.bags.get(bagName), number);
                    } catch (NumberFormatException ex) {
                        System.out.println("NumberFormatException: " + ex.getMessage());
                    }
                }
            }
        });
    }

    public int numberBagsContained(Bag bag) {
        int bagsContained = 0;
        for (Bag containedBag : bag.getContains().keySet()) {
            if (containedBag != null)
                bagsContained += bag.getContains().get(containedBag) + bag.getContains().get(containedBag) * numberBagsContained(containedBag);
        }
        return bagsContained;
    }
}
