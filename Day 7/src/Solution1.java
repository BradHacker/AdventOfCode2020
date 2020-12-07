import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.Scanner;

public class Solution1 {
    FileInputStream input;
    HashMap<String, Bag> bags;
    HashMap<Bag, String> relationships;

    public Solution1(String inputPath) {
        this.bags = new HashMap<>();
        this.relationships = new HashMap<>();
        try {
            this.input = new FileInputStream(inputPath);
        } catch (FileNotFoundException ex) {
            System.out.println(ex.getMessage());
        }
    }

    public static void main(String[] args) {
        Solution1 sol1 = new Solution1("input.txt");
        sol1.parseInput();
        int containsShinyGold = 0;
        for (String bagName : sol1.bags.keySet()) {
            if (sol1.eventuallyContainsShinyGold(sol1.bags.get(bagName))) {
                System.out.println(bagName + ": true");
                containsShinyGold++;
            } else System.out.println(bagName + ": false");
        }
        System.out.println("Bags eventually containing shiny golden: " + containsShinyGold);
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

    public boolean eventuallyContainsShinyGold(Bag bag) {
        boolean result = false;
        if (bag.getContains().size() > 0) {
            for (Bag containsBag : bag.getContains().keySet()) {
                if (containsBag != null) {
                    if (containsBag.getName().equals("shiny gold")) {
                        result = true;
                    } else {
                        result = result || eventuallyContainsShinyGold(containsBag);
                    }
                }
            }
        }
        return result;
    }
}
