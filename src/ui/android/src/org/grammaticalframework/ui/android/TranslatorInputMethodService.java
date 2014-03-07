package org.grammaticalframework.ui.android;

import android.inputmethodservice.InputMethodService;
import android.text.InputType;
import android.text.method.MetaKeyKeyListener;
import android.util.Log;
import android.view.KeyCharacterMap;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.CompletionInfo;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputConnection;

import java.util.ArrayList;
import java.util.List;


public class TranslatorInputMethodService extends InputMethodService 
        implements android.inputmethodservice.KeyboardView.OnKeyboardActionListener {

    private TranslatorKeyboardView mInputView;
    private CompletionsView mCandidateView;
    private CompletionInfo[] mCompletions;
    
    private StringBuilder mComposing = new StringBuilder();
    private boolean mPredictionOn;
    private boolean mCompletionOn;
    private boolean mCapsLock;
    private long mLastShiftTime;
    private long mMetaState;
    
    private TranslatorKeyboard mSymbolsPage1Keyboard;
    private TranslatorKeyboard mSymbolsPage2Keyboard;
    private TranslatorKeyboard mLanguagePage1Keyboard;
    private TranslatorKeyboard mLanguagePage2Keyboard;

    private TranslatorKeyboard mCurKeyboard;

    private int mActionId;

    private Translator mTranslator;

    @Override
    public void onCreate() {
        super.onCreate();
        
        mTranslator = ((GFTranslator) getApplicationContext()).getTranslator();
        
        mSymbolsPage1Keyboard = null;
        mSymbolsPage2Keyboard = null;
        mLanguagePage1Keyboard = null;
        mLanguagePage2Keyboard = null;
    }

    @Override
    public View onCreateInputView() {
        mInputView = (TranslatorKeyboardView)
        		getLayoutInflater().inflate(R.layout.input, null);
        mInputView.setOnKeyboardActionListener(this);
        mInputView.setKeyboard(mCurKeyboard);
        return mInputView;
    }

    @Override
    public View onCreateCandidatesView() {
        mCandidateView = new CompletionsView(this);
        mCandidateView.setService(this);
        return mCandidateView;
    }

    private int mModeId;
    private EditorInfo mAttribute;
    private static TranslatorInputMethodService mInstance;

    static TranslatorInputMethodService getInstance() {
    	return mInstance;
    }

    @Override
    public void onStartInput(EditorInfo attribute, boolean restarting) {
        super.onStartInput(attribute, restarting);

        // Reset our state.  We want to do this even if restarting, because
        // the underlying state of the text editor could have changed in any way.
        mComposing.setLength(0);
        updateCandidates();

        if (!restarting) {
            // Clear shift states.
            mMetaState = 0;
        }

        mPredictionOn = false;
        mCompletionOn = false;
        mCompletions = null;
    
    	int res1 =
           	mTranslator.getSourceLanguage().getKeyboardPage1Resource();
    	int res2 =
            mTranslator.getSourceLanguage().getKeyboardPage2Resource();
    	mModeId = R.string.normalKeyboardMode;
       	if (attribute.extras != null &&
            !attribute.extras.getBoolean("show_language_toggle", true)) {
       		mModeId = R.string.internalKeyboardMode;
       	}
       	mAttribute = attribute;
       	mLanguagePage1Keyboard = new TranslatorKeyboard(this, res1, mModeId);
       	mLanguagePage2Keyboard = new TranslatorKeyboard(this, res2, mModeId);
       	mSymbolsPage1Keyboard = new TranslatorKeyboard(this, R.xml.symbols_page1, mModeId);
        mSymbolsPage2Keyboard = new TranslatorKeyboard(this, R.xml.symbols_page2, mModeId);

        // We are now going to initialize our state based on the type of
        // text being edited.
        switch (attribute.inputType & InputType.TYPE_MASK_CLASS) {
            case InputType.TYPE_CLASS_NUMBER:
            case InputType.TYPE_CLASS_DATETIME:
                // Numbers and dates default to the symbols keyboard, with
                // no extra features.
                mCurKeyboard = mSymbolsPage1Keyboard;
                break;
                
            case InputType.TYPE_CLASS_PHONE:
                // Phones will also default to the symbols keyboard, though
                // often you will want to have a dedicated phone keyboard.
                mCurKeyboard = mSymbolsPage1Keyboard;
                break;
                
            case InputType.TYPE_CLASS_TEXT:
                // This is general text editing.  We will default to the
                // normal alphabetic keyboard, and assume that we should
                // be doing predictive text (showing candidates as the
                // user types).
                mCurKeyboard = mLanguagePage1Keyboard;
                mPredictionOn = true;
                
                // We now look for a few special variations of text that will
                // modify our behavior.
                int variation = attribute.inputType & InputType.TYPE_MASK_VARIATION;
                if (variation == InputType.TYPE_TEXT_VARIATION_PASSWORD ||
                        variation == InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD) {
                    // Do not display predictions / what the user is typing
                    // when they are entering a password.
                    mPredictionOn = false;
                }
                
                if (variation == InputType.TYPE_TEXT_VARIATION_EMAIL_ADDRESS
                        || variation == InputType.TYPE_TEXT_VARIATION_URI
                        || variation == InputType.TYPE_TEXT_VARIATION_FILTER) {
                    // Our predictions are not useful for e-mail addresses
                    // or URIs.
                    mPredictionOn = false;
                }
                
                if ((attribute.inputType & InputType.TYPE_TEXT_FLAG_AUTO_COMPLETE) != 0) {
                    // If this is an auto-complete text view, then our predictions
                    // will not be shown and instead we will allow the editor
                    // to supply their own.  We only show the editor's
                    // candidates when in full-screen mode, otherwise relying
                    // own it displaying its own UI.
                    mPredictionOn = false;
                    mCompletionOn = isFullscreenMode();
                }
                
                // We also want to look at the current state of the editor
                // to decide whether our alphabetic keyboard should start out
                // shifted.
                updateShiftKeyState(attribute);
                break;
                
            default:
                // For all unknown input types, default to the alphabetic
                // keyboard with no special features.
                mCurKeyboard = mLanguagePage1Keyboard;
                updateShiftKeyState(attribute);
        }
        
        mActionId = attribute.imeOptions & (EditorInfo.IME_MASK_ACTION | EditorInfo.IME_FLAG_NO_ENTER_ACTION);
        mLanguagePage1Keyboard.setImeOptions(getResources(), attribute.imeOptions);
        mLanguagePage2Keyboard.setImeOptions(getResources(), attribute.imeOptions);

        mInstance = this;
    }

    @Override
    public void onFinishInput() {
        super.onFinishInput();
        
        // Clear current composing text and candidates.
        mComposing.setLength(0);
        updateCandidates();
        
        // We only hide the candidates window when finishing input on
        // a particular editor, to avoid popping the underlying application
        // up and down if the user is entering text into the bottom of
        // its window.
        setCandidatesViewShown(false);
        
        mCurKeyboard = mLanguagePage1Keyboard;
        if (mInputView != null) {
            mInputView.closing();
        }

        mInstance = null;
        mAttribute = null;
    }
    
    @Override
    public void onStartInputView(EditorInfo attribute, boolean restarting) {
        super.onStartInputView(attribute, restarting);
        // Apply the selected keyboard to the input view.
        mInputView.setKeyboard(mCurKeyboard);
        mInputView.closing();
    }

    @Override
    public void onUpdateSelection(int oldSelStart, int oldSelEnd,
            int newSelStart, int newSelEnd,
            int candidatesStart, int candidatesEnd) {
        super.onUpdateSelection(oldSelStart, oldSelEnd, newSelStart, newSelEnd,
                candidatesStart, candidatesEnd);
        
        // If the current selection in the text view changes, we should
        // clear whatever candidate text we have.
        if (mComposing.length() > 0 && (newSelStart != candidatesEnd
                || newSelEnd != candidatesEnd)) {
            mComposing.setLength(0);
            updateCandidates();
            InputConnection ic = getCurrentInputConnection();
            if (ic != null) {
                ic.finishComposingText();
            }
        }
    }

    @Override
    public void onDisplayCompletions(CompletionInfo[] completions) {
        if (mCompletionOn) {
            mCompletions = completions;
            if (completions == null) {
                setSuggestions(null, false, false);
                return;
            }
            
            List<String> stringList = new ArrayList<String>();
            for (int i = 0; i < completions.length; i++) {
                CompletionInfo ci = completions[i];
                if (ci != null) stringList.add(ci.getText().toString());
            }
            setSuggestions(stringList, true, true);
        }
    }
    
    /**
     * This translates incoming hard key events in to edit operations on an
     * InputConnection.  It is only needed when using the
     * PROCESS_HARD_KEYS option.
     */
    private boolean translateKeyDown(int keyCode, KeyEvent event) {
        mMetaState = MetaKeyKeyListener.handleKeyDown(mMetaState,
                keyCode, event);
        int c = event.getUnicodeChar(MetaKeyKeyListener.getMetaState(mMetaState));
        mMetaState = MetaKeyKeyListener.adjustMetaAfterKeypress(mMetaState);
        InputConnection ic = getCurrentInputConnection();
        if (c == 0 || ic == null) {
            return false;
        }

        if ((c & KeyCharacterMap.COMBINING_ACCENT) != 0) {
            c = c & KeyCharacterMap.COMBINING_ACCENT_MASK;
        }
        
        if (mComposing.length() > 0) {
            char accent = mComposing.charAt(mComposing.length() -1 );
            int composed = KeyEvent.getDeadChar(accent, c);

            if (composed != 0) {
                c = composed;
                mComposing.setLength(mComposing.length()-1);
            }
        }
        
        onKey(c, null);
        
        return true;
    }
    
    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        switch (keyCode) {
            case KeyEvent.KEYCODE_BACK:
                // The InputMethodService already takes care of the back
                // key for us, to dismiss the input method if it is shown.
                // However, our keyboard could be showing a pop-up window
                // that back should dismiss, so we first allow it to do that.
                if (event.getRepeatCount() == 0 && mInputView != null) {
                    if (mInputView.handleBack()) {
                        return true;
                    }
                }
                break;
                
            case KeyEvent.KEYCODE_DEL:
                // Special handling of the delete key: if we currently are
                // composing text for the user, we want to modify that instead
                // of let the application to the delete itself.
                if (mComposing.length() > 0) {
                    onKey(TranslatorKeyboard.KEYCODE_DELETE, null);
                    return true;
                }
                break;
                
            case KeyEvent.KEYCODE_ENTER:
                // Let the underlying text editor always handle these.
                return false;
                
            default:
                if (mPredictionOn && translateKeyDown(keyCode, event)) {
                    return true;
                }
        }
        
        return super.onKeyDown(keyCode, event);
    }

    /**
     * Helper function to commit any text being composed in to the editor.
     */
    private void commitTyped(InputConnection inputConnection) {
        if (mComposing.length() > 0) {
            inputConnection.commitText(mComposing, mComposing.length());
            mComposing.setLength(0);
            updateCandidates();
        }
    }

    /**
     * Helper to update the shift state of our keyboard based on the initial
     * editor state.
     */
    private void updateShiftKeyState(EditorInfo attr) {
        if (attr != null && mInputView != null && 
            (mLanguagePage1Keyboard == mInputView.getKeyboard() ||
             mLanguagePage2Keyboard == mInputView.getKeyboard())) {
            int caps = 0;
            EditorInfo ei = getCurrentInputEditorInfo();
            if (ei != null && ei.inputType != InputType.TYPE_NULL) {
                caps = getCurrentInputConnection().getCursorCapsMode(attr.inputType);
            }
            mInputView.setShifted(mCapsLock || caps != 0);
        }
    }

    /**
     * Helper to send a key down / key up pair to the current editor.
     */
    private void keyDownUp(int keyEventCode) {
        getCurrentInputConnection().sendKeyEvent(
                new KeyEvent(KeyEvent.ACTION_DOWN, keyEventCode));
        getCurrentInputConnection().sendKeyEvent(
                new KeyEvent(KeyEvent.ACTION_UP, keyEventCode));
    }
    
    // Implementation of KeyboardViewListener
    public void onKey(int primaryCode, int[] keyCodes) {
        if (primaryCode == TranslatorKeyboard.KEYCODE_DELETE) {
            handleBackspace();
        } else if (primaryCode == TranslatorKeyboard.KEYCODE_SHIFT) {
            handleShift();
        } else if (primaryCode == TranslatorKeyboard.KEYCODE_SOURCE_LANGUAGE
                && mInputView != null) {
        	mTranslator.switchLanguages();
            handleSwitchLanguages();
        } else if (primaryCode < TranslatorKeyboard.KEYCODE_SOURCE_LANGUAGE &&
        		   primaryCode > TranslatorKeyboard.KEYCODE_SOURCE_LANGUAGE-TranslatorKeyboard.MAX_LANGUAGE_KEYCODES) {
        	Language newSource = 
        		mTranslator.getAvailableLanguages().get(TranslatorKeyboard.KEYCODE_SOURCE_LANGUAGE-primaryCode-1);
            mTranslator.setSourceLanguage(newSource);
            handleChangeSourceLanguage(newSource);
        } else if (primaryCode == TranslatorKeyboard.KEYCODE_TARGET_LANGUAGE) {
        	String translation = mTranslator.translate(mComposing.toString());
        	getCurrentInputConnection().commitText(translation, 1);
            return;
        }  else if (primaryCode < TranslatorKeyboard.KEYCODE_TARGET_LANGUAGE &&
         		   primaryCode > TranslatorKeyboard.KEYCODE_TARGET_LANGUAGE-TranslatorKeyboard.MAX_LANGUAGE_KEYCODES) {
         	Language newTarget =
         		mTranslator.getAvailableLanguages().get(TranslatorKeyboard.KEYCODE_TARGET_LANGUAGE-primaryCode-1);
             mTranslator.setTargetLanguage(newTarget);
             handleChangeTargetLanguage(newTarget);
         } else if (primaryCode == TranslatorKeyboard.KEYCODE_MODE_CHANGE &&
                    mInputView != null) {
        	TranslatorKeyboard current = (TranslatorKeyboard) mInputView.getKeyboard();
            if (current == mSymbolsPage1Keyboard || current == mSymbolsPage2Keyboard) {
                current = mLanguagePage1Keyboard;
            } else {
                current = mSymbolsPage1Keyboard;
            }
            mInputView.setKeyboard(current);
            if (current == mSymbolsPage1Keyboard) {
                current.setShifted(false);
            }
        } else if (primaryCode == TranslatorKeyboard.KEYCODE_PAGE_CHANGE &&
                   mInputView != null) {
        	TranslatorKeyboard current = (TranslatorKeyboard) mInputView.getKeyboard();
            if (current == mLanguagePage1Keyboard) {
                current = mLanguagePage2Keyboard;
            } else {
                current = mLanguagePage1Keyboard;
            }
            mInputView.setKeyboard(current);
    	} else if (primaryCode == 10) {
        	if ((mActionId & EditorInfo.IME_FLAG_NO_ENTER_ACTION) == 0)
        		getCurrentInputConnection().performEditorAction(mActionId & EditorInfo.IME_MASK_ACTION);
        	else
        		handleCharacter(primaryCode, keyCodes);
        } else if (primaryCode == ' ' && mComposing.length() == 0) {
        	getCurrentInputConnection().commitText(" ", 1);
        } else {
            handleCharacter(primaryCode, keyCodes);
        }
    }

    public void onText(CharSequence text) {
        InputConnection ic = getCurrentInputConnection();
        if (ic == null) return;
        ic.beginBatchEdit();
        if (mComposing.length() > 0) {
            commitTyped(ic);
        }
        ic.commitText(text, 0);
        ic.endBatchEdit();
        updateShiftKeyState(getCurrentInputEditorInfo());
    }

    /**
     * Update the list of available candidates from the current composing
     * text.  This will need to be filled in by however you are determining
     * candidates.
     */
    private void updateCandidates() {
        if (!mCompletionOn) {
            if (mComposing.length() > 0) {
                List<String> list = 
                	mTranslator.lookupWordPrefix(mComposing.toString());
                list.add(0, mComposing.toString());
                setSuggestions(list, true, true);
                Log.d("KEYBOARD", mComposing.toString());
            } else {
                setSuggestions(null, false, false);
            }
        }
    }
    
    public void setSuggestions(List<String> suggestions, boolean completions,
            boolean typedWordValid) {
        if (suggestions != null && suggestions.size() > 0) {
            setCandidatesViewShown(true);
        } else if (isExtractViewShown()) {
            setCandidatesViewShown(true);
        }
        if (mCandidateView != null) {
            mCandidateView.setSuggestions(suggestions, completions, typedWordValid);
        }
    }
    
    private void handleBackspace() {
        final int length = mComposing.length();
        if (length > 1) {
            mComposing.delete(length - 1, length);
            getCurrentInputConnection().setComposingText(mComposing, 1);
            updateCandidates();
        } else if (length > 0) {
            mComposing.setLength(0);
            getCurrentInputConnection().commitText("", 0);
            updateCandidates();
        } else {
            keyDownUp(KeyEvent.KEYCODE_DEL);
        }
        updateShiftKeyState(getCurrentInputEditorInfo());
    }

    private void handleShift() {
        if (mInputView == null) {
            return;
        }
        
        TranslatorKeyboard currentKeyboard = (TranslatorKeyboard) mInputView.getKeyboard();
        if (mLanguagePage1Keyboard == currentKeyboard ||
        	mLanguagePage2Keyboard == currentKeyboard) {
            // Alphabet keyboard
            checkToggleCapsLock();
            mInputView.setShifted(mCapsLock || !mInputView.isShifted());
        } else if (currentKeyboard == mSymbolsPage1Keyboard) {
            mSymbolsPage1Keyboard.setShifted(true);
            mInputView.setKeyboard(mSymbolsPage2Keyboard);
            mSymbolsPage2Keyboard.setShifted(true);
        } else if (currentKeyboard == mSymbolsPage2Keyboard) {
            mSymbolsPage2Keyboard.setShifted(false);
            mInputView.setKeyboard(mSymbolsPage1Keyboard);
            mSymbolsPage1Keyboard.setShifted(false);
        }
    }
    
    private void handleCharacter(int primaryCode, int[] keyCodes) {
        if (keyCodes.length > 0 && keyCodes[0] > 0) {
	        for (int i = 0; i < keyCodes.length && keyCodes[i] > 0; i++) {
	        	int code = keyCodes[i];
	        	if (mInputView.isShifted())
	                code = Character.toUpperCase(code);
	        	mComposing.append((char) code);
	        }
        } else {
        	if (mInputView.isShifted())
                primaryCode = Character.toUpperCase(primaryCode);
        	mComposing.append((char) primaryCode);
        }

        if (primaryCode == 10)
        	commitTyped(getCurrentInputConnection());
        else
        	getCurrentInputConnection().setComposingText(mComposing, 1);
        updateShiftKeyState(getCurrentInputEditorInfo());

        if (mPredictionOn) {
            updateCandidates();
        }
    }

    private void handleClose() {
        commitTyped(getCurrentInputConnection());
        requestHideSelf(0);
        mInputView.closing();
    }

    void handleChangeSourceLanguage(Language newSource) {
       	updateLanguageKeyboard(newSource);
       	mSymbolsPage1Keyboard.updateLanguageKeyLabels();
        mSymbolsPage2Keyboard.updateLanguageKeyLabels();
        if (mInputView != null) {
        	mInputView.setKeyboard(mCurKeyboard);
        }
    }

    void handleChangeTargetLanguage(Language newTarget) {
    	mLanguagePage1Keyboard.updateLanguageKeyLabels();
    	mLanguagePage2Keyboard.updateLanguageKeyLabels();
    	mSymbolsPage1Keyboard.updateLanguageKeyLabels();
    	mSymbolsPage2Keyboard.updateLanguageKeyLabels();
    	if (mInputView != null) {
    		mInputView.invalidateAllKeys();
    	}
    }

    void handleSwitchLanguages() {
    	Language newSource = mTranslator.getSourceLanguage();
    	updateLanguageKeyboard(newSource);
       	mSymbolsPage1Keyboard.updateLanguageKeyLabels();
        mSymbolsPage2Keyboard.updateLanguageKeyLabels();
        if (mInputView != null)
        	mInputView.setKeyboard(mCurKeyboard);
    }

	private void updateLanguageKeyboard(Language language) {
		TranslatorKeyboard keyboard1 =
       		new TranslatorKeyboard(this, language.getKeyboardPage1Resource(), mModeId);
		TranslatorKeyboard keyboard2 =
	       	new TranslatorKeyboard(this, language.getKeyboardPage2Resource(), mModeId);
		keyboard1.setImeOptions(getResources(), mAttribute.imeOptions);
		keyboard2.setImeOptions(getResources(), mAttribute.imeOptions);
		if (mCurKeyboard == mLanguagePage1Keyboard) {
			mCurKeyboard = keyboard1;
		} else if (mCurKeyboard == mLanguagePage2Keyboard) {
			mCurKeyboard = keyboard2;
		}
		mLanguagePage1Keyboard = keyboard1;
		mLanguagePage2Keyboard = keyboard2;
	}

    private void checkToggleCapsLock() {
        long now = System.currentTimeMillis();
        if (mLastShiftTime + 800 > now) {
            mCapsLock = !mCapsLock;
            mLastShiftTime = 0;
        } else {
            mLastShiftTime = now;
        }
    }

    public void pickDefaultCandidate() {
        pickSuggestionManually(0);
    }
    
    public void pickSuggestionManually(int index) {
        if (mCompletionOn && mCompletions != null && index >= 0
                && index < mCompletions.length) {
            CompletionInfo ci = mCompletions[index];
            getCurrentInputConnection().commitCompletion(ci);
            if (mCandidateView != null) {
                mCandidateView.clear();
            }
            updateShiftKeyState(getCurrentInputEditorInfo());
        } else if (mComposing.length() > 0) {
            // If we were generating candidate suggestions for the current
            // text, we would commit one of them here.  But for this sample,
            // we will just commit the current text.
            commitTyped(getCurrentInputConnection());
        }
    }
    
    public void swipeRight() {
        if (mCompletionOn) {
            pickDefaultCandidate();
        }
    }
    
    public void swipeLeft() {
        handleBackspace();
    }

    public void swipeDown() {
        handleClose();
    }

    public void swipeUp() {
    }
    
    public void onPress(int primaryCode) {
    }
    
    public void onRelease(int primaryCode) {
    }
}
