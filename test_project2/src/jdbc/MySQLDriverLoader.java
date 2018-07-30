package jdbc;
import javax.servlet.*;
import javax.servlet.http.HttpServlet;
/*서블릿을 위한 상위클래스 HttpServlet
 *서블릿은 init 메서드를 제공하고 이 메서드는 서블릿을 초기화할때 최초 한 번 실행된다
 *이클립스는 코드를 저장할때 알아서 컴파일해줌 이클립스가 아니면 명령어가 필요함
 *자동으로 서블릿 클래스를 실행하도록 설정하기 위해 web.xml파일에 태그를 추가해준다
 */
public class MySQLDriverLoader extends HttpServlet{

	public void init(ServletConfig config) throws ServletException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		}catch(Exception ex) {
			throw new ServletException(ex);
		}
	}

}
