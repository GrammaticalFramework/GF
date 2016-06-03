package se.chalmers.phrasebook.gui.fragments;

import java.util.*;

import android.os.Bundle;
import android.content.Context;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.view.*;
import android.widget.*;
import android.text.Editable;
import android.text.TextWatcher;
import android.text.method.PasswordTransformationMethod;

import org.grammaticalframework.pgf.Expr;
import org.grammaticalframework.ui.android.Translator;
import org.grammaticalframework.ui.android.GFTranslator;
import org.grammaticalframework.ui.android.TTS;
import org.grammaticalframework.ui.android.R;
import se.chalmers.phrasebook.backend.*;
import se.chalmers.phrasebook.backend.syntax.*;

/**
 * Created by matilda on 04/04/16.
 */
public class TranslatorFragment extends Fragment {
    protected Model model;
    Translator mTranslator;
    private TTS mTts;

	private TextView origin,target;
	private ListView list;
    SyntaxTree phrase;

    ChoiceContext mContext;
    ArrayAdapter<SyntacticChoice> mAdapter;

    public static TranslatorFragment newInstance(SyntaxTree phrase) {
        TranslatorFragment translatorFragment = new TranslatorFragment();
        Bundle args = new Bundle();
        args.putSerializable("phrase", phrase);
        translatorFragment.setArguments(args);
        return translatorFragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        phrase = (SyntaxTree) getArguments().getSerializable("phrase");
        model = Model.getInstance();
        mTranslator = ((GFTranslator) getContext().getApplicationContext()).getTranslator();
        mTts        = new TTS(getActivity());
        mContext    = new ChoiceContext();
        
        
		mAdapter =
			new ArrayAdapter<SyntacticChoice>(getActivity(), R.layout.spinner_input_list_item, mContext.getChoices()) {
				LayoutInflater inflater = (LayoutInflater)getContext().getSystemService(Context.LAYOUT_INFLATER_SERVICE);

				@Override
				public View getView (int position, View convertView, ViewGroup parent) {
					SyntacticChoice choice = mContext.getChoices().get(position);
					View view = null;
					if (choice.getNode() instanceof SyntaxNodeBoolean) {
						view = createCheckBoxInputView(inflater, choice, (SyntaxNodeBoolean) choice.getNode(), parent);
					} else if (choice.getNode() instanceof SyntaxNodeOption) {
						view = createSpinnerInputView(inflater, choice, (SyntaxNodeOption) choice.getNode(), parent);
					} else if (choice.getNode() instanceof SyntaxNodeNumeral) {
						view = createNumeralInputView(inflater, choice, (SyntaxNodeNumeral) choice.getNode(), parent);
					}
					return view;
				}
			};
    }

    @Override
    public View onCreateView(final LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_translator, container, false);
        origin = (TextView) view.findViewById(R.id.origin_phrase);
        target = (TextView) view.findViewById(R.id.target_phrase);
        list   = (ListView) view.findViewById(R.id.input_holder);
        list.setAdapter(mAdapter);

		ImageView button = (ImageView) view.findViewById(R.id.button3);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
				mTts.speak(mTranslator.getTargetLanguage().getLangCode(), (String) target.getText());
            }
        });

        updateSyntax();
        return view;
    }
    
    private View createSpinnerInputView(LayoutInflater inflater, final SyntacticChoice choice, final SyntaxNodeOption options, ViewGroup parent) {
        View view = inflater.inflate(R.layout.spinner_input_list_item, parent, false);
        TextView viewLabel = (TextView) view.findViewById(R.id.text_view_spinner);
        Spinner spinner = (Spinner) view.findViewById(R.id.choice_spinner);

		String label = options.getDesc();
        if (label == null || label.isEmpty()) {
            viewLabel.setVisibility(View.GONE);
        } else {
            viewLabel.setText(label);
        }

        final ArrayAdapter<SyntaxNode> adapter = new ArrayAdapter<SyntaxNode>(getActivity(), android.R.layout.simple_list_item_1,options.getOptions());
        adapter.setDropDownViewResource(android.R.layout.simple_list_item_1);
        spinner.setAdapter(adapter);
        
        spinner.setSelection(choice.getChoice());
        spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {

            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
				if (position != choice.getChoice()) {
					choice.setChoice(position);
					updateSyntax();
				}
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
            }
        });

        return view;
	}

	private class NumericKeyBoardTransformationMethod extends PasswordTransformationMethod {
        @Override
        public CharSequence getTransformation(CharSequence source, View view) {
            return source;
        }
    }
    
    private View createNumeralInputView(LayoutInflater inflater, final SyntacticChoice choice, final SyntaxNodeNumeral numeral, ViewGroup parent) {
        View view = inflater.inflate(R.layout.number_input_list_item, parent, false);
        TextView viewLabel = (TextView) view.findViewById(R.id.textView_number);
        final SeekBar seekBar = (SeekBar) view.findViewById(R.id.seekBar);
        final EditText editNumber = (EditText) view.findViewById(R.id.editNumber);

		String label = choice.getNode().getDesc();
        if (label == null || label.isEmpty()) {
            viewLabel.setVisibility(View.GONE);
        } else {
            viewLabel.setText(label);
        }

        seekBar.setProgress(choice.getChoice());
        editNumber.setText(Integer.toString(choice.getChoice()));

        editNumber.setTransformationMethod(new NumericKeyBoardTransformationMethod());
        editNumber.requestFocus();
        seekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                editNumber.setText(Integer.toString(progress+1));
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {
            }
        });


        editNumber.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {
				int number;
				boolean update = false;
				try {
					if(editNumber.getText().toString().equals("")) {
						number = numeral.getMin();
					} else {
						number = Integer.parseInt(editNumber.getText().toString());
						if (number < numeral.getMin()) {
							number = numeral.getMin();
							update = true;
						}
						if (number > numeral.getMax()) {
							number = numeral.getMax();
							update = true;
						}
						editNumber.setInputType(0);
					}
				} catch (NumberFormatException e) {
					number = choice.getChoice();
					update = true;
				}
                choice.setChoice(number);
                if (update)
					editNumber.setText(Integer.toString(number));
                seekBar.setProgress(number-numeral.getMin());
                updateSyntax();
            }
        });

        return view;
	}

    private View createCheckBoxInputView(LayoutInflater inflater, final SyntacticChoice choice, final SyntaxNodeBoolean options, ViewGroup parent) {
        View view = inflater.inflate(R.layout.checkbox_input_list_item, parent, false);
        final CheckBox checkBox = (CheckBox) view.findViewById(R.id.choice_checkbox);

		String label = options.getDesc();
        if (label != null && !label.isEmpty()) {
            checkBox.setText(label);
        }

        checkBox.setChecked(choice.getChoice() == 1);
        checkBox.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {
				int position = checkBox.isChecked() ? 1 : 0;
				if (position != choice.getChoice()) {
					choice.setChoice(position);
					updateSyntax();
				}
            }
        });

        return view;
	}

    public void updateSyntax() {
		mContext.reset();

        Expr expr = phrase.getAbstractSyntax(mContext);
        origin.setText(mTranslator.linearizeSource(expr));
        target.setText(mTranslator.linearize(expr));
		mAdapter.notifyDataSetChanged();
	}
}
