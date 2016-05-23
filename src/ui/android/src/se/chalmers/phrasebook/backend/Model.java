package se.chalmers.phrasebook.backend;


import android.content.Context;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

import org.grammaticalframework.pgf.Expr;
import org.grammaticalframework.ui.android.R;
import org.grammaticalframework.ui.android.GFTranslator;
import se.chalmers.phrasebook.backend.syntax.SyntaxNodeList;
import se.chalmers.phrasebook.backend.syntax.SyntaxTree;

/**
 * Created by Björn on 2016-03-03.
 */
public class Model {
    private static Model model;

    private XMLParser parser;
    private ArrayList<SyntaxTree> phrases;
    private SyntaxTree currentPhrase;

    private Model() {
        try {
            InputStream phrases = GFTranslator.get().getAssets().open("phrases.xml");
            parser = new XMLParser(phrases);
            phrases.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

		phrases = new ArrayList<SyntaxTree>();
        for (String s : parser.getSentencesData().keySet()) {
            phrases.add(parser.getSyntaxTree(s));
        }
    }

    public static Model getInstance() {
        if (model == null) model = getSync();
        return model;
    }

    private synchronized static Model getSync() {
        if (model == null) model = new Model();
        return model;
    }

    public void update(int optionIndex, SyntaxNodeList target, int childIndex, boolean isAdvanced) {
        currentPhrase.setSelectedChild(optionIndex, target, childIndex, isAdvanced);
    }

    public ArrayList<String> getSentencesInCurrentPhrasebook() {
        ArrayList<String> sentences = new ArrayList<String>();
        for (int i = 0; i < phrases.size(); i++) {
			sentences.add(parser.getSentencesData().get(phrases.get(i).getId()));
        }
        return sentences;
    }

    public void setCurrentPhrase(int position) {
        SyntaxTree choosenPhrase = phrases.get(position);
        currentPhrase = parser.getSyntaxTree(choosenPhrase.getId());
        boolean status = currentPhrase.replicate(choosenPhrase);
    }

    public String getDescFromPos(int pos) {
        return parser.getSentencesData()
                .get((String) (parser.getSentencesData().keySet().toArray()[pos]));
    }

    public void setNumeralCurrentPhrase() {
        for (int i = 0; i < parser.getSentencesData().values().size(); i++) {
            if ((parser.getSentencesData().keySet().toArray()[i]).equals("NNumeral")) {
                currentPhrase = parser.getSyntaxTree((String) parser.getSentencesData()
                        .keySet().toArray()[i]);
            }
        }
    }

    public SyntaxTree getCurrentPhrase() {
        return currentPhrase;
    }
}

