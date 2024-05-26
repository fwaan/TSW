<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ include file="header.jsp" %>
<%@ page import="it.unisa.ProductBean" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String userid = (String) session.getAttribute("userid");
    if (userid == null) {
		response.sendRedirect("utente.jsp");
	}
	else{
		String tipo = (String) session.getAttribute("tipo");
		if(tipo != null && tipo.equals("Customer")){
			response.sendRedirect("utente.jsp");
		}
		else if(tipo != null && tipo.equals("Admin")){
%>

<%
	ProductBean prodotto = (ProductBean) request.getAttribute("prodotto");
	List<?> prodotti = (List<?>) request.getAttribute("prodotti");
	if(prodotti == null){
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ProductControl?action=amministratore");
    	dispatcher.forward(request, response);
		return;
	}
%>
	
	<style>
		h2 {
			font-family: Titoli-Skateboard;
			text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;
			letter-spacing: 0.02rem;
		}
	
		table {
			width: 80%;
		}
	
		.aggiornaLista,input[type="submit"]{
			font-family: Titoli-Skateboard;
			text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;
		}
	
		.aggiornaLista,input[type="submit"] {
			margin-top: 0.125rem;
			color: white;
			padding: 10px 20px;
			border: none;
			border-radius: 4px;
			cursor: pointer;
		}
	
		.aggiornaLista,input[type="submit"] {
			background-color: #4CAF50;
		}
	
		input[type="reset"]{
			font-family: Titoli-Skateboard;
			text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;
		}
	
		input[type="reset"] {
			margin-top: 0.125rem;
			color: white;
			padding: 10px 20px;
			border: none;
			border-radius: 4px;
			cursor: pointer;
		}
	
		input[type="reset"] {
			background-color: rgb(238, 133, 112);
		}
	
		/* Stili per dispositivi con larghezza schermo inferiore a 600px */
		@media (max-width: 600px) {
			body {
				font-size: 0.875rem;
			}
	
			table {
				width: 80%;
			}
		}
	
		/* Stili per dispositivi con larghezza schermo inferiore a 400px */
		@media (max-width: 450px) {
			body {
				font-size: 0.675rem;
			}
	
			table {
				width: 80%;
			}
		}
	
		/* Stili base per il form e il titolo */
		.form-container3 {
			background-color: rgba(238, 191, 112, 1);
			display: flex;
			flex-direction: column;
			width: 40%;
			margin: auto;
			align-items: left;
		}
	
		.form-container3 h2 {
			text-align: center;
			/* Centra il testo */
		}
	
		/* Stili per dispositivi con larghezza schermo inferiore a 600px */
		@media (max-width: 600px) {
			.form-container3 {
				width: 100%;
			}
		}
	
		/* Stili per dispositivi con larghezza schermo inferiore a 400px */
		@media (max-width: 400px) {
			.form-container3 {
				width: 100%;
			}
		}
	</style>
	<div style="display: flex; justify-content: center; text-align: center;">
	<h2 style="color: black; font-weight: bold; margin-bottom: 0.3125rem; margin-top: 0.625rem;">Prodotti</h2>
	</div>
	<a href="ProductControl?action=amministratore" style="color: white; text-decoration: none; margin-bottom: 1rem; display: inline-block	;" class="aggiornaLista">Aggiorna lista</a>
	<table border="1" style="background-color: rgba(238, 191, 112, 1);">
		<tr>
			<th>ID</th>
			<th>Tipo</th>
			<th>Nome</th>
			<th>Descrizione</th>
            <th>Prezzo</th>
            <th>Quantita</th>
		</tr>
		<%
			if (prodotti != null && prodotti.size() != 0) {
				Iterator<?> it = prodotti.iterator();
				while (it.hasNext()) {
					ProductBean bean = (ProductBean) it.next();
		%>
		<tr>
			<td><%=bean.getId()%></td>
            <td><%=bean.getTipo()%></td>
			<td><%=bean.getNome()%></td>
			<td><%=bean.getDescrizione()%></td>
            <td><%=bean.getPrezzo()%></td>
            <td><%=bean.getQuantita()%></td>
			<td><a href="ProductControl?action=delete&id=<%=bean.getId()%>"><i class="fa fa-times-circle" aria-hidden="true"></i></a>
				<a href="ProductControl?action=readdetails&id=<%=bean.getId()%>" style="margin-left: 0.625rem;"><i class="fa fa-info-circle" aria-hidden="true"></i></a></td>
		</tr>
		<%
				}
			} else {
		%>
		<tr>
			<td colspan="6">No products available</td>
		</tr>
		<%
			}
		%>
	</table>
	<div style="width: 80%; margin: auto;">
	<h2 style="color: black; text-align: center;">Inserisci</h2>
	<form action="ProductControl?action=insert" method="post" class="form-container3">
		<input type="hidden" name="action" value="insert"> 
		
		<label for="nome">Nome:</label><br> 
		<input name="nome" type="text" maxlength="20" required placeholder="Inserisci nome"><br>

        <label for="tipo">Tipo:</label><br>
            <select id="tipo" name="tipo">
                <option value="Asse">Asse</option>
                <option value="Carrello">Carrello</option>
                <option value="Cuscinetti">Cuscinetti</option>
                <option value="Ruote">Ruote</option>
		    </select><br>
		<label for="descrizione">Descrizione:</label><br>
		<textarea name="descrizione" maxlength="100" rows="3" required placeholder="Inserisci descrizione"></textarea><br>
		
		<label for="prezzo">Prezzo:</label><br> 
        <input name="prezzo" type="text" pattern="^\d+(\.\d{1,2})?$" title="Inserisci un numero valido. Massimo due cifre decimali." required><br>

		<label for="quantita">Quantita:</label><br> 
		<input name="quantita" type="number" min="1" value="1" required><br>

		<input type="submit" value="Add"><input type="reset" value="Reset">

	</form>
	</div>
	<form action="ProductControl?action=logoututente" method="post"  style="margin-bottom: 8.125rem; margin-top: 1.25rem;">
        <input type="hidden" name="action" value="logout">
        <input type="submit" value="Logout" style="background-color: rgba(238, 191, 112, 1); border: 2px black solid;">
    </form>
	<%
		}
	}
	%>
<%@ include file="footer.jsp" %>