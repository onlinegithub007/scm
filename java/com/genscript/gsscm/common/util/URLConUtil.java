package com.genscript.gsscm.common.util;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.Authenticator;
import java.net.HttpURLConnection;
import java.net.PasswordAuthentication;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;

public class URLConUtil {
	public static String getContent(String strUrl) {

		try {

			URL url = new URL(strUrl);

			BufferedReader br = new BufferedReader(new InputStreamReader(url

			.openStream()));

			String s = "";

			StringBuffer sb = new StringBuffer("");

			while ((s = br.readLine()) != null) {

				sb.append(s + "\r\n");

			}

			br.close();

			return sb.toString();

		} catch (Exception e) {

			return "error open url:" + strUrl;

		}

	}

	public static void initProxy(String host, int port, final String username,

	final String password) {

		Authenticator.setDefault(new Authenticator() {

			protected PasswordAuthentication getPasswordAuthentication() {

				return new PasswordAuthentication(username,

				new String(password).toCharArray());

			}

		});

		System.setProperty("http.proxyType", "");

		System.setProperty("http.proxyPort", Integer.toString(port));

		System.setProperty("http.proxyHost", host);

		System.setProperty("http.proxySet", "true");

	}

	public static String getStatusFedex1(String url ) throws IOException {


		String proxy = "http://";

		int port = 0;

		String username = "username";

		String password = "password";

		String curLine = "";

		String content = "";

		URL server = new URL(url);

		initProxy(proxy, port, username, password);

		HttpURLConnection connection = (HttpURLConnection) server

		.openConnection();
		
		connection.connect();

		InputStream is = connection.getInputStream();

		BufferedReader reader = new BufferedReader(new

		InputStreamReader(is));

		while ((curLine = reader.readLine()) != null) {

			content = content + curLine + "\r\n";

		}

		
		return content;
	}
	

}
