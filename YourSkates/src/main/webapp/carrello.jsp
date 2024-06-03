<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="it.unisa.ProductModelDS" %>
<%@ page import="it.unisa.CartBean, it.unisa.SkateboardBean, it.unisa.ProductBean, it.unisa.UserBean" %>
<%@ include file="header.jsp" %>
<style>
    #cart-title{
        font-family: Titoli-Skateboard;
        text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;
    }
    #cart-container{
        background-color: #f2f2f2;
    }
    .table-container{
        overflow-x: auto;
    }
    table{
        border-collapse: collapse;
        width: 100%; /* Aggiunto per rendere la tabella reattiva */
    }
    td, th {
        font-family: Roboto-Serif;
        border: 0.1875rem solid black;
        padding: 0; /* Rimuovi padding dalla cella della tabella */
        min-width: 6.25rem;
    }
    th{
        font-size: 1.25rem;
    }
    td{
        text-align: center;
        font-weight: bold;
    }
    .img-column {
        width: 25%;
        height: auto;
    }
    .img-column img {
        width: 100%;
        height: auto;
    }
    .full-width-button {
        width: 100%;
        height: 3.125rem;
    }
    .delete-button {
        display: block; /* Imposta il display a block */
        width: 100%;
        height: 100%;
        padding: 100% 0;
        background-color: #f2f2f2;
        border: none;
        cursor:pointer;
    }
    .fa-trash {
        font-size: 4rem; /* Imposta la dimensione dell'icona */
        color: red;
    }
    @media (max-width: 600px) {
        #cart-title {
            font-size: 1.5em;
        }
        td, th {
            min-width: 1rem;
        }
        .fa-trash {
            font-size: 0.75rem;
        }
    }
    @media (max-width: 750px) {
        td, th {
            min-width: 1.5625rem;
        }
        .fa-trash {
            font-size: 1rem;
        }
    }
    @media (max-width: 900px) {
        td, th {
            min-width: 3.125rem;
        }
        .fa-trash {
            font-size: 2rem;
        }
    }
    @media (min-width: 900px) and (max-width: 1200px){
        td, th{
            min-width: 4.375rem;
        }
        .fa-trash{
            font-size: 3rem;
        }
    }
</style>
<div id="cart-container">
    <h1 id="cart-title">CARRELLO</h1>
    <%
        CartBean cart = (CartBean) session.getAttribute("cart");
        if (cart != null && !cart.getSkateboards().isEmpty()) {
            out.println("<div class='table-container'>");
            out.println("<table>");
            out.println("<tr><th class='img-column'>IMMAGINE</th><th>TIPO</th><th>ASSE</th><th>CARRELLO</th><th>CUSCINETTI</th><th>RUOTE</th><th>PREZZO</th><th>RIMUOVI</th></tr>");
            for (SkateboardBean skateboard : cart.getSkateboards()) {
                out.println("<tr>");
                String tipo = skateboard.getTipo().toLowerCase();
                String colore = skateboard.getColore();
                String imgSrc = "immagini/" + tipo;
                if (!colore.equals("nero")) {
                    imgSrc += "_" + colore;
                }
                imgSrc += ".png";
                out.println("<td class='img-column'><img src='" + imgSrc + "' alt='" + tipo + "' width='100%'></td>");
                out.println("<td>" + skateboard.getTipo() + "</td>");
                for (ProductBean component : skateboard.getComponents()) {
                    out.println("<td>" + component.getNome() + "</td>");
                }
                out.println("<td>" + String.format("%.2f", skateboard.getTotalPrice()) + "\u20AC</td>");
                out.println("<td><form action='ProductControl' method='post'>"
                    + "<input type='hidden' name='action' value='deleteCart'>"
                    + "<input type='hidden' name='skateboardId' value='" + skateboard.getId() + "'>"
                    + "<button type='submit' class='delete-button'><i class='fa fa-trash' aria-hidden='true'></i></button>"
                    + "</form></td>");
                out.println("</tr>");
            }
            out.println("</table>");
            out.println("</div>");
            String userid = (String) session.getAttribute("userid"); %>
            <% if (userid != null) {
                boolean canPurchase = true;
                boolean indirizzoinserito = true;
                boolean metodopagamentoinserito = true;
                String outOfStockComponent = null;
                Map<String, Integer> componentQuantities = new HashMap<>();
                for (SkateboardBean skateboard : cart.getSkateboards()) {
                    for (ProductBean component : skateboard.getComponents()) {
                        // Aggiorna la quantità del componente
                        ProductModelDS productModelDS = new ProductModelDS();
                        component = productModelDS.doRetrieveByKey(component.getId());
                        componentQuantities.put(component.getNome(), componentQuantities.getOrDefault(component.getNome(), 0) + 1);
                        if (component.getQuantita() < componentQuantities.get(component.getNome())) {
                            canPurchase = false;
                            outOfStockComponent = component.getNome();
                            break;
                        }
                    }
                    if (!canPurchase) {
                        break;
                    }
                }
            
                // Verifica che l'utente abbia un indirizzo, città, provincia e CAP nel database
                ProductModelDS productModelDS = new ProductModelDS();
                UserBean user = productModelDS.doRetrieveByKeyUser(userid);
                if (user.getIndirizzo() == null || user.getCitta() == null || user.getProvincia() == null || user.getCAP() == null) {
                    canPurchase = false;
                    indirizzoinserito = false;
                }
                if (user.getMetodoPagamento() == null || user.getMetodoPagamento().isEmpty()){
                    canPurchase = false;
                    metodopagamentoinserito = false;
                }
            
                if (canPurchase) { %>
                    <form action="ProductControl" method="post">
                        <input type='hidden' name='action' value='saveOrder'>
                        <button type='submit' class='full-width-button'>Finalizza l'acquisto</button>
                    </form>
                <% } else if (outOfStockComponent != null) { %>
                    <p style='text-align: center; font-family: Roboto-Serif; font-size: 1.75rem; font-weight: bold;'>Abbiamo esaurito il componente <%= outOfStockComponent %> nel tuo ordine, rimuovilo o attendi che viene rifornito per completare l'acquisto</p>
                <% } else if (indirizzoinserito == false) { %>
                    <p style='text-align: center; font-family: Roboto-Serif; font-size: 1.75rem; font-weight: bold;'>Per completare l'acquisto, <a href="utente.jsp?checkbox=attiva">aggiungi il tuo indirizzo, città, provincia e CAP nel tuo profilo</a></p>
                <% } else if (metodopagamentoinserito == false) { %>
                    <p style='text-align: center; font-family: Roboto-Serif; font-size: 1.75rem; font-weight: bold;'>Per completare l'acquisto, <a href="utente.jsp?checkbox=attiva">aggiungi un metodo di pagamento nel tuo profilo</a></p>
                <%

                }
            } else { %>
                <p style='text-align: center; font-family: Roboto-Serif; font-size: 1.75rem; font-weight: bold;'><a href="utente.jsp">Accedi per finalizzare l'acquisto</a></p>
            <% } %>
            <% } else {
            out.println("<p style='text-align: center;'>Il carrello è vuoto.</p>");
        }
    %>
</div>
<%@ include file="footer.jsp" %>