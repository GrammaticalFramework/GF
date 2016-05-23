package se.chalmers.phrasebook.gui.smallFragments;

import android.app.Activity;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import org.grammaticalframework.ui.android.R;
import se.chalmers.phrasebook.gui.FragmentCommunicator;
import se.chalmers.phrasebook.gui.adapters.SwipeAdapter;


public class SwipeFragment extends Fragment {

    private ViewPager pager;
    private SwipeAdapter swipeAdapter;
    private FragmentCommunicator mCallback;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.small_fragment_swipe, container, false);

        pager = (ViewPager)view.findViewById(R.id.vpPager);

        swipeAdapter = new SwipeAdapter(getChildFragmentManager(), mCallback);

        pager.setAdapter(swipeAdapter);
        return view;
    }

    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);
        System.out.println("Attaching");
        // This makes sure that the container activity has implemented
        // the callback interface. If not, it throws an exception
        try {
            mCallback = (FragmentCommunicator) activity;
        } catch (ClassCastException e) {
            throw new ClassCastException(activity.toString()
                    + " must implement OnHeadlineSelectedListener");
        }
    }

    public boolean isAdvanced(View view) {
        pager = (ViewPager)view.findViewById(R.id.vpPager);
        try {
           return ((ViewPager)view.findViewById(R.id.vpPager)).getCurrentItem() == 1;
        }catch(NullPointerException e) {
            return false;
        }
    }

}
