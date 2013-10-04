package org.grammaticalframework.ui.android;

import android.text.TextUtils;

import java.util.Locale;

/**
 * Collections of utils to handle locales.
 */
public class LocaleUtils {

    /**
     * Parses a locale string formatted by {@link Locale#toString()}.
     *
     * @return the parsed {@code Locale} or {@code defaultLocale} if the input was null or empty.
     */
    public static Locale parseJavaLocale(String localeString, Locale defaultLocale) {
        if (TextUtils.isEmpty(localeString)) {
            return defaultLocale;
        }
        final char separator = '_';
        int pos1 = localeString.indexOf(separator);
        if (pos1 == -1) {
            return new Locale(localeString);
        }
        String language = localeString.substring(0, pos1);

        int start2 = pos1 + 1;
        int pos2 = localeString.indexOf(separator, start2);
        if (pos2 == -1) {
            return new Locale(language, localeString.substring(start2));
        }
        String country = localeString.substring(start2, pos2);

        int start3 = pos2 + 1;
        int pos3 = localeString.indexOf(separator, start3);
        String variant = (pos3 == -1)
                ? localeString.substring(start3)
                : localeString.substring(start3, pos3);
        return new Locale(language, country, variant);
    }
}
