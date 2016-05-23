package se.chalmers.phrasebook.gui.fragments;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import se.chalmers.phrasebook.backend.Model;

/**
 * Created by Björn on 2016-04-25.
 */
public class NumeralTranslatorFragment extends TranslatorFragment {

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        model = Model.getInstance();
    }

    public static NumeralTranslatorFragment newInstance() {
        NumeralTranslatorFragment fragment = new NumeralTranslatorFragment();
        Bundle args = new Bundle();
        args.putString("phrase", "NNumeral");
        fragment.setArguments(args);
        return fragment;
    }

    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceStat) {
        View view = super.onCreateView(inflater, container,
                savedInstanceStat);
        super.model.setNumeralCurrentPhrase();
        return view;
    }
}
