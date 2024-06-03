<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ include file="header.jsp" %>
<%@ page import="it.unisa.ProductBean" %>
<%@ page import="it.unisa.OrderBean" %>

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
	List<?> orders = (List<?>) request.getAttribute("ordiniAmministratore");
	if(prodotti == null){
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ProductControl?action=amministratore");
    	dispatcher.forward(request, response);
		return;
	}
%>
	
	<style>
		h2 {
			font-family: Titoli-Skateboard;
			font-size: 2.5rem;
			text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;
			letter-spacing: 0.02rem;
		}
	
		table {
			width: 100%;
			font-size: 1.25rem;
			font-family: Arial, Helvetica, sans-serif;
		}
	
		.aggiornaLista,input[type="submit"]{
			font-family: Titoli-Skateboard;
			font-size: 1.25rem;
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
			font-size: 1.25rem;
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
		@media (max-width: 650px) {
			body {
				font-size: 0.875rem;
			}
	
			table {
				width: 80%;
				font-size: 1rem;
			}

			.aggiornaLista,input[type="submit"],input[type="reset"] {
				font-size: 1rem;
			}
		}
	
		/* Stili per dispositivi con larghezza schermo inferiore a 400px */
		@media (max-width: 550px) {
			body {
				font-size: 0.675rem;
			}
	
			table {
				width: 90%;
				font-size: 0.775rem;
			}
			.aggiornaLista,input[type="submit"],input[type="reset"] {
				font-size: 0.85rem;
			}
		}

		@media (max-width: 450px){
			table{
				font-size: 0.675rem;
			}
			.aggiornaLista,input[type="submit"],input[type="reset"] {
				font-size: 0.75rem;
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
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<script src="https://cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.22/css/jquery.dataTables.min.css">
	<script>
		$(document).ready(function () {
			$('#prodotti').DataTable({
				"columnDefs": [
					{ "searchable": false, "targets": [0, 1, 3, 4, 5, 6] }
				],
				"language": {
					"search": "",
					"lengthMenu": "Mostra _MENU_ elementi",
					"info": "Mostra da _START_ a _END_ di _TOTAL_ elementi",
					"infoEmpty": "Mostra 0 a 0 di 0 elementi",
					"infoFiltered": "(filtrati da _MAX_ elementi totali)",
					"zeroRecords": "Nessun elemento trovato",
					"paginate": {
						"first": "Primo",
						"last": "Ultimo",
						"next": "Successivo",
						"previous": "Precedente"
					}
				}
			});
		});
		$(document).ready(function () {
			$('#ordini').DataTable({
				"columnDefs": [
					{ "searchable": false, "targets": [0, 2, 3] }
				],
				"language": {
					"search": "",
					"lengthMenu": "Mostra _MENU_ elementi",
					"info": "Mostra da _START_ a _END_ di _TOTAL_ elementi",
					"infoEmpty": "Mostra 0 a 0 di 0 elementi",
					"infoFiltered": "(filtrati da _MAX_ elementi totali)",
					"zeroRecords": "Nessun elemento trovato",
					"paginate": {
						"first": "Primo",
						"last": "Ultimo",
						"next": "Successivo",
						"previous": "Precedente"
					}
				}
			});
			$('.dataTables_filter label').prepend('<i class="fa fa-search"></i>');
		});
	</script>
	<style>
		.dataTables_filter label {
			font-family: Titoli-Skateboard;
			color: black;
			font-size: 1.5rem;
			text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;
		}
	
		.dataTables_filter input {
			margin-bottom: 0.375rem;
			font-size: 1.5rem !important;
			border: 2px solid black !important;
			background-color: white !important;
			border-radius: 24px !important;
			padding: 10px 20px !important;
			width: 300px !important;
			height: 44px !important;
			box-shadow: none !important;
			transition: box-shadow 200ms cubic-bezier(0.4, 0.0, 0.2, 1) !important;
		}
	
		.dataTables_filter input:focus {
			outline: none !important;
			box-shadow: 0 1px 6px 0 rgba(32, 33, 36, 0.28) !important;
		}

		.dataTables_length label {
			font-family: Font-Carino;
			color: black;
			font-size: 1.5rem;
			text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;
		}
		
		.dataTables_info {
			font-family: Font-Carino;
			font-weight: bold;
			color: black;
			font-size: 1.25rem;
			text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;
		}

		.dataTables_paginate {
        	font-family: Font-Carino;
			letter-spacing: 0.15rem;
			font-weight: bold;
			color: black;
			font-size: 1.25rem;
			text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;
    	}

		.dataTables_paginate a {
			color: black !important;
		}
		@media (max-width: 800px) {
			.dataTables_filter label {
				font-size: 1.25rem;
			}
			.datatables_length label {
				font-size: 1rem;
			}
			.dataTables_info {
				font-size: 1rem;
			}
			.dataTables_paginate {
				font-size: 1rem;
			}
		}
		@media (max-width: 800px) {
        .table-responsive-admin {
            overflow-x: auto;
            width: 100%;
        }
    }
	</style>
	<div style="display: flex; justify-content: center; text-align: center;">
	<h2 style="color: black; font-weight: bold; margin-bottom: 0.3125rem; margin-top: 0.625rem;">PRODOTTI</h2>
	</div>
	<a href="ProductControl?action=amministratore" style="color: white; text-decoration: none; margin-bottom: 1rem; display: inline-block	;" class="aggiornaLista">Aggiorna lista</a>
	<div class="table-responsive-admin">
		<table id="prodotti" border="1" style="background-color: rgba(238, 191, 112, 1);">
			<thead>
				<tr>
					<th style="background-color: rgba(238, 191, 112, 1);">ID</th>
					<th style="background-color: rgba(238, 191, 112, 1);">Tipo</th>
					<th style="background-color: rgba(238, 191, 112, 1);">Nome</th>
					<th style="background-color: rgba(238, 191, 112, 1);">Descrizione</th>
					<th style="background-color: rgba(238, 191, 112, 1);">Prezzo</th>
					<th style="background-color: rgba(238, 191, 112, 1);">Quantita</th>
					<th style="background-color: rgba(238, 191, 112, 1);">Azioni</th>
				</tr>
			</thead>
			<% if (prodotti !=null && prodotti.size() !=0) { Iterator<?> it = prodotti.iterator();
				while (it.hasNext()) {
				ProductBean bean = (ProductBean) it.next();
				%>
				<tr>
					<td>
						<%=bean.getId()%>
					</td>
					<td>
						<%=bean.getTipo()%>
					</td>
					<td>
						<%=bean.getNome()%>
					</td>
					<td>
						<%=bean.getDescrizione()%>
					</td>
					<td>
						<%=bean.getPrezzo()%>
					</td>
					<td>
						<%=bean.getQuantita()%>
					</td>
					<td><a href="ProductControl?action=delete&id=<%=bean.getId()%>"><i class="fa fa-times-circle"
								aria-hidden="true"></i></a>
						<a href="ProductControl?action=readdetails&id=<%=bean.getId()%>" style="margin-left: 0.625rem;"><i
								class="fa fa-info-circle" aria-hidden="true"></i></a>
					</td>
				</tr>
				<% } } else { %>
					<tr>
						<td colspan="6">No products available</td>
					</tr>
					<% } %>
		</table>
	</div>
	<div style="width: 80%; margin: auto;">
	<h2 style="color: black; text-align: center;">INSERISCI</h2>
	<form action="ProductControl?action=insert" method="post" class="form-container3" style="font-family: Roboto-Serif; font-size: 1rem; font-weight: bold;">
		<input type="hidden" name="action" value="insert"> 
		
		<label for="nome">Nome:</label><br> 
		<input style="font-family: Roboto-Serif; font-size: 1rem;" name="nome" type="text" maxlength="20" required placeholder="Inserisci nome"><br>

        <label for="tipo">Tipo:</label><br>
            <select id="tipo" name="tipo" style="font-family: Roboto-Serif; font-size: 1rem;">
                <option value="Asse">Asse</option>
                <option value="Carrello">Carrello</option>
                <option value="Cuscinetti">Cuscinetti</option>
                <option value="Ruote">Ruote</option>
		    </select><br>
		<label for="descrizione">Descrizione:</label><br>
		<textarea style="font-family: Roboto-Serif; font-size: 1rem;" name="descrizione" maxlength="100" rows="3" required placeholder="Inserisci descrizione"></textarea><br>
		
		<label for="prezzo">Prezzo:</label><br> 
        <input style="font-family: Roboto-Serif; font-size: 1rem;" name="prezzo" type="text" pattern="^\d+(\.\d{1,2})?$" title="Inserisci un numero valido. Massimo due cifre decimali." required><br>

		<label for="quantita">Quantita:</label><br> 
		<input style="font-family: Roboto-Serif; font-size: 1rem;" name="quantita" type="number" min="1" value="1" required><br>

		<input type="submit" value="Aggiungi"><input type="reset" value="Cancella">

	</form>
	</div>
	<div style="display: flex; justify-content: center; text-align: center;">
	<h2 style="color: black; font-weight: bold; margin-bottom: 0.3125rem; margin-top: 1.625rem;">ORDINI</h2>
	</div>
	<div class="table-responsive-admin">
		<table id="ordini" border="1" style="background-color: rgba(238, 191, 112, 1); margin-top: 1rem;">
			<thead>
				<tr>
					<th>ID Ordine</th>
					<th>ID Cliente</th>
					<th>Data Ordine</th>
					<th>Dettagli Ordine</th>
				</tr>
			</thead>
			<tbody>
				<% for (OrderBean order : (List<OrderBean>) orders) { %>
					<tr>
						<td style="text-align: center;"><%= order.getId() %></td>
						<td style="text-align: center;"><%= order.getUserid() %></td>
						<td style="text-align: center;"><%= order.getDataOrdine() %></td>
						<td style="text-align: center;"><a href="ProductControl?action=readdetailsorder&id=<%=order.getId()%>" style="margin-left: 0.625rem;"><i class="fa fa-info-circle" aria-hidden="true"></i></a></td>
					</tr>
				<% } %>
			</tbody>
		</table>
	</div>
	<%
		}
	}
	%>
<%@ include file="footer.jsp" %>