package it.unisa;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class CartBean implements Serializable {

    private static final long serialVersionUID = 1L;

    private List<SkateboardBean> skateboards;

    public CartBean() {
        skateboards = new ArrayList<>();
    }

    public List<SkateboardBean> getSkateboards() {
        return skateboards;
    }

    public void setSkateboards(List<SkateboardBean> skateboards) {
        this.skateboards = skateboards;
    }

    public void addSkateboard(SkateboardBean skateboard) {
        this.skateboards.add(skateboard);
    }

    public void removeSkateboard(SkateboardBean skateboard) {
        this.skateboards.remove(skateboard);
    }

    public float getTotalPrice() {
        float total = 0;
        for (SkateboardBean skateboard : skateboards) {
            total += skateboard.getTotalPrice();
        }
        return total;
    }

    @Override
    public String toString() {
        return "CartBean [skateboards=" + skateboards + "]";
    }
}