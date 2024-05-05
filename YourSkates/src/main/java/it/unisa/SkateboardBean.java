package it.unisa;

import java.util.UUID;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class SkateboardBean implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id;
    private String tipo;
    private String colore;
    private List<ProductBean> components;

    public SkateboardBean() {
        this.id = UUID.randomUUID().toString();
        components = new ArrayList<>();
    }

    public String getId() {
        return id;
    }
    
    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getColore() {
        return colore;
    }

    public void setColore(String colore) {
        this.colore = colore;
    }

    public List<ProductBean> getComponents() {
        return components;
    }

    public void setComponents(List<ProductBean> components) {
        this.components = components;
    }

    public void addComponent(ProductBean component) {
        this.components.add(component);
    }

    public void removeComponent(ProductBean component) {
        this.components.remove(component);
    }

    public float getTotalPrice() {
        float total = 0;
        for (ProductBean component : components) {
            total += component.getPrezzo();
        }
        return total;
    }

    @Override
    public String toString() {
        return "SkateboardBean [tipo=" + tipo + ", colore=" + colore + ", components=" + components + "]";
    }
}