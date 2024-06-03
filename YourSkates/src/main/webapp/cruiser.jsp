<%@ page import="java.util.List" %>
<%@ page import="it.unisa.ProductBean" %>
<%@ page import="java.util.stream.Collectors" %>

<%
List<ProductBean> assi = null;
List<ProductBean> carrello = null;
List<ProductBean> cuscinetti = null;
List<ProductBean> ruote = null;
List<ProductBean> prodotti = (List<ProductBean>) request.getAttribute("prodotti");
if(prodotti == null){
    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ProductControl?action=cruiser");
    dispatcher.forward(request, response);
    return;
} else {
    assi = prodotti.stream()
    .filter(product -> "Asse".equals(product.getTipo()) && product.getQuantita() > 0)
    .collect(Collectors.toList());
    carrello = prodotti.stream()
    .filter(product -> "Carrello".equals(product.getTipo()) && product.getQuantita() > 0)
    .collect(Collectors.toList());
    cuscinetti = prodotti.stream()
    .filter(product -> "Cuscinetti".equals(product.getTipo()) && product.getQuantita() > 0)
    .collect(Collectors.toList());
    ruote = prodotti.stream()
    .filter(product -> "Ruote".equals(product.getTipo()) && product.getQuantita() > 0)
    .collect(Collectors.toList());
}
%>
<%@ include file="header.jsp" %>
<script>
    function updateImage(color) {
        var imgElement = document.querySelector('.hover-image');
        if (color === 'nero') {
            imgElement.src = 'immagini/cruiser.png';
        } else {
            imgElement.src = 'immagini/cruiser_' + color + '.png';
        }
    }
    function updateDescription(selectElement, descriptionElementId, prezzoElementId) {
        var selectedOption = selectElement.options[selectElement.selectedIndex];
        var description = selectedOption.getAttribute('data-description');
        var prezzo = selectedOption.getAttribute('data-price');

        // Create a temporary div element
        var tempDiv = document.createElement('div');
        // Set its innerHTML with the description
        tempDiv.innerHTML = description;
        // Get the interpreted text
        var interpretedDescription = tempDiv.innerText;

        var descriptionElement = document.getElementById(descriptionElementId);
        descriptionElement.innerHTML = interpretedDescription;
        var text = descriptionElement.innerHTML;
        text = text.replace(/&amp;/g, '&').replace(/&/g, '<span class="special-char">&</span>');
        descriptionElement.innerHTML = text;
        document.getElementById(prezzoElementId).innerText = ' \u20AC ' + prezzo;
    }
    window.onload = function() {
        updateDescription(document.getElementById('asse'), 'asseDescription', 'assePrezzo');
        updateDescription(document.getElementById('carrello'), 'carrelloDescription', 'carrelloPrezzo');
        updateDescription(document.getElementById('cuscinetti'), 'cuscinettiDescription', 'cuscinettiPrezzo');
        updateDescription(document.getElementById('ruote'), 'ruoteDescription', 'ruotePrezzo');
    }
</script>
<style>
    input[type="submit"] {
        background-color: #ffffff;
        color: black;
        padding: 14px 20px;
        border: 2px black solid;
        border-radius: 4px;
        cursor: pointer;
        font-family: Titoli-Skateboard;
        font-size: 1.25rem;
        letter-spacing: 0.05rem;
        text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;
    }
    input[type="submit"]:hover {
        background-color: #b8c6c6;  /* Cambia il colore di sfondo al passaggio del mouse */
    }
</style>
<div class="container">
    <div class="image-container-sell">
        <img src="immagini/cruiser.png" alt="Cruiser" class="hover-image">
    </div>
    <div class="form-container">
        <form action="ProductControl?action=addCartCruiser" method="post">
            <p class="image-caption2">Cruiser</p>
            <div class="radio-container" style="margin-bottom: 0.0625rem;">
                <div class="radio-option">
                    <input type="radio" id="nero" name="colore" value="nero" onclick="updateImage('nero')" style="background-color: black;" checked>
                    <label for="nero">Nero</label>
                </div>
                <div class="radio-option">
                    <input type="radio" id="rosso" name="colore" value="rosso" onclick="updateImage('rosso')" style="background-color: red;">
                    <label for="rosso">Rosso</label>
                </div>
                <div class="radio-option">
                    <input type="radio" id="blu" name="colore" value="blu" onclick="updateImage('blu')" style="background-color: blue;">
                    <label for="blu">Blu</label>
                </div>
                <div class="radio-option">
                    <input type="radio" id="verde" name="colore" value="verde" onclick="updateImage('verde')" style="background-color: green;">
                    <label for="verde" >Verde</label>
                </div>
            </div>
            <br>
            <label for="asse"
            >Asse:</label><br>
            <div class="select-container">
            <select id="asse" name="asse" onchange="updateDescription(this, 'asseDescription', 'assePrezzo')">
                <% if(assi != null) { %>
                    <% for(ProductBean product : assi) { %>
                        <option value="<%= product.getId() %>" data-description="<%= product.getDescrizione() %>" data-price="<%=product.getPrezzo()%>"><%= product.getNome() %></option>
                    <% } %>
                <% } else { %>
                    <option>No products available</option>
                <% } %>
            </select>
            <div id="assePrezzo" style="margin-left: 0.3125rem;"></div>
            </div>
            <div id="asseDescription"
            ></div><br>
            <label for="carrello"
            >Carrello:</label><br>
            <div class="select-container">
            <select id="carrello" name="carrello" onchange="updateDescription(this, 'carrelloDescription', 'carrelloPrezzo')">
                <% if(carrello != null) { %>
                    <% for(ProductBean product : carrello) { %>
                        <option value="<%= product.getId() %>" data-description="<%= product.getDescrizione() %>" data-price="<%=product.getPrezzo()%>"><%= product.getNome() %></option>
                    <% } %>
                <% } else { %>
                    <option>No products available</option>
                <% } %>
            </select>
            <div id="carrelloPrezzo" style="margin-left: 0.3125rem;"></div>
            </div>
            <div id="carrelloDescription"
            ></div><br>
            <label for="cuscinetti"
            >Cuscinetti:</label><br>
            <div class="select-container">
            <select id="cuscinetti" name="cuscinetti" onchange="updateDescription(this, 'cuscinettiDescription', 'cuscinettiPrezzo')">
                <% if(cuscinetti != null) { %>
                    <% for(ProductBean product : cuscinetti) { %>
                        <option value="<%= product.getId() %>" data-description="<%= product.getDescrizione() %>" data-price="<%=product.getPrezzo()%>"><%= product.getNome() %></option>
                    <% } %>
                <% } else { %>
                    <option>No products available</option>
                <% } %>
            </select>
            <div id="cuscinettiPrezzo" style="margin-left: 0.3125rem;"></div>
            </div>
            <div id="cuscinettiDescription"
            ></div><br>
            <label for="ruote"
            >Ruote:</label><br>
            <div class="select-container">
            <select id="ruote" name="ruote" onchange="updateDescription(this, 'ruoteDescription', 'ruotePrezzo')">
                <% if(ruote != null) { %>
                    <% for(ProductBean product : ruote) { %>
                        <option value="<%= product.getId() %>" data-description="<%= product.getDescrizione() %>" data-price="<%=product.getPrezzo()%>"><%= product.getNome() %></option>
                    <% } %>
                <% } else { %>
                    <option>No products available</option>
                <% } %>
            </select>
            <div id="ruotePrezzo" style="margin-left: 0.3125rem;"></div>
            </div>
            <div id="ruoteDescription"
            ></div><br>
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <input type="submit" value="Add to cart">
                <% if("true".equals(request.getAttribute("verificatarocca"))){ %>
                    <p style="text-align: center; font-weight: bold; margin: 0;  font-family: Titoli-Skateboard; letter-spacing: 0.05rem; text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;">
                        <i class="fa fa-check-circle" aria-hidden="true" style="margin-right: 0.3125rem;"></i>
                        Aggiunto al carrello con successo
                        <i class="fa fa-check-circle" aria-hidden="true" style="margin-left: 0.3125rem;"></i>
                    </p>
                <% } %>
            </div>
        </form>
    </div>
</div>
<%@ include file="footer.jsp" %>