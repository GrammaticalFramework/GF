package se.chalmers.phrasebook.backend;


import android.content.Context;

import java.io.*;
import java.util.*;

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
        for (Map.Entry<String,String> entry : parser.getSentencesData()) {
            phrases.add(parser.getSyntaxTree(entry.getKey()));
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

    public List<String> getSentencesInCurrentPhrasebook() {
        ArrayList<String> sentences = new ArrayList<String>();
        for (Map.Entry<String,String> entry : parser.getSentencesData()) {
			sentences.add(entry.getValue());
        }
        return sentences;
    }

    public void setCurrentPhrase(int position) {
        SyntaxTree choosenPhrase = phrases.get(position);
        currentPhrase = parser.getSyntaxTree(choosenPhrase.getId());
        boolean status = currentPhrase.replicate(choosenPhrase);
    }

    public String getDescFromPos(int pos) {
        return parser.getSentencesData().get(pos).getValue();
    }

    public void setNumeralCurrentPhrase() {
        for (int i = 0; i < parser.getSentencesData().size(); i++) {
			String key = parser.getSentencesData().get(i).getKey();
            if (key.equals("NNumeral")) {
                currentPhrase = parser.getSyntaxTree(key);
            }
        }
    }

    public SyntaxTree getCurrentPhrase() {
        return currentPhrase;
    }
}

