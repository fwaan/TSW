package it.unisa;

import java.util.Date;
import java.util.Calendar;
import java.util.Iterator;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.TimeZone;
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

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.draw.VerticalPositionMark;
import com.google.gson.Gson;

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
							String indirizzo = request.getParameter("indirizzo");
							String citta = request.getParameter("citta");
							String provincia = request.getParameter("provincia");
							String cap = request.getParameter("cap");
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
							user.setUserid(userid);
							user.setIndirizzo(indirizzo);
							user.setCitta(citta);
							user.setProvincia(provincia);
							user.setCAP(cap);
							model.doChangeUserLocation(user);

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
				} else if (action.equalsIgnoreCase("generateInvoice")) {
					OrderBean order = model.doRetrieveByKeyOrder(Integer.parseInt(request.getParameter("orderId")));
					String invoicePath = generateInvoice(response, order);
    				String invoiceUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/invoices/invoice"+request.getParameter("orderId")+".pdf";
    				response.setContentType("application/json");
    				response.getWriter().write("{\"url\": \"" + invoiceUrl + "\"}");
				} else if (action.equalsIgnoreCase("verificaEmail")) {
					String userid = request.getParameter("email");
					UserBean existingUser = model.doRetrieveByKeyUser(userid);
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					if(existingUser != null){
						//utente già registrato
						response.getWriter().write("{\"exists\": true}");
					} else{
						//utente non registrato
						response.getWriter().write("{\"exists\": false}");
					}
				} else if (action.equalsIgnoreCase("checkInvoice")) {
					int orderId = Integer.parseInt(request.getParameter("orderId"));
					boolean invoiceReady = isInvoiceReady(orderId);
				
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					// Create the JSON string manually
					String jsonResponse;
					if (invoiceReady) {
						String invoiceUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/invoices/invoice"+orderId+".pdf";
						jsonResponse = "{\"invoiceReady\": true, \"url\": \"" + invoiceUrl + "\"}";
					} else {
						jsonResponse = "{\"invoiceReady\": false}";
					}
					response.getWriter().write(jsonResponse);
				} else if (action.equalsIgnoreCase("addCartSkateboard")) {
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
				} else if (action.equalsIgnoreCase("readdetailsorder")) {
					int id = Integer.parseInt(request.getParameter("id"));
					request.removeAttribute("ordine");
					request.setAttribute("ordine", model.doRetrieveByKeyOrder(id));
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/dettagli-ordine.jsp");
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
				} else if(action.equalsIgnoreCase("changeUserPM")){
					//Cambiamento metodo di pagamento
					String userid = request.getParameter("userid");
					String metodo_pagamento = request.getParameter("payment-method");
					if ("credit-card".equals(metodo_pagamento)){
						metodo_pagamento = "Carta di credito";
					}
					if ("paypal".equals(metodo_pagamento)){
						metodo_pagamento = "PayPal";
					}

					UserBean bean = new UserBean();
					bean.setUserid(userid);
					bean.setMetodoPagamento(metodo_pagamento);
					model.doChangeUserPaymentMethod(bean);

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
					request.removeAttribute("ordiniAmministratore");
					request.setAttribute("ordiniAmministratore",model.doRetrieveAllOrder());
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

	private String generateInvoice(HttpServletResponse response, OrderBean order) {
		String filePath = null;
		try {
			// Create a new Document
			Document document = new Document();

			filePath = getServletContext().getRealPath("/invoices/invoice"+String.valueOf(order.getId())+".pdf");
			// Create a new PdfWriter
			PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(new File(filePath)));

			document.open();

			// Set the font
			Font font = FontFactory.getFont("Arial", 24, Font.BOLD, BaseColor.BLACK);

			// Add the invoice title
			document.add(new Paragraph("FATTURA", font));

			// Add the logo
			Image logo = Image.getInstance(getServletContext().getRealPath("/immagini/gatto-skate.png"));
			logo.scaleToFit(100, 100);
			float yPos = PageSize.A4.getHeight() - logo.getScaledHeight() - (PageSize.A4.getHeight() * 0.05f);
			logo.setAbsolutePosition(PageSize.A4.getWidth() - logo.getScaledWidth() - (PageSize.A4.getWidth() * 0.05f), yPos);
			document.add(logo);

			// Add the company name
			font = FontFactory.getFont("Arial", 16, Font.NORMAL, BaseColor.BLACK);
			document.add(new Paragraph("YourSkates", font));
			document.add(new Chunk("\n"));

			// Add the bill to information
			document.add(new Phrase("INDIRIZZO FATTURA:"));
			document.add(new Paragraph(order.getIndirizzo()+ ", " + order.getCitta() + ", " + order.getProvincia() + ", " + order.getCAP(), font));
			document.add(new Chunk("\n"));

			// Create a new PdfPTable with 2 columns
			// Create a new PdfPTable with 2 columns
			PdfPTable tableheader = new PdfPTable(2);
			tableheader.setWidthPercentage(100);

			// Add the invoice number to the left cell
			Phrase phrase = new Phrase();
			phrase.add(new Chunk("FATTURA #: "));
			phrase.add(new Chunk(String.valueOf(order.getId()), FontFactory.getFont("Arial", 16, Font.NORMAL, BaseColor.BLACK)));
			PdfPCell cell = new PdfPCell(phrase);
			cell.setHorizontalAlignment(Element.ALIGN_LEFT);
			cell.setBorder(Rectangle.NO_BORDER);
			tableheader.addCell(cell);

			// Add the invoice date to the right cell
			phrase = new Phrase();
			phrase.add(new Chunk("DATA FATTURA: "));
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
			// Get the date in the original timezone
			Date originalDate = order.getDataOrdine();

			// Create a calendar and set its time with the original date
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(originalDate);

			// Add 2 hours to the calendar time
			calendar.add(Calendar.HOUR_OF_DAY, -2);

			// Create a new date with the adjusted time
			Date adjustedDate = calendar.getTime();

			// Format the adjusted date
			phrase.add(new Chunk(sdf.format(adjustedDate)));
			cell = new PdfPCell(phrase);
			cell.setHorizontalAlignment(Element.ALIGN_LEFT);
			cell.setBorder(Rectangle.NO_BORDER);
			tableheader.addCell(cell);

			// Add the table to the document
			document.add(tableheader);

			// Create a new PdfPTable for the description and amount table
			PdfPTable table = new PdfPTable(3); // 3 colonne
			table.setWidthPercentage(100);
			table.setSpacingBefore(20);

			// Add the table headers
			cell = new PdfPCell(new Phrase("QUANTITA"));
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setBorder(Rectangle.NO_BORDER);
			table.addCell(cell);

			cell = new PdfPCell(new Phrase("DESCRIZIONE"));
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setBorder(Rectangle.NO_BORDER);
			table.addCell(cell);

			cell = new PdfPCell(new Phrase("PREZZO"));
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setBorder(Rectangle.NO_BORDER);
			table.addCell(cell);

			// Add the table row
			cell = new PdfPCell(new Phrase("1")); // Quantità
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setBorder(Rectangle.NO_BORDER);
			table.addCell(cell);

			cell = new PdfPCell(new Phrase(order.getTipoSkateboard())); // Descrizione
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setBorder(Rectangle.NO_BORDER);
			table.addCell(cell);

			float totaleprezzo = order.getPrezzo();
			float iva = totaleprezzo * 22 / 100;
			float subtotale = totaleprezzo - iva;

			cell = new PdfPCell(new Phrase("€"+String.valueOf(subtotale))); // Prezzo
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setBorder(Rectangle.NO_BORDER);
			table.addCell(cell);
			cell = new PdfPCell(new Phrase(" "));
			cell.setBorder(Rectangle.NO_BORDER);
			table.addCell(cell);
			cell = new PdfPCell(new Phrase(" "));
			cell.setBorder(Rectangle.NO_BORDER);
			table.addCell(cell);
			cell = new PdfPCell(new Phrase(" "));
			cell.setBorder(Rectangle.NO_BORDER);
			table.addCell(cell);

			// Add the subtotal, IVA, and total information
			cell = new PdfPCell(new Phrase("")); // Celda vacía para la cantidad
			cell.setBorder(Rectangle.NO_BORDER);
			table.addCell(cell);

			cell = new PdfPCell(new Phrase("Subtotale  :"));
			cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
			cell.setBorder(Rectangle.NO_BORDER);
			table.addCell(cell);

			cell = new PdfPCell(new Phrase("€"+String.valueOf(subtotale)));
			cell.setBorder(Rectangle.NO_BORDER);
			table.addCell(cell);

			cell = new PdfPCell(new Phrase("")); // Celda vacía para la cantidad
			cell.setBorder(Rectangle.NO_BORDER);
			table.addCell(cell);

			cell = new PdfPCell(new Phrase("IVA 22.0%:"));
			cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
			cell.setBorder(Rectangle.NO_BORDER);
			table.addCell(cell);

			cell = new PdfPCell(new Phrase("€"+String.valueOf(iva)));
			cell.setBorder(Rectangle.NO_BORDER);
			table.addCell(cell);

			font = FontFactory.getFont("Arial", 16, Font.BOLD, BaseColor.BLACK);
			cell = new PdfPCell(new Phrase("")); // Celda vacía para la cantidad
			cell.setBorder(Rectangle.NO_BORDER);
			table.addCell(cell);

			cell = new PdfPCell(new Phrase("TOTALE", font));
			cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
			cell.setBorder(Rectangle.NO_BORDER);
			table.addCell(cell);

			cell = new PdfPCell(new Phrase("€"+String.valueOf(totaleprezzo), font));
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setBorder(Rectangle.NO_BORDER);
			table.addCell(cell);

			// Add the table to the document
			document.add(table);

			// Close the Document
			document.close();

			// Close the PdfWriter
			writer.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return filePath;
	}

	public boolean isInvoiceReady(int orderId) {
		String filePath = getServletContext().getRealPath("/invoices/invoice" + orderId + ".pdf");
		File file = new File(filePath);
		return file.exists();
	}

	public class JsonResponse {
		private String status;
	
		public JsonResponse(String status) {
			this.status = status;
		}
	
		public String getStatus() {
			return status;
		}
	
		public void setStatus(String status) {
			this.status = status;
		}
	}

}