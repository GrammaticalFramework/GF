package se.chalmers.phrasebook.gui.smallFragments;

import android.app.Activity;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.TextView;

import org.grammaticalframework.ui.android.R;
import se.chalmers.phrasebook.backend.Model;
import se.chalmers.phrasebook.backend.syntax.SyntaxNode;
import se.chalmers.phrasebook.backend.syntax.SyntaxNodeList;
import se.chalmers.phrasebook.gui.FragmentCommunicator;

/**
 * Created by matilda on 14/03/16.
 */
public class SpinnerInputFragment extends Fragment {

    private Model model;
    private int spinnerIndex;
    private SyntaxNodeList options;

    private String label;
    private String currentChoice;
    private Spinner spinner;


    public static SpinnerInputFragment newInstance(int optionIndex, String title, SyntaxNodeList options) {
        SpinnerInputFragment spinnerInputFragment = new SpinnerInputFragment();
        Bundle args = new Bundle();

        args.putInt("index", optionIndex);
        args.putString("title", title);
        args.putSerializable("spinner_options", options);

        spinnerInputFragment.setArguments(args);
        return spinnerInputFragment;
    }


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        model = Model.getInstance();

        label = getArguments().getString("title");
        spinnerIndex = getArguments().getInt("index");
        options = (SyntaxNodeList) getArguments().getSerializable("spinner_options");

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.small_fragment_spinner, container, false);
        TextView viewLabel = (TextView) view.findViewById(R.id.text_view_spinner);
        spinner = (Spinner) view.findViewById(R.id.choice_spinner);


        if (label == null) {
            viewLabel.setVisibility(View.GONE);
        } else {
            viewLabel.setText(label);
        }

        String[] children = new String[options.getChildren().size()];

        int i = 0;
        int selectedIndex = 0;
        for (SyntaxNode s : options.getChildren()) {
            if(s == options.getSelectedChild())
                selectedIndex = i;
            children[i] = s.getDesc();
            i++;
        }

        final ArrayAdapter<String> adapter = new ArrayAdapter<String>(getActivity(), android.R.layout.simple_list_item_1,children);
        adapter.setDropDownViewResource(android.R.layout.simple_list_item_1);
        spinner.setAdapter(adapter);
        spinner.setSelection(selectedIndex);
        currentChoice = spinner.getSelectedItem().toString();
        spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {

            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                if (!spinner.getSelectedItem().toString().equals(currentChoice)) {
                    sendMessage(spinnerIndex, spinner.getSelectedItemPosition());
                    currentChoice = spinner.getSelectedItem().toString();
                }
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });

        return view;

    }

    private void sendMessage(int optionIndex, int childIndex) {

        InputHolderFragment fragment = (InputHolderFragment) getParentFragment();

        fragment.updateSyntax(optionIndex, options,childIndex);


//        Intent intent = new Intent();
//        intent.setAction("gui_update");
//        intent.putExtra("optionIndex", optionIndex);
//        intent.putExtra("childIndex", childIndex);
//
//        LocalBroadcastManager.getInstance(getActivity().getApplicationContext()).sendBroadcast(intent);

    }

}
