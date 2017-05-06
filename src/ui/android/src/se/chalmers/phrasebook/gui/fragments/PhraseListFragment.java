package se.chalmers.phrasebook.gui.fragments;

import android.os.Bundle;

import java.util.*;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.content.LocalBroadcastManager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import java.util.ArrayList;

import org.grammaticalframework.ui.android.R;
import se.chalmers.phrasebook.backend.Model;
import se.chalmers.phrasebook.backend.syntax.SyntaxTree;
import se.chalmers.phrasebook.gui.activities.NavigationActivity;


/**
 * Created by Björn on 2016-04-25.
 */
public class PhraseListFragment extends Fragment {

    protected Model model;
    private String title;
    private String id;

	public static PhraseListFragment newInstance(String title) {
        PhraseListFragment fragment = new PhraseListFragment();
        Bundle args = new Bundle();
        args.putString("title", title);
        fragment.setArguments(args);
        return fragment;
    }

    public static PhraseListFragment newInstance(String title, String id) {
        PhraseListFragment fragment = new PhraseListFragment();
        Bundle args = new Bundle();
        args.putString("title", title);
        args.putString("id",    id);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        model = Model.getInstance();
        title = getArguments().getString("title");
        id    = getArguments().getString("id");
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.fragment_phrase_list, container, false);
        getActivity().getActionBar().setTitle(title);

		final List<SyntaxTree> sentences = (id == null) ? model.getSentences() : model.getGroup(id);
        ArrayAdapter<SyntaxTree> adapter = new ArrayAdapter<SyntaxTree>(getActivity(), R.layout.phrase_list_item, sentences);

        final ListView phraseListView = (ListView) view.findViewById(R.id.phrase_listView);
        phraseListView.setAdapter(adapter);

        phraseListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long item_id) {
                SyntaxTree phrase = sentences.get(position);
                getActivity().getActionBar().setTitle(phrase.getDesc());
                ((NavigationActivity) getActivity()).setToTranslationFragment(phrase);
            }
        });

        return view;
    }
}
