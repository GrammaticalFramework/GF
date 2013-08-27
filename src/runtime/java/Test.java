import java.io.*;
import java.util.*;
import org.grammaticalframework.pgf.*;

public class Test {
	public static void main(String[] args) {
		PGF gr = null;
		try {
			gr = PGF.readPGF("/home/krasimir/www.grammaticalframework.org/treebanks/PennTreebank/ParseEngAbs.pgf");
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
		
		Concr eng = gr.getLanguages().get("ParseEng");
		for (ExprProb ep : eng.parse("Phr", "where are you")) {
			System.out.println("["+ep.getProb()+"] "+ep.getExpr());
			System.out.println(eng.linearize(ep.getExpr()));
		}
	}
}
