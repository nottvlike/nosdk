package platform;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

/**
 * Servlet implementation class ServletDemoPay
 */
@WebServlet("/ServletDemoPay")
public class ServletDemoPay extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletDemoPay() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		PayResultInfo resultInfo = new PayResultInfo();
		
		resultInfo.amount = request.getParameter("amount");
		resultInfo.currency = request.getParameter("currency");
		resultInfo.productid = request.getParameter("productid");
		resultInfo.orderid = request.getParameter("orderid");
		resultInfo.extradata = request.getParameter("extradata");
		
		if (resultInfo.productid.compareTo("-1") == 0) {
			resultInfo.result = String.valueOf(PayResultInfo.Failed);
			resultInfo.message = "Pay failed Test!";
		}
		else {
			resultInfo.result = String.valueOf(PayResultInfo.SUCCESS);
			resultInfo.message = "";
		}
 		response.getWriter().append(new Gson().toJson(resultInfo));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
