package se.chalmers.phrasebook.gui.smallFragments;

import android.content.Context;
import android.support.v4.app.Fragment;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.text.method.PasswordTransformationMethod;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.SeekBar;
import android.widget.Spinner;
import android.widget.TextView;

import org.grammaticalframework.ui.android.R;
import se.chalmers.phrasebook.backend.Model;
import se.chalmers.phrasebook.backend.syntax.SyntaxNode;
import se.chalmers.phrasebook.backend.syntax.SyntaxNodeList;

/**
 * Created by David on 2016-04-07.
 */
public class NumberInputFragment extends Fragment {

    private Model model;
    private int spinnerIndex;
    private SyntaxNodeList options;

    private int optionIndex;
    private String label;
    private int defaultInt;
    private EditText editNumber;
    private int currentNumber;

    public static NumberInputFragment newInstance(int optionIndex, String title, int defaultInt) {
        NumberInputFragment numberInputFragment = new NumberInputFragment();
        Bundle args = new Bundle();

        args.putInt("optionIndex", optionIndex);
        args.putString("title", title);
        args.putInt("defaultInt", defaultInt);

        numberInputFragment.setArguments(args);
        return numberInputFragment;
    }


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        model = Model.getInstance();
        optionIndex = getArguments().getInt("optionIndex");
        label = getArguments().getString("title");
        defaultInt = getArguments().getInt("defaultInt");
    }

    private class NumericKeyBoardTransformationMethod extends PasswordTransformationMethod {
        @Override
        public CharSequence getTransformation(CharSequence source, View view) {
            return source;
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.small_fragment_number, container, false);
        TextView viewLabel = (TextView) view.findViewById(R.id.textView_number);
        final SeekBar seekBar = (SeekBar) view.findViewById(R.id.seekBar);
        editNumber = (EditText) view.findViewById(R.id.editNumber);

        viewLabel.setText(label);
        seekBar.setProgress(defaultInt);
        editNumber.setText(""+defaultInt);

        editNumber.setTransformationMethod(new NumericKeyBoardTransformationMethod());
        editNumber.requestFocus();
        seekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {

                currentNumber = progress;
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {
                editNumber.setText(""+currentNumber);

                sendMessage(optionIndex, currentNumber);

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
                if(editNumber.getText().toString().equals("")) {
                    currentNumber = 0;
                } else if(editNumber.getText().toString().length() < 7){
                    currentNumber = Integer.parseInt(editNumber.getText().toString());
                    editNumber.setInputType(0);
                    sendMessage(optionIndex, currentNumber);

                } else {
                    editNumber.setText(""+editNumber.getText().toString()
                            .substring(0,editNumber.getText().toString().length()-1));
                }
                seekBar.setProgress(currentNumber);

            }
        });

        return view;
    }

    private void sendMessage(int optionIndex, int childIndex) {

        InputHolderFragment fragment = (InputHolderFragment) getParentFragment();
        //options är ju tom i det här fragmentet, hur ska vi lösa det?
        fragment.updateSyntax(optionIndex, options,childIndex);

    }

    
}
