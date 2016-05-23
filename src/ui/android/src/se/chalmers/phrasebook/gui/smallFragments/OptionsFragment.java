package se.chalmers.phrasebook.gui.smallFragments;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import java.util.ArrayList;

import org.grammaticalframework.ui.android.R;
import se.chalmers.phrasebook.backend.Model;
import se.chalmers.phrasebook.backend.syntax.SyntaxNodeList;

public class OptionsFragment extends Fragment {

    private Model model;

    private ArrayList<SyntaxNodeList> options;
    private ArrayList<SyntaxNodeList> advancedOptions;

    private int type;
    private boolean advActive;

    private int[] containers;

    public static OptionsFragment newInstance(int type, boolean advActive) {
        OptionsFragment optionsFragment = new OptionsFragment();
        Bundle args = new Bundle();
        args.putInt("index", type);
        args.putBoolean("advActive", advActive);
        optionsFragment.setArguments(args);
        return optionsFragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        model = Model.getInstance();

        type = getArguments().getInt("index");
        advActive = getArguments().getBoolean("advActive");

        options = model.getCurrentPhrase().getOptions();
        advancedOptions = model.getCurrentPhrase().getAdvOptions();
        containers = new int[6];

        addContainers();
        addFragments();

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        return inflater.inflate(R.layout.small_fragment_options, container, false);

    }

    private void addFragments() {

        FragmentTransaction transaction = getChildFragmentManager().beginTransaction();

        if (type == 1) {
            for (int i = 0; i < options.size(); i++) {
                if (options.get(i) != null) {
                    transaction.replace(containers[i], (InputHolderFragment.newInstance(i, false)));
                }
            }
        } else if (type == 2) {
            transaction.replace(containers[0], AdvancedOptionsButtonFragment.newInstance(advActive));
            if (advActive) {
                for (int i = 0; i < advancedOptions.size(); i++) {
                    if (advancedOptions.get(i) != null)
                        transaction.replace(containers[i + 1], InputHolderFragment.newInstance(i, true));
                }
            } else {
                //Replaces with empty fragments
                for (int i = 0; i < advancedOptions.size(); i++) {
                    if (advancedOptions.get(i) != null)
                        transaction.replace(containers[i + 1], new Fragment());
                }
            }
        }
        transaction.commit();
    }

    public void update(boolean advActive) {
        this.advActive = advActive;
        addFragments();
    }

    private void addContainers() {

        containers[0] = R.id.child_fragment1;
        containers[1] = R.id.child_fragment2;
        containers[2] = R.id.child_fragment3;
        containers[3] = R.id.child_fragment4;
        containers[4] = R.id.child_fragment5;
        containers[5] = R.id.child_fragment6;

    }

}
