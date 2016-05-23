package se.chalmers.phrasebook.gui.fragments;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import org.grammaticalframework.ui.android.GFTranslator;
import org.grammaticalframework.ui.android.R;
import se.chalmers.phrasebook.backend.Model;
import se.chalmers.phrasebook.gui.smallFragments.SwipeFragment;
import se.chalmers.phrasebook.gui.smallFragments.TranslationFragment;

/**
 * Created by matilda on 04/04/16.
 */
public class TranslatorFragment extends Fragment {
    protected Model model;
    private SwipeFragment swiper;
    private View view;

    public static TranslatorFragment newInstance(String phrase) {
        TranslatorFragment fragment = new TranslatorFragment();
        Bundle args = new Bundle();
        args.putString("phrase", phrase);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        model = Model.getInstance();
    }

    public void displayDots() {
        if(swiper.isAdvanced(view.findViewById(R.id.containerfor_options))) {
            ((ImageView)view.findViewById(R.id.firstDot))
                    .setImageResource(R.drawable.ic_dictionary);
            ((ImageView)view.findViewById(R.id.secondDot))
                    .setImageResource(R.drawable.ic_dictionary);
        } else {
            ((ImageView)view.findViewById(R.id.secondDot))
                    .setImageResource(R.drawable.ic_dictionary);
            ((ImageView)view.findViewById(R.id.firstDot))
                    .setImageResource(R.drawable.ic_dictionary);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        view = inflater.inflate(R.layout.fragment_translator, container, false);

        final FragmentTransaction fm = getChildFragmentManager().beginTransaction();

        swiper = new SwipeFragment();
        fm.replace(R.id.containerfor_translation, new TranslationFragment());
        fm.replace(R.id.containerfor_options, new SwipeFragment());

        fm.commit();

        if(!model.getCurrentPhrase().hasAdvOptions()) {
            view.findViewById(R.id.firstDot).setVisibility(View.GONE);
            view.findViewById(R.id.secondDot).setVisibility(View.GONE);
        }

        return view;
    }

    public void updateTranslation() {
        TranslationFragment translationFragment = (TranslationFragment) getChildFragmentManager().findFragmentById(R.id.containerfor_translation);
        if (translationFragment != null)
            translationFragment.updateData();
    }
}
