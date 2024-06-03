package it.unisa;

public class UserBean implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    private String userid;
    private String tipo;
    private String password_hash;
    private String indirizzo;
    private String citta;
    private String provincia;
    private String CAP;
    private String metodo_pagamento;

    public UserBean() {
        userid = "";
        tipo = "";
        password_hash = "";
        indirizzo = "";
        citta = "";
        provincia = "";
        CAP = "";
        metodo_pagamento = "";
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

    public String getIndirizzo() {
        return indirizzo;
    }

    public void setIndirizzo(String indirizzo) {
        this.indirizzo = indirizzo;
    }

    public String getCitta() {
        return citta;
    }

    public void setCitta(String citta) {
        this.citta = citta;
    }

    public String getProvincia() {
        return provincia;
    }

    public void setProvincia(String provincia) {
        this.provincia = provincia;
    }

    public String getCAP() {
        return CAP;
    }

    public void setCAP(String CAP) {
        this.CAP = CAP;
    }

    public String getMetodoPagamento() {
        return metodo_pagamento;
    }

    public void setMetodoPagamento(String metodo_pagamento) {
        this.metodo_pagamento = metodo_pagamento;
    }

    @Override
    public String toString() {
        return "UserBean{" +
                "indirizzo='" + indirizzo + '\'' +
                ", citta='" + citta + '\'' +
                ", provincia='" + provincia + '\'' +
                ", CAP='" + CAP + '\'' +
                ", metodo_pagamento='" + metodo_pagamento + '\'' + // Aggiunta della nuova variabile al metodo toString
                '}';
    }
}