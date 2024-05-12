package it.unisa;

import java.util.Iterator;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.nio.charset.StandardCharsets;
import java.math.BigInteger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ProductControl
 */
public class ProductControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// ProductModelDS usa il DataSource
	// ProductModelDM usa il DriverManager
	static boolean isDataSource = true;

	static ProductModelDS model;

	static {
		model = new ProductModelDS();
	}

	public ProductControl() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		try {
			if (action != null) {
				if (action.equalsIgnoreCase("registrautente")) {
					String userid = request.getParameter("userid");
					String password = request.getParameter("password");
					UserBean existingUser = model.doRetrieveByKeyUser(userid);
					if(existingUser != null){
						//utente già registrato
						request.removeAttribute("registrato");
						request.setAttribute("registrato", "true");
					}
					else{
						//utente non registrato
						try {
							MessageDigest md = MessageDigest.getInstance("SHA-256");
							byte[] hash = md.digest(password.getBytes(StandardCharsets.UTF_8));
							BigInteger number = new BigInteger(1, hash);
							String hashedPassword = number.toString(16);
							while (hashedPassword.length() < 64) {
								hashedPassword = "0" + hashedPassword;
							}
							UserBean user = new UserBean();
							user.setUserid(userid);
							user.setPasswordHash(hashedPassword);
							user.setTipo("Customer");
							model.doSaveUser(user);
							request.removeAttribute("registrato");
							request.setAttribute("registrato", "false");
							request.removeAttribute("registrazione");
							request.setAttribute("registrazione", "successo");
						} catch (NoSuchAlgorithmException | SQLException e) {
							e.printStackTrace();
						}
					}
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/utente.jsp");
					dispatcher.forward(request, response);
				}else if (action.equalsIgnoreCase("addCartSkateboard")) {
					// Ottieni la sessione corrente. Se non esiste, ne crea una nuova.
					HttpSession session = request.getSession();
	
					// Ottieni il carrello dalla sessione. Se non esiste, ne crea uno nuovo.
					CartBean cart = (CartBean) session.getAttribute("cart");
					if (cart == null) {
						cart = new CartBean();
						session.setAttribute("cart", cart);
					}
					SkateboardBean skateboard = new SkateboardBean();
					skateboard.setTipo("Skateboard");
					skateboard.setColore(request.getParameter("colore"));
					skateboard.addComponent(model.doRetrieveByKey(Integer.parseInt(request.getParameter("asse"))));
					skateboard.addComponent(model.doRetrieveByKey(Integer.parseInt(request.getParameter("carrello"))));
					skateboard.addComponent(model.doRetrieveByKey(Integer.parseInt(request.getParameter("cuscinetti"))));
					skateboard.addComponent(model.doRetrieveByKey(Integer.parseInt(request.getParameter("ruote"))));
					cart.addSkateboard(skateboard);
					request.removeAttribute("colore");
					request.removeAttribute("asse");
					request.removeAttribute("carrello");
					request.removeAttribute("cuscinetti");
					request.removeAttribute("ruote");
					request.setAttribute("verificatarocca", "true");
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/skateboard.jsp");
					dispatcher.forward(request, response);
				}else if (action.equalsIgnoreCase("addCartLongboard")) {
					// Ottieni la sessione corrente. Se non esiste, ne crea una nuova.
					HttpSession session = request.getSession();
	
					// Ottieni il carrello dalla sessione. Se non esiste, ne crea uno nuovo.
					CartBean cart = (CartBean) session.getAttribute("cart");
					if (cart == null) {
						cart = new CartBean();
						session.setAttribute("cart", cart);
					}
					SkateboardBean skateboard = new SkateboardBean();
					skateboard.setTipo("Longboard");
					skateboard.setColore(request.getParameter("colore"));
					skateboard.addComponent(model.doRetrieveByKey(Integer.parseInt(request.getParameter("asse"))));
					skateboard.addComponent(model.doRetrieveByKey(Integer.parseInt(request.getParameter("carrello"))));
					skateboard.addComponent(model.doRetrieveByKey(Integer.parseInt(request.getParameter("cuscinetti"))));
					skateboard.addComponent(model.doRetrieveByKey(Integer.parseInt(request.getParameter("ruote"))));
					cart.addSkateboard(skateboard);
					request.removeAttribute("colore");
					request.removeAttribute("asse");
					request.removeAttribute("carrello");
					request.removeAttribute("cuscinetti");
					request.removeAttribute("ruote");
					request.setAttribute("verificatarocca", "true");
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/longboard.jsp");
					dispatcher.forward(request, response);
				}else if (action.equalsIgnoreCase("addCartCruiser")) {
					// Ottieni la sessione corrente. Se non esiste, ne crea una nuova.
					HttpSession session = request.getSession();
	
					// Ottieni il carrello dalla sessione. Se non esiste, ne crea uno nuovo.
					CartBean cart = (CartBean) session.getAttribute("cart");
					if (cart == null) {
						cart = new CartBean();
						session.setAttribute("cart", cart);
					}
					SkateboardBean skateboard = new SkateboardBean();
					skateboard.setTipo("Cruiser");
					skateboard.setColore(request.getParameter("colore"));
					skateboard.addComponent(model.doRetrieveByKey(Integer.parseInt(request.getParameter("asse"))));
					skateboard.addComponent(model.doRetrieveByKey(Integer.parseInt(request.getParameter("carrello"))));
					skateboard.addComponent(model.doRetrieveByKey(Integer.parseInt(request.getParameter("cuscinetti"))));
					skateboard.addComponent(model.doRetrieveByKey(Integer.parseInt(request.getParameter("ruote"))));
					cart.addSkateboard(skateboard);
					request.removeAttribute("colore");
					request.removeAttribute("asse");
					request.removeAttribute("carrello");
					request.removeAttribute("cuscinetti");
					request.removeAttribute("ruote");
					request.setAttribute("verificatarocca", "true");
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/cruiser.jsp");
					dispatcher.forward(request, response);
				} else if (action.equalsIgnoreCase("loginutente")) {
					String userid = request.getParameter("userid");
					String password = request.getParameter("password");
					UserBean existingUser = model.doRetrieveByKeyUser(userid);
					if(existingUser == null){
						//utente non esistente
						request.removeAttribute("utenteinesistente");
						request.setAttribute("utenteinesistente", "true");
					}
					else{
						//utente esistente
						try {
							MessageDigest md = MessageDigest.getInstance("SHA-256");
							byte[] hash = md.digest(password.getBytes(StandardCharsets.UTF_8));
							BigInteger number = new BigInteger(1, hash);
							String hashedPassword = number.toString(16);
							while (hashedPassword.length() < 64) {
								hashedPassword = "0" + hashedPassword;
							}
							UserBean user = model.doCheckUser(userid, hashedPassword);
							if(user == null){
								//password errata
								request.removeAttribute("passworderrata");
								request.setAttribute("passworderrata", "true");
							}
							else{
								//password corretta
								request.getSession().removeAttribute("userid");
								request.getSession().removeAttribute("tipo");
								request.getSession().removeAttribute("user");
								request.getSession().setAttribute("userid", userid);
								request.getSession().setAttribute("tipo", user.getTipo());
								request.getSession().setAttribute("user", user);
							}
						} catch (NoSuchAlgorithmException | SQLException e) {
							e.printStackTrace();
						}
					}
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/utente.jsp");
					dispatcher.forward(request, response);
				} else if (action.equalsIgnoreCase("logoututente")) {
					request.getSession().invalidate();
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/utente.jsp");
					dispatcher.forward(request, response);
				}
				if (action.equalsIgnoreCase("read")) {
					int id = Integer.parseInt(request.getParameter("id"));
					request.removeAttribute("prodotto");
					request.setAttribute("prodotto", model.doRetrieveByKey(id));
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/amministratore-yourskates.jsp");
					dispatcher.forward(request, response);
				} else if (action.equalsIgnoreCase("readdetails")) {
					int id = Integer.parseInt(request.getParameter("id"));
					request.removeAttribute("prodotto");
					request.setAttribute("prodotto", model.doRetrieveByKey(id));
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/dettagli-prodotto.jsp");
					dispatcher.forward(request, response);
				} else if (action.equalsIgnoreCase("delete")) {
					int id = Integer.parseInt(request.getParameter("id"));
					model.doDelete(id);

					request.removeAttribute("prodotti");
					request.setAttribute("prodotti",model.doRetrieveAll("id"));

					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/amministratore-yourskates.jsp");
					dispatcher.forward(request, response);
				}else if (action.equalsIgnoreCase("deleteCart")) {
					String skateboardId = request.getParameter("skateboardId");
					if (skateboardId != null) {
						CartBean cart = (CartBean) request.getSession().getAttribute("cart");
						if (cart != null) {
							List<SkateboardBean> skateboards = cart.getSkateboards();
							for (Iterator<SkateboardBean> iterator = skateboards.iterator(); iterator.hasNext();) {
								SkateboardBean skate = iterator.next();
								if (skateboardId.equals(skate.getId())) {
									iterator.remove();
									break;
								}
							}
						}
						request.getSession().setAttribute("cart", cart);
					}
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/carrello.jsp");
					dispatcher.forward(request, response);
				} else if (action.equalsIgnoreCase("saveOrder")) {
					String userid = (String) request.getSession().getAttribute("userid");
					CartBean cart = (CartBean) request.getSession().getAttribute("cart");

					if (userid != null && cart != null) {
						try {
							model.doSaveOrder(userid, cart);
							request.getSession().removeAttribute("cart"); // pulisce il carrello
						} catch (SQLException e) {
							// Handle exception
							e.printStackTrace();
						}
					}

					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/utente.jsp");
					dispatcher.forward(request, response);
				} else if (action.equalsIgnoreCase("insert")) {
					String name = request.getParameter("nome");
					String tipo = request.getParameter("tipo");
					String descrizione = request.getParameter("descrizione");
					float prezzo = Float.parseFloat(request.getParameter("prezzo"));
					int quantita = Integer.parseInt(request.getParameter("quantita"));

					ProductBean bean = new ProductBean();
					bean.setNome(name);
					bean.setTipo(tipo);
					bean.setDescrizione(descrizione);
					bean.setPrezzo(prezzo);
					bean.setQuantita(quantita);
					model.doSave(bean);

					request.removeAttribute("prodotti");
					request.setAttribute("prodotti",model.doRetrieveAll("id"));

					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/amministratore-yourskates.jsp");
					dispatcher.forward(request, response);
				} else if (action.equalsIgnoreCase("change")) {
					String name = request.getParameter("nome");
					String tipo = request.getParameter("tipo");
					String descrizione = request.getParameter("descrizione");
					float prezzo = Float.parseFloat(request.getParameter("prezzo"));
					int quantita = Integer.parseInt(request.getParameter("quantita"));
					int id = Integer.parseInt(request.getParameter("id"));

					ProductBean bean = new ProductBean();
					bean.setNome(name);
					bean.setTipo(tipo);
					bean.setDescrizione(descrizione);
					bean.setPrezzo(prezzo);
					bean.setQuantita(quantita);
					bean.setId(id);
					model.doChange(bean);

					request.removeAttribute("prodotto");
					request.setAttribute("prodotto",model.doRetrieveByKey(id));
					request.setAttribute("verificatarocca", "true");

					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/dettagli-prodotto.jsp");
					dispatcher.forward(request, response);
				}else if (action.equalsIgnoreCase("changeUserLocation")){
					String userid = request.getParameter("userid");
					String indirizzo = request.getParameter("indirizzo");
					String citta = request.getParameter("citta");
					String provincia = request.getParameter("provincia");
					String cap = request.getParameter("cap");
				
					UserBean bean = new UserBean();
					bean.setUserid(userid);
					bean.setIndirizzo(indirizzo);
					bean.setCitta(citta);
					bean.setProvincia(provincia);
					bean.setCAP(cap);
					model.doChangeUserLocation(bean);
					bean = model.doRetrieveByKeyUser(userid);

					request.removeAttribute("user");
					request.getSession().setAttribute("user", bean);
				
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/utente.jsp");
					dispatcher.forward(request, response);
				} else if (action.equalsIgnoreCase("skateboard")) {

					request.removeAttribute("prodotti");
					request.setAttribute("prodotti",model.doRetrieveAll("id"));

					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/skateboard.jsp");
					dispatcher.forward(request, response);

				} else if (action.equalsIgnoreCase("longboard")) {
					request.removeAttribute("prodotti");
					request.setAttribute("prodotti",model.doRetrieveAll("id"));

					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/longboard.jsp");
					dispatcher.forward(request, response);
				} else if (action.equalsIgnoreCase("cruiser")) {
					request.removeAttribute("prodotti");
					request.setAttribute("prodotti",model.doRetrieveAll("id"));

					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/cruiser.jsp");
					dispatcher.forward(request, response);
				} else if (action.equalsIgnoreCase("amministratore")) {

					request.removeAttribute("prodotti");
					request.setAttribute("prodotti",model.doRetrieveAll("id"));
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/amministratore-yourskates.jsp");
					dispatcher.forward(request, response);
				}else if (action.equalsIgnoreCase("ordini")) {
					String userid = (String) request.getSession().getAttribute("userid");
				
					if (userid != null) {
						try {
							List<OrderBean> orders = model.doRetrieveByUserid(userid);
							request.setAttribute("ordini", orders);
						} catch (SQLException e) {
							// Handle exception
							e.printStackTrace();
							request.setAttribute("errorMessage", "An error occurred while retrieving orders.");
							RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/error.jsp");
							dispatcher.forward(request, response);
							return; // Important to stop further execution in case of error
						}
					}
				
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/utente.jsp");
					dispatcher.forward(request, response);
				}

			}
			
			request.removeAttribute("prodotti");
			request.setAttribute("prodotti",model.doRetrieveAll("id"));
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
