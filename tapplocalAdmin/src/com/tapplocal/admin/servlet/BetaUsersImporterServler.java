package com.tapplocal.admin.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.nextframework.core.standard.Next;

import com.tapplocal.admin.bean.App;
import com.tapplocal.admin.bean.Betasignup;
import com.tapplocal.admin.bean.Developer;
import com.tapplocal.admin.bean.Merchant;
import com.tapplocal.admin.bean.Store;
import com.tapplocal.admin.bean.User;
import com.tapplocal.admin.dao.AppDAO;
import com.tapplocal.admin.dao.BetasignupDAO;
import com.tapplocal.admin.dao.DeveloperDAO;
import com.tapplocal.admin.dao.MerchantDAO;
import com.tapplocal.admin.dao.StoreDAO;
import com.tapplocal.admin.dao.UserDAO;


public class BetaUsersImporterServler extends HttpServlet
{	
	private static final long serialVersionUID = -15706604316L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException {					

		//Logger logger = Logger.getLogger("com.tapplocal.admin.servlet");		

		//importDevelopers();

		//importMerchants(resp);
	}



	private void importDevelopers() {
		List<Betasignup> users = Next.getObject(BetasignupDAO.class).findAllByType("developer");

		for (int i=0; i<users.size(); i++)
		{
			Betasignup b = users.get(i);

			if (b.getEmail().indexOf("@") == -1)
				continue;			

			String name = b.getEmail().substring(0,b.getEmail().indexOf("@"));
			String appname = null;

			String str = new String(b.getDetails());

			str = str.replaceAll("a:[0-9]*?:", "");
			str = str.replaceAll("s:[0-9]*?:", "");
			str = str.replaceAll("i:[0-9]*?;", "");

			str = str.replaceAll("\"", "");
			str = str.replaceAll("\\{", "\n");
			str = str.replaceAll("\\}", "");

			//str = str.replaceAll(";;", ";");	

			str = str.trim();

			if (str.indexOf("appname;App Name;") >= 0)
				str = "";

			String[] parameters = str.split(";");			

			for (int j=0; j<(parameters.length/2);j++)				
			{
				if (parameters[2*j].equals("appname"))
				{
					appname = parameters[(2*j)+1];
				}
				else if (parameters[2*j].equals("name"))
				{
					if (parameters[(2*j)+1].length() > 0)
					{
						name = parameters[(2*j)+1];
					}					
				}
			}

			User u = Next.getObject(UserDAO.class).userByEmail(b.getEmail());
			if (u == null)
			{
				u = new User();

				Developer d = new Developer();
				d.setName(name);
				Next.getObject(DeveloperDAO.class).saveOrUpdate(d);

				if (appname != null)
				{
					App app = new App();				
					Long code = Math.abs(Math.round(Math.random() * 999999));	

					while (code < 100000)
						code = Math.abs(Math.round(Math.random() * 999999));

					app.setCode(code+"");
					app.setDeveloper(d);
					app.setName(appname);
					Next.getObject(AppDAO.class).saveOrUpdate(app);
				}

				u.setDeveloper(d);
				u.setAccessFree(1L);
				u.setEmail(b.getEmail());
				u.setName(name);
				u.setPasswd(name+"123");
				String code = Math.round(Math.random() * 999999)+ "";
				u.setCode(code);
				Next.getObject(UserDAO.class).saveOrUpdate(u);
			}
		}
	}	

	private void importMerchants(HttpServletResponse resp) throws ServletException, IOException {
		List<Betasignup> users = Next.getObject(BetasignupDAO.class).findAllByType("merchant");

		for (int i=0; i<users.size(); i++)
		{
			Betasignup b = users.get(i);

			if (b.getEmail().indexOf("@") == -1)
				continue;

			String name = b.getEmail().substring(0,b.getEmail().indexOf("@"));

			String str = new String(b.getDetails());

			str = str.replaceAll("a:[0-9]*?:", "");
			str = str.replaceAll("s:[0-9]*?:", "");
			str = str.replaceAll("i:[0-9]*?;", "");

			str = str.replaceAll("\"", "");
			str = str.replaceAll("\\{", "\n");
			str = str.replaceAll("\\}", "");

			str = str.trim();			

			String[] stores = str.split("\n");

			User u = Next.getObject(UserDAO.class).userByEmail(b.getEmail());

			if (u == null)
			{
				u = new User();
				u.setAccessFree(1L);
				u.setEmail(b.getEmail());
				u.setName(name);
				u.setPasswd(name+"123");
				String code = Math.round(Math.random() * 999999)+ "";
				u.setCode(code);									

				Merchant m = new Merchant();	

				for (int k=0;k<(stores.length);k++)
				{
					String[] parameters = stores[k].split(";");			

					resp.getOutputStream().write((b.getEmail()+"\n").getBytes());

					Store store = new Store();

					for (int j=0; j<(parameters.length/2);j++)				
					{						
						if (parameters[2*j].equals("name"))
						{
							if (parameters[(2*j)+1].length() == 0)
								break;
							
							m.setName(parameters[(2*j)+1]);
						}
						else if (parameters[2*j].equals("address"))
						{
							if (parameters[(2*j)+1].length() > 0)						
								store.setAddress(parameters[(2*j)+1]);										
						}	
						else if (parameters[2*j].equals("city"))
						{
							if (parameters[(2*j)+1].length() > 0)						
								store.setCity(parameters[(2*j)+1]);										
						}	
						else if (parameters[2*j].equals("state"))
						{
							if (parameters[(2*j)+1].length() > 0)						
								store.setState(parameters[(2*j)+1]);										
						}		
						else if (parameters[2*j].equals("phone"))
						{
							if (parameters[(2*j)+1].length() > 0)						
								store.setPhone(parameters[(2*j)+1]);										
						}	
						else if (parameters[2*j].equals("lat"))
						{
							if (parameters[(2*j)+1].length() > 0)						
								store.setLatitude(new Double(parameters[(2*j)+1]));										
						}
						else if (parameters[2*j].equals("lon"))
						{
							if (parameters[(2*j)+1].length() > 0)						
								store.setLongitude(new Double(parameters[(2*j)+1]));										
						}
						else if (parameters[2*j].equals("url"))
						{
							if (parameters[(2*j)+1].length() > 0)						
								m.setSite(parameters[(2*j)+1]);										
						}						
					}
										
					if (m.getId() == null)
					{
						Next.getObject(MerchantDAO.class).saveOrUpdate(m);
						
						u.setMerchant(m);
						Next.getObject(UserDAO.class).saveOrUpdate(u);								
					}

					if (store.getAddress() != null)
					{					
						store.setMerchant(m);
						Next.getObject(StoreDAO.class).saveOrUpdate(store);
					}
				}				
			}
		}
	}
}		
