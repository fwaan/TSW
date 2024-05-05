package it.unisa;

public class UserBean implements java.io.Serializable {
    private String userid;
    private String tipo;
    private String password_hash;

    public UserBean() {
        userid = "";
        tipo = "";
        password_hash = "";
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getPasswordHash() {
        return password_hash;
    }

    public void setPasswordHash(String password_hash) {
        this.password_hash = password_hash;
    }
}