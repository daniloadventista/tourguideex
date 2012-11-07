package tourguide;

import java.io.IOException;
import javax.servlet.http.*;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

@SuppressWarnings("serial")
public class LoginServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		UserService userService = UserServiceFactory.getUserService();
		//todo fazer pagina de login
       	resp.sendRedirect(userService.createLoginURL(req.getRequestURI()));
	}
}