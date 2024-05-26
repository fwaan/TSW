<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ include file="header.jsp" %>
<%@ page import="it.unisa.ProductBean" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    ProductBean prodotto = (ProductBean) request.getAttribute("prodotto");
%>
<style>
    @media (min-width: 991px) {
        .desktop-header {
            display: table-row !important;
        }
    }

    /* Stili per dispositivi con larghezza schermo inferiore a 600px */
    @media (max-width: 990px) {
        .desktop-header {
            display: none !important;
        }
        .table-container table {
    width: 100%;  /* Aumenta la larghezza al 100% */
    min-width: 25rem;
}

        .table-container table,
        .table-container thead,
        .table-container tbody,
        .table-container th,
        .table-container td,
        .table-container tr {
            display: block;
        }

        .table-container tr {
            border: 1px solid #ccc;
        }

        .table-container td {
            border: none;
            border-bottom: 1px solid #eee;
            position: relative;
            padding-left: 50%;
            text-align: right;
        }

        .table-container td:before {
            position: absolute;
            top: 6px;
            left: 6px;
            width: 45%;
            padding-right: 10px;
            white-space: nowrap;
            content: attr(data-column);
            text-align: left;
            font-weight: bold;
        }
    }
</style>
    <h3 style="color: white;"><a href="amministratore-yourskates.jsp" style="text-decoration: none; color: white;"><i class="fa fa-arrow-circle-left" aria-hidden="true"></i></a></h3>
    <div style="display: flex; justify-content: center; align-items: center; flex-direction: column;">
    <h2 style="color: white;">Dettagli</h2>
    <form action="ProductControl?action=change" method="post">
    <%
        if (prodotto != null) {
    %>
    <div class="table-container">
        <table border="1" style="background-color: rgba(238, 191, 112, 1); width: 100%;">
            <tr class="desktop-header">
                <th>ID</th>
                <th>Tipo</th>
                <th>Nome</th>
                <th>Descrizione</th>
                <th>Prezzo</th>
                <th>Quantita</th>
            </tr>
            <tr>
                <td data-column="ID"><input type="text" name="id" value="<%=prodotto.getId()%>" readonly></td>
                <td data-column="Tipo">
                    <select id="tipo" name="tipo">
                        <option value="Asse" <%=prodotto.getTipo().equals("Asse") ? "selected" : ""%>>Asse</option>
                        <option value="Carrello" <%=prodotto.getTipo().equals("Carrello") ? "selected" : ""%>>Carrello</option>
                        <option value="Cuscinetti" <%=prodotto.getTipo().equals("Cuscinetti") ? "selected" : ""%>>Cuscinetti</option>
                        <option value="Ruote" <%=prodotto.getTipo().equals("Ruote") ? "selected" : ""%>>Ruote</option>
                    </select>
                </td>
                <td data-column="Nome"><input name="nome" type="text" maxlength="20" required placeholder="Inserisci nome" value="<%=prodotto.getNome()%>"></td>
                <td data-column="Descrizione"><textarea name="descrizione" maxlength="100" rows="3" required><%=prodotto.getDescrizione()%></textarea></td>
                <td data-column="Prezzo"><input name="prezzo" type="text" pattern="^\d+(\.\d{1,2})?$" title="Inserisci un numero valido. Massimo due cifre decimali." required value="<%=prodotto.getPrezzo()%>"></td>
                <td data-column="Quantita"><input name="quantita" type="number" min="1" value="<%=prodotto.getQuantita()%>" required></td>
            </tr>
        </table>
    </div>
    <input type="submit" value="Modifica" style="width: 100%; height: 3.125rem;font-family: Titoli-Skateboard;
    text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;
    font-size: 2rem;
    margin-top: 0.125rem;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    background-color: #4CAF50;"><br>
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