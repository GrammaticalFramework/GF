package se.chalmers.phrasebook.backend.syntax;

public class SyntaxNodeNumeral extends SyntaxNode {
	private int min;
	private int max;

    public SyntaxNodeNumeral(String desc, int min, int max) {
        super(desc);
        this.min = min;
        this.max = max;
    }

	public String getAbstractSyntax(ChoiceContext context) {
		return nbrToSyntax(context.choose(this));
	}

	@Override
	public int getDefaultChoice() {
		return 1;
	}
	
	public int getMin() {
		return min;
	}
	
	public int getMax() {
		return max;
	}

    private String nbrToSyntax(int nbr) throws IllegalArgumentException {
        String syntax = "";
        if(nbr < 1000000 && nbr > 0) {
            if (nbr <=999) {
                syntax = "(num (pot2as3 " + subs1000(nbr) + "))";
            } else if(nbr % 1000 == 0) {
                syntax = "(num (pot3 " + subs1000(nbr/1000) + "))";
            } else if(nbr > 1000 && nbr%1000 != 0) {
                syntax = "(num (pot3plus " + subs1000(nbr/1000) + " " +
                        subs1000(nbr%1000) + "))";
            }
        } else {
            throw new IllegalArgumentException("Input must be between 1 and 999999");
        }
        return syntax;
    }

    private String subs1000(int nbr) {
        String syntax = "";
        if(nbr < 100) {
            syntax = "(pot1as2 " + subs100(nbr) + ")";
        } else if(nbr % 100 == 0) {
            syntax = "(pot2 " + subs10(nbr/100) + ")";
        } else if(nbr > 100 && nbr%100 != 0) {
            syntax = "(pot2plus " + subs10(nbr/100) + " " + subs100(nbr%100) + ")";
        }
        return syntax;
    }

    private String subs100(int nbr) {
        String syntax = "";
        if(nbr < 10) {
            syntax = "(pot0as1 " + subs10(nbr) + ")";
        } else if(nbr == 10 || nbr == 11) {
            syntax = "pot1" + nbr;
        } else if(nbr >= 12 && nbr <= 19) {
            syntax = "(pot1to19 n" + nbr%10 + ")";
        } else if(nbr >= 20 && nbr%10 == 0) {
            syntax = "(pot1 n" + Integer.toString(nbr/10) + ")";
        } else if(nbr%10 != 0) {
            syntax = "(pot1plus n" + nbr/10 + " " + subs10(nbr%10) + ")";
        }
        return syntax;
    }

    private String subs10(int nbr) {
        String syntax = "";
        if (nbr == 1) {
            syntax = "pot01";
        } else if (nbr >= 2 && nbr <= 9) {
            syntax = "(pot0 n" + nbr + ")";
        }
        return syntax;
    }
}
