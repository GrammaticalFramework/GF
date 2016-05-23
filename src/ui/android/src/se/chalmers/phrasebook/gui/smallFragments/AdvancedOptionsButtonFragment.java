package se.chalmers.phrasebook.gui.smallFragments;

import android.app.Activity;
import android.support.v4.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;

import org.grammaticalframework.ui.android.R;
import se.chalmers.phrasebook.backend.Model;
import se.chalmers.phrasebook.gui.FragmentCommunicator;
import se.chalmers.phrasebook.gui.fragments.TranslatorFragment;


/**
 * Created by matilda on 02/05/16.
 */
public class AdvancedOptionsButtonFragment extends Fragment{

    private boolean active;
    private Model model;
    private FragmentCommunicator mCallback;

    public static Fragment newInstance(boolean active) {
        AdvancedOptionsButtonFragment advancedOptionsButtonFragment = new AdvancedOptionsButtonFragment();


        Bundle args = new Bundle();
        args.putBoolean("active", active);
        advancedOptionsButtonFragment.setArguments(args);

        return advancedOptionsButtonFragment;
    }


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        model = Model.getInstance();
        this.active = getArguments().getBoolean("active");
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.advanced_options_button, container, false);

        CheckBox checkBox = (CheckBox) view.findViewById(R.id.checkBox);

        checkBox.setText("Use reported speech ('I Know that...')");

        if(active != true){
            checkBox.setChecked(false);
        } else {
            checkBox.setChecked(true);
        }

        checkBox.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (((CheckBox) v).isChecked()) {
                    model.getCurrentPhrase().setAdvActivated(true);
                    ((OptionsFragment)getParentFragment()).update(true);
                } else {
                    model.getCurrentPhrase().setAdvActivated(false);
                    ((OptionsFragment)getParentFragment()).update(false);
                }
                mCallback.updateTranslation();
            }
        });

        return view;
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

}
