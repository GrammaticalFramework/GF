package se.chalmers.phrasebook.backend.syntax;

/**
 * Created by Björn on 2016-04-04.
 */
public class NumeralSyntaxNode extends SyntaxNode {

    private int number = 1;

    public NumeralSyntaxNode() {
        super("NNumeral");
    }

    @Override
    public boolean isModular() {
        return true;
    }

    public String getData() {
        try {
            return nbrToSyntax(number);
        }catch(IllegalArgumentException e) {
            //Returns the syntax for "1" in case of erroneous input.
            return "(NNumeral(num (pot2as3 (pot1as2 (pot0as1 pot01)))))";
        }
    }

    public String getDesc() {
        return Integer.toString(number);
    }

    public void setDesc(String number) {
        this.number = Integer.parseInt(number);
    }


    @Override
    public void setSelectedChild(int listIndex, SyntaxNode newChild) {
        setDesc(Integer.toString(listIndex));
    }

    private String nbrToSyntax(int nbr) throws IllegalArgumentException {
        String syntax = "";
        if(nbr < 1000000 && nbr > 0) {
            if (nbr <=999) {
                syntax = "(NNumeral(num(pot2as3 " + subs1000(nbr) + ")))";
            } else if(nbr % 1000 == 0) {
                syntax = "(NNumeral(num(pot3 " + subs1000(nbr/1000) + ")))";
            } else if(nbr > 1000 && nbr%1000 != 0) {
                syntax = "(NNumeral(num(pot3plus " + subs1000(nbr/1000) + " " +
                        subs1000(nbr%1000) + ")))";
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

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }
}
