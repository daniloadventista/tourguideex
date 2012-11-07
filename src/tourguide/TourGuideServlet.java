package tourguide;

import java.io.IOException;
import javax.servlet.http.*;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

@SuppressWarnings("serial")
public class TourGuideServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();

        if (user != null) {
            resp.setContentType("text/html");
            resp.getWriter().println("Hello, " + user.getNickname());
        } else {
        	resp.getWriter().println("<html>");
        	resp.getWriter().println("<body>");
        	resp.getWriter().println("Hello <a href='login'>log in</a></li>");
        	resp.getWriter().println("</body>");
        	resp.getWriter().println("</html>");
        	//resp.sendRedirect(userService.createLoginURL(req.getRequestURI()));
        }
	}
}
