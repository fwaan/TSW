package it.unisa;
import java.io.Serializable;

public class ProductBean implements Serializable {

	private static final long serialVersionUID = 1L;

	int id;
	String tipo;
	String nome;
	String descrizione;
	float prezzo;
	int quantita;

	public ProductBean() {
		id = -1;
		tipo = "";
		nome = "";
		descrizione = "";
		quantita = 0;
	}

	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getTipo() {
		return tipo;
	}
	
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getDescrizione() {
		return descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	public float getPrezzo() {
		return prezzo;
	}

	public void setPrezzo(float prezzo) {
		this.prezzo = prezzo;
	}

	public int getQuantita() {
		return quantita;
	}

	public void setQuantita(int quantita) {
		this.quantita = quantita;
	}

	@Override
	public String toString() {
		return nome + " (" + id + "), " + prezzo + " " + quantita + ". " + descrizione + ". " + tipo;
	}

}
