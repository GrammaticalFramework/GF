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
		
		for (ExprProb ep : gr.getLanguages().get("ParseEng").parse("Phr", "test")) {
			System.out.println("["+ep.getProb()+"] "+ep.getExpr());
		}
	}
}
