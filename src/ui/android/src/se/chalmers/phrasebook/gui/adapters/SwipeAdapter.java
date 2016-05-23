package se.chalmers.phrasebook.gui.adapters;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;
import android.view.ViewGroup;

import se.chalmers.phrasebook.backend.Model;
import se.chalmers.phrasebook.gui.FragmentCommunicator;
import se.chalmers.phrasebook.gui.smallFragments.OptionsFragment;

/**
 * Created by matilda on 15/03/16.
 */
public class SwipeAdapter extends FragmentPagerAdapter {

    private int pages;
    private FragmentCommunicator mCallback;
    private Model model;

    public SwipeAdapter(FragmentManager fragmentManager, FragmentCommunicator mCallback) {
        super(fragmentManager);
        this.mCallback = mCallback;
        model = Model.getInstance();
        if(model.getCurrentPhrase().hasAdvOptions()) {
            pages = 2;
        } else {
            pages = 1;
        }
    }


    // Returns total number of pages
    @Override
    public int getCount() {
        return pages;
    }

    @Override
    public void startUpdate(ViewGroup container) {
        mCallback.pageChanged();
    }

    // Returns the fragment to display for that page
    @Override
    public Fragment getItem(int position) {

        switch(position){
            case 0:
                return OptionsFragment.newInstance(1, false);
            case 1:
                return OptionsFragment.newInstance(2, model.getCurrentPhrase().isAdvActivated());
            default:
                return null;
        }

    }

}
