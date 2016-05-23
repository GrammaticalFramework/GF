package se.chalmers.phrasebook.gui;

import se.chalmers.phrasebook.backend.syntax.SyntaxNodeList;

/**
 * An interface for communication between a fragment to an activity
 * Created by David on 2016-04-13.
 */
public interface FragmentCommunicator {
    void updateSyntax(int optionIndex, SyntaxNodeList l, int childIndex, boolean isAdvanced);

    void pageChanged();

    void setToTranslationFragment(int id);

    void updateTranslation();
}
