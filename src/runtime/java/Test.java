import java.io.*;
import java.util.*;
import org.grammaticalframework.pgf.*;

public class Test {
	public static void main(String[] args) {
		PGF gr = null;
		try {
			gr = PGF.readPGF("Phrasebook.pgf");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return;
		} catch (PGFError e) {
			e.printStackTrace();
			return;
		}

		System.out.println(gr.getAbstractName());
		for (Map.Entry<String,Concr> entry : gr.getLanguages().entrySet()) {
			System.out.println(entry.getKey()+" "+entry.getValue()+" "+entry.getValue().getName());
		}
		
		int count = 10;
		for (ExprProb ep : gr.generateAll("Phrase")) {
			System.out.println(ep.getExpr());
			
			if (count-- <= 0)
				break;
		}

		Concr eng = gr.getLanguages().get("PhrasebookEng");
		Concr ger = gr.getLanguages().get("PhrasebookGer");

		try {
			for (ExprProb ep : eng.parse(gr.getStartCat(), "where is the hotel")) {
				System.out.println("["+ep.getProb()+"] "+ep.getExpr());
				System.out.println(ger.linearize(ep.getExpr()));
			}
		} catch (ParseError e) {
			System.out.println("Parsing failed at token \""+e.getToken()+"\"");
		}
	}
}
