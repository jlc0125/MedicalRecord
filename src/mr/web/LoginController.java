package mr.web;

import java.io.IOException;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jasig.cas.client.authentication.AttributePrincipal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import mr.domain.User;
import mr.service.UserService;

@Controller
@RequestMapping(value = "/user")
public class LoginController {

	@Autowired
	private UserService userService;

	@RequestMapping(value = "/loginpage")
	public void login(HttpServletRequest request, HttpServletResponse response) {
		AttributePrincipal principal = (AttributePrincipal) request
				.getUserPrincipal();
		if (null != principal) {
			Map<String, Object> attributes = principal.getAttributes();
			String userName = (String) attributes.get("userName");
			if (null != userName) {
				User user = new User();
				user.setName(userName);
				request.getSession().setAttribute("user", user);
			}
			String preHref = request.getQueryString().split("=")[1];
			try {
				response.sendRedirect(preHref);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			String target = request.getRequestURL() + "?"
					+ request.getQueryString();
			try {
				response.sendRedirect("https://sso.ckcest.cn/login?service="
						+ target);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	@RequestMapping(value = "/logout")
	public void logout(HttpServletRequest request, HttpServletResponse response) {
		User user = (User) request.getSession().getAttribute("user");
		if (null == user) {
			String preHref = request.getQueryString().split("=")[1];
			try {
				response.sendRedirect(preHref);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return;
		} else {
			String target = request.getRequestURL() + "?" + request.getQueryString();
			request.getSession().invalidate();
			try {
				response.sendRedirect("https://sso.ckcest.cn/logout?service=" + target);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	@RequestMapping(value="registpage")
	public void regist(HttpServletRequest request,HttpServletResponse response){
		try {
			response.sendRedirect("http://www.ckcest.cn/portal/register");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
