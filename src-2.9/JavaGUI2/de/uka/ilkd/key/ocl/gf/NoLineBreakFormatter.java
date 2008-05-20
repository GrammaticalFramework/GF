package de.uka.ilkd.key.ocl.gf;

import java.util.logging.Formatter;
import java.util.logging.LogRecord;

/**
 * @author daniels
 * A simple Formatter class, that does not introduce linebreaks, so that
 * continous lines can be read under each other.
 */
public class NoLineBreakFormatter extends Formatter {

        /** 
         * @see java.util.logging.Formatter#format(java.util.logging.LogRecord)
         */
        public String format(LogRecord record) {
                final String shortLoggerName = record.getLoggerName().substring(record.getLoggerName().lastIndexOf('.') + 1);
                return record.getLevel() + " : "
                + shortLoggerName + " "
                + record.getSourceMethodName() + " -:- "
                + record.getMessage() + "\n";
        }
}
