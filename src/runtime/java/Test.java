import org.grammaticalframework.*;

public class Test {
	public static void main(String[] args) {
		PGF gr = PGF.readPGF("/home/krasimir/www.grammaticalframework.org/treebanks/PennTreebank/ParseEngAbs.pgf");
		gr.close();
	}
}
