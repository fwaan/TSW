<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ include file="header.jsp" %>
<%@ page import="it.unisa.OrderBean" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    OrderBean ordine = (OrderBean) request.getAttribute("ordine");
%>
<style>
    th,td{
        font-size: 1.25rem;
    }
    @media (max-width: 1150px) {
        th,td{
        font-size: 1rem;
        }
    }
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
    min-width: 23rem;
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
    <h3 style="color: black; text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;"><a href="amministratore-yourskates.jsp" style="text-decoration: none; color: black; text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;"><i class="fa fa-arrow-circle-left" aria-hidden="true" style="font-size: 3rem;"></i></a></h3>
    <div style="display: flex; justify-content: center; align-items: center; flex-direction: column;">
    <h2 style="color: black; font-family: Titoli-Skateboard; letter-spacing: 0.05rem; text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white; font-size: 3rem;">Dettagli</h2>
    <%
        if (ordine != null) {
    %>
    <div class="table-container">
        <table style="background-color: rgba(238, 191, 112, 1); width: 100%; border: 1px solid black;border-collapse: collapse;">
            <tr class="desktop-header" style="border: 1px solid black;">
                <th style="border-right: 1px solid black;">ID</th>
                <th style="border-right: 1px solid black;">User ID</th>
                <th style="border-right: 1px solid black;">Tipo Skateboard</th>
                <th style="border-right: 1px solid black;">Colore</th>
                <th style="border-right: 1px solid black;">ID Asse</th>
                <th style="border-right: 1px solid black;">ID Carrello</th>
                <th style="border-right: 1px solid black;">ID Cuscinetti</th>
                <th style="border-right: 1px solid black;">ID Ruote</th>
                <th style="border-right: 1px solid black;">Prezzo</th>
                <th style="border-right: 1px solid black;">Indirizzo</th>
                <th style="border-right: 1px solid black;">Città</th>
                <th style="border-right: 1px solid black;">Provincia</th>
                <th style="border-right: 1px solid black;">CAP</th>
                <th>Data Ordine</th>
            </tr>
            <tr>
                <td data-column="ID" style="background-color: white; text-align: center; border-right: 1px solid black;"><%= ordine.getId() %></td>
                <td data-column="User ID" style="background-color: white; text-align: center; border-right: 1px solid black;"><%= ordine.getUserid() %></td>
                <td data-column="Tipo Skateboard" style="background-color: white; text-align: center; border-right: 1px solid black;"><%= ordine.getTipoSkateboard() %></td>
                <td data-column="Colore" style="background-color: white; text-align: center; border-right: 1px solid black;"><%= ordine.getColore() %></td>
                <td data-column="ID Asse" style="background-color: white; text-align: center; border-right: 1px solid black;"><%= ordine.getIdAsse() %></td>
                <td data-column="ID Carrello" style="background-color: white; text-align: center; border-right: 1px solid black;"><%= ordine.getIdCarrello() %></td>
                <td data-column="ID Cuscinetti" style="background-color: white; text-align: center; border-right: 1px solid black;"><%= ordine.getIdCuscinetti() %></td>
                <td data-column="ID Ruote" style="background-color: white; text-align: center; border-right: 1px solid black;"><%= ordine.getIdRuote() %></td>
                <td data-column="Prezzo" style="background-color: white; text-align: center; border-right: 1px solid black;"><%= String.format("%.2f €", ordine.getPrezzo()) %></td>
                <td data-column="Indirizzo" style="background-color: white; text-align: center; border-right: 1px solid black;"><%= ordine.getIndirizzo() %></td>
                <td data-column="Città" style="background-color: white; text-align: center; border-right: 1px solid black;"><%= ordine.getCitta() %></td>
                <td data-column="Provincia" style="background-color: white; text-align: center; border-right: 1px solid black;"><%= ordine.getProvincia() %></td>
                <td data-column="CAP" style="background-color: white; text-align: center; border-right: 1px solid black;"><%= ordine.getCAP() %></td>
                <td data-column="Data Ordine" style="background-color: white; text-align: center;"><%= ordine.getDataOrdine() %></td>
            </tr>
        </table>
    </div>
    </div>
    <%
        }
    %>
<%@ include file="footer.jsp" %>