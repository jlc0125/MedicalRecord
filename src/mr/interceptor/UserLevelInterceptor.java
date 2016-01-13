package mr.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jasig.cas.client.authentication.AttributePrincipal;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class UserLevelInterceptor implements HandlerInterceptor {

	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean preHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2) throws Exception {
		// TODO Auto-generated method stub

		//对用户级别进行判断
		AttributePrincipal principal = (AttributePrincipal) arg0.getUserPrincipal();
		if (null != principal) {
			Map<String, Object> attributes = principal.getAttributes();
			String userLevel = (String) attributes.get("userLevel");
			if(!userLevel.equals("1")){
				arg0.getRequestDispatcher("/user/error").forward(arg0, arg1);
				return false;
			}
		}else{
			arg0.getRequestDispatcher("/user/loginpage"+"?prehref="+arg0.getRequestURL()).forward(arg0, arg1);
			return false;
		}
		
		return true;
	}

}
