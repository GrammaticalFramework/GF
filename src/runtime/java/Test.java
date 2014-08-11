import java.io.*;
import java.util.*;
import org.grammaticalframework.pgf.*;

public class Test {
	public static void main(String[] args) throws IOException {		
		PGF gr = null;
		try {
			gr = PGF.readPGF("/home/krasimir/www.grammaticalframework.org/examples/phrasebook/Phrasebook.pgf");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return;
		} catch (PGFError e) {
			e.printStackTrace();
			return;
		}
		
		Type typ = gr.getFunctionType("Bulgarian");
		System.out.println(typ.getCategory());
		System.out.println(gr.getAbstractName());
		for (Map.Entry<String,Concr> entry : gr.getLanguages().entrySet()) {
			System.out.println(entry.getKey()+" "+entry.getValue()+" "+entry.getValue().getName());
			entry.getValue().addLiteral("PN", new NercLiteralCallback(gr,entry.getValue()));
		}

		Concr eng = gr.getLanguages().get("SimpleEng");
		try {
			for (ExprProb ep : eng.parse(gr.getStartCat(), "persons who work with Malmö")) {
				System.out.println("["+ep.getProb()+"] "+ep.getExpr());
			}
		} catch (ParseError e) {
			System.out.println("Parsing failed at token \""+e.getToken()+"\"");
		}
	}
}
