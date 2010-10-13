package com.tapplocal.admin.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

/*
 * AuthenticationFilter.java
 * 
 * Classe que auxilia na operação de login de usuário, e nas restrições de acesso as telas por usuários não-logados.
 * 
 */

public class AuthenticationFilter implements Filter {

	String loginController = "/web/login";
	
	/*
	 * Função que implementa um filtro de acesso as paginas por usuários não-logados.
	 * 
	 * @param request Requisição do Servlet.
	 * @param response Resposta ao Servlet.
	 * @param chain Cadeia de Filtros.
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
						
		//tratamento para deixar passar direto a pedida pelos dados de filtro
		String uri = ((HttpServletRequest)request).getRequestURI();
						
		if ((((HttpServletRequest)request).getSession().getAttribute("logged") == null)
				&& (!uri.endsWith(loginController))) {			
			request.getRequestDispatcher(loginController).forward(request, response);
		} else {
			chain.doFilter(request, response);
		}
	}
	
	/*
	 * Função que destrói o filtro de acesso as paginas por usuários não-logados.
	 *
	 */
	public void destroy() {
		//nao faz nada
	}
	
	/*
	 * Função que inicializa o filtro de acesso as paginas.
	 * 
	 * @param config Configuração do Filtro.
	 */
	public void init(FilterConfig config) throws ServletException {
		//
	}

}
