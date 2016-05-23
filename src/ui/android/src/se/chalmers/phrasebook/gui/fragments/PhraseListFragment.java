package se.chalmers.phrasebook.gui.fragments;

import android.os.Bundle;

import java.util.ArrayList;

import android.app.Activity;
import android.content.Context;
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
import se.chalmers.phrasebook.gui.FragmentCommunicator;
import se.chalmers.phrasebook.gui.activities.NavigationActivity;


/**
 * Created by Björn on 2016-04-25.
 */
public class PhraseListFragment extends Fragment {

    protected Model model;
    protected ArrayList<String> phrases;
    Context context;
    private String title;

    private FragmentCommunicator mCallback;

    public static PhraseListFragment newInstance(String title) {
        PhraseListFragment fragment = new PhraseListFragment();
        Bundle args = new Bundle();
        args.putString("title", title);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);

        // This makes sure that the container activity has implemented
        // the callback interface. If not, it throws an exception
        try {
            mCallback = (FragmentCommunicator) activity;
        } catch (ClassCastException e) {
            throw new ClassCastException(activity.toString()
                    + " must implement OnHeadlineSelectedListener");
        }
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        model = Model.getInstance();
        context = getActivity().getApplicationContext();

        title = getArguments().getString("title");
        phrases = new ArrayList<String>();
        phrases.addAll(model.getSentencesInCurrentPhrasebook());
    }

    @Override
    public void onResume() {
        super.onResume();
        phrases.clear();
        phrases.addAll(model.getSentencesInCurrentPhrasebook());
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.fragment_phrase_list, container, false);
        getActivity().getActionBar().setTitle(title);
        ArrayAdapter adapter = new ArrayAdapter<String>(context, R.layout.phrase_list_item, phrases);

        final ListView phraseListView = (ListView) view.findViewById(R.id.phrase_listView);
        phraseListView.setAdapter(adapter);

        phraseListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {

                model.setCurrentPhrase(position);
                ((NavigationActivity)mCallback).getActionBar().setTitle(model.getDescFromPos(position));
                sendMessage(position);
            }
        });


        return view;
    }


    private void sendMessage(int position) {
       mCallback.setToTranslationFragment(position);
    }
}
