import java.util.HashMap;

public class Bag {
    private String name;
    private HashMap<Bag, Integer> contains;

    public Bag(String name) {
        this.name = name;
        this.contains = new HashMap<>();
    }

    public String getName() {
        return this.name;
    }

    public HashMap<Bag, Integer> getContains() {
        return this.contains;
    }

    public void addContains(Bag bag, int number) {
        this.contains.put(bag, number);
    }

    @Override
    public String toString() {
        String output = this.name + " bag " +
                "contains: ";
        for (Bag bag : this.contains.keySet()) {
            if (bag != null)
                output += "" + this.contains.get(bag) + " " + bag.getName() + ", ";
        }
        return output;
    }
}