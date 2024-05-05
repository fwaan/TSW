<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ include file="header.jsp" %>
<%@ page import="it.unisa.ProductBean" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    ProductBean prodotto = (ProductBean) request.getAttribute("prodotto");
%>
    <h3 style="color: white;"><a href="amministratore-yourskates.jsp" style="text-decoration: none; color: white;"><i class="fa fa-arrow-circle-left" aria-hidden="true"></i></a></h3>
    <div style="display: flex; justify-content: center; align-items: center; flex-direction: column;">
    <h2 style="color: white;">Dettagli</h2>
    <form action="ProductControl?action=change" method="post">
    <%
        if (prodotto != null) {
    %>
    <table border="1" style="background-color: #90EE90; width: 100%;">
        <tr>
            <th>ID</th>
            <th>Tipo</th>
            <th>Nome</th>
            <th>Descrizione</th>
            <th>Prezzo</th>
            <th>Quantita</th>
        </tr>
        <tr>
            <td><input type="text" name="id" value="<%=prodotto.getId()%>" readonly></td>
            <td>
                <select id="tipo" name="tipo">
                    <option value="Asse" <%=prodotto.getTipo().equals("Asse") ? "selected" : ""%>>Asse</option>
                    <option value="Carrello" <%=prodotto.getTipo().equals("Carrello") ? "selected" : ""%>>Carrello</option>
                    <option value="Cuscinetti" <%=prodotto.getTipo().equals("Cuscinetti") ? "selected" : ""%>>Cuscinetti</option>
                    <option value="Ruote" <%=prodotto.getTipo().equals("Ruote") ? "selected" : ""%>>Ruote</option>
                </select>
            </td>
            <td><input name="nome" type="text" maxlength="20" required placeholder="Inserisci nome" value="<%=prodotto.getNome()%>"></td>
            <td><textarea name="descrizione" maxlength="100" rows="3" required><%=prodotto.getDescrizione()%></textarea></td>
            <td><input name="prezzo" type="text" pattern="^\d+(\.\d{1,2})?$" title="Inserisci un numero valido. Massimo due cifre decimali." required value="<%=prodotto.getPrezzo()%>"></td>
            <td><input name="quantita" type="number" min="1" value="<%=prodotto.getQuantita()%>" required></td>
        </tr>
    </table>
    <input type="submit" value="Modifica" style="width: 100%; height: 3.125rem;"><br>
	<%
		if("true".equals(request.getAttribute("verificatarocca"))){
	%>
    	<p style="text-align: center; color: white; font-weight: bold;"><i class="fa fa-check-circle" aria-hidden="true" style="margin-right: 0.3125rem;"></i>Modifica avvenuta con successo<i class="fa fa-check-circle" aria-hidden="true" style="margin-left: 0.3125rem;"></i></p>
	<%
	}
	%>
    <%
        }
    %>
    </form>
    </div>
<%@ include file="footer.jsp" %>