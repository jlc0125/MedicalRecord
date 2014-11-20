package mr.web;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;


import org.wltea.analyzer.core.IKSegmenter;
import org.wltea.analyzer.core.Lexeme;


public class IKAnalizer {
	public static String IKAnalysis(String str) {
		StringBuffer sb = new StringBuffer();
		try {
		byte[] bt = str.getBytes();
		InputStream ip = new ByteArrayInputStream(bt);
		Reader read = new InputStreamReader(ip);

		IKSegmenter iks = new IKSegmenter(read,false);
		Lexeme t;
		while ((t = iks.next()) != null ) {
			if (t.getLexemeText().length()>1) {
			sb.append(t.getLexemeText() + " ");}

		}
		
		} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		}
		
		return sb.toString();

		}
}
