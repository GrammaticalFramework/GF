package se.chalmers.phrasebook.gui.smallFragments;

import android.support.v4.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.ImageView;

import org.grammaticalframework.pgf.Expr;
import org.grammaticalframework.ui.android.Translator;
import org.grammaticalframework.ui.android.GFTranslator;
import org.grammaticalframework.ui.android.TTS;
import org.grammaticalframework.ui.android.R;

import se.chalmers.phrasebook.backend.Model;

/**
 * Created by matilda on 10/03/16.
 */
public class TranslationFragment extends Fragment {

    private View translateView;
    private Model mModel;
    private TextView origin,target;
    Translator mTranslator;

    private TTS mTts;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mModel      = Model.getInstance();
        mTranslator = ((GFTranslator) getContext().getApplicationContext()).getTranslator();
        mTts        = new TTS(getActivity());
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        translateView = inflater.inflate(R.layout.small_fragment_translation, container, false);

        origin = (TextView) translateView.findViewById(R.id.origin_phrase);
        target = (TextView) translateView.findViewById(R.id.target_phrase);

        ImageView button = (ImageView) translateView.findViewById(R.id.button3);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
				mTts.speak(mTranslator.getTargetLanguage().getLangCode(), getTargetTranslation());
            }
        });

        return translateView;
    }

    @Override
    public void onViewCreated(View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        updateData();
    }

    @Override
    public void onDestroy() {
        if (mTts != null) {
            mTts.destroy();
            mTts = null;
        }
        super.onDestroy();
    }

    public String getTargetTranslation() {
        return target.getText().toString();
    }

    public void updateData() {
		Expr expr = mModel.getCurrentPhrase().getAdvSyntax();
        origin.setText(mTranslator.linearizeSource(expr));
        target.setText(mTranslator.linearize(expr));
    }
}
