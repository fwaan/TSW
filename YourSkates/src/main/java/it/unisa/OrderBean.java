package it.unisa;

import java.io.Serializable;

public class OrderBean implements Serializable {

    private static final long serialVersionUID = 1L;

    private int id;
    private String userid;
    private String tipoSkateboard;
    private String colore;
    private int idAsse;
    private String nomeAsse;
    private int idCarrello;
    private String nomeCarrello;
    private int idCuscinetti;
    private String nomeCuscinetti;
    private int idRuote;
    private String nomeRuote;
    private float prezzo;
    private String indirizzo;
    private String citta;
    private String provincia;
    private String CAP;

    public OrderBean() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getTipoSkateboard() {
        return tipoSkateboard;
    }

    public void setTipoSkateboard(String tipoSkateboard) {
        this.tipoSkateboard = tipoSkateboard;
    }

    public String getColore() {
        return colore;
    }

    public void setColore(String colore) {
        this.colore = colore;
    }

    public int getIdAsse() {
        return idAsse;
    }

    public void setIdAsse(int idAsse) {
        this.idAsse = idAsse;
    }

    public String getNomeAsse() {
        return nomeAsse;
    }

    public void setNomeAsse(String nomeAsse) {
        this.nomeAsse = nomeAsse;
    }

    public int getIdCarrello() {
        return idCarrello;
    }

    public void setIdCarrello(int idCarrello) {
        this.idCarrello = idCarrello;
    }

    public String getNomeCarrello() {
        return nomeCarrello;
    }

    public void setNomeCarrello(String nomeCarrello) {
        this.nomeCarrello = nomeCarrello;
    }

    public int getIdCuscinetti() {
        return idCuscinetti;
    }

    public void setIdCuscinetti(int idCuscinetti) {
        this.idCuscinetti = idCuscinetti;
    }

    public String getNomeCuscinetti() {
        return nomeCuscinetti;
    }

    public void setNomeCuscinetti(String nomeCuscinetti) {
        this.nomeCuscinetti = nomeCuscinetti;
    }

    public int getIdRuote() {
        return idRuote;
    }

    public void setIdRuote(int idRuote) {
        this.idRuote = idRuote;
    }

    public String getNomeRuote() {
        return nomeRuote;
    }

    public void setNomeRuote(String nomeRuote) {
        this.nomeRuote = nomeRuote;
    }

    public float getPrezzo() {
        return prezzo;
    }

    public void setPrezzo(float prezzo) {
        this.prezzo = prezzo;
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
}