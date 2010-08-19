;;; gf.el --- Major mode for editing GF code -*-coding: iso-8859-1;-*-

;; Copyright (C) 2005, 2006, 2007  Johan Bockgård
;; Time-stamp: <2007-06-16 11:57:48 bojohan>

;; Author: Johan Bockgård <bojohan+mail@dd.chalmers.se>
;; Keywords: languages

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; Major mode for editing GF code, with support for running a GF
;; shell.

;;; Usage:

;; To use this library, put it somewhere Emacs can find it (in
;; `load-path') and add the following lines to your .emacs file.

;; (autoload 'run-gf "gf" nil t)
;; (autoload 'gf-mode "gf" nil t)
;; (add-to-list 'auto-mode-alist '("\\.gf\\(\\|e\\|r\\|cm?\\)\\'" . gf-mode))
;; (add-to-list 'auto-mode-alist '("\\.cf\\'" . gf-mode))
;; (add-to-list 'auto-mode-alist '("\\.ebnf\\'" . gf-mode))

;;; History:

;; 2006-10-30:
;;   	 let a = b
;;   	     c = d ...
;;   	 in ...
;;   indentation now works (most of the time).

;;; Code:

(eval-when-compile (require 'cl))

(defgroup gf nil
  "Support for GF (Grammatical Framework)"
  :group 'languages
  ;; :link  '(emacs-commentary-link "gf")
  :link  '(url-link "http://www.cs.chalmers.se/~aarne/GF/"))

(defvar gf-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\C-c\C-l"  'gf-load-file)
    (define-key map "\C-c\C-b"  'gf-display-inf-buffer)
    (define-key map "\C-c\C-s"  'run-gf)
    (define-key map (kbd "DEL") 'backward-delete-char-untabify)
    map)
  "Keymap for `gf-mode'.")

;; Taken from haskell-mode
(defvar gf-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?\   " "  table)
    (modify-syntax-entry ?\t  " "  table)
    (modify-syntax-entry ?\"  "\"" table)
    (modify-syntax-entry ?\'  "\'" table)
    (modify-syntax-entry ?_   "w"  table)
    (modify-syntax-entry ?\(  "()" table)
    (modify-syntax-entry ?\)  ")(" table)
    (modify-syntax-entry ?\[  "(]" table)
    (modify-syntax-entry ?\]  ")[" table)
    ;; (modify-syntax-entry ?\<  "(>" table)
    ;; (modify-syntax-entry ?\>  ")<" table)

    (cond ((featurep 'xemacs)
	   ;; I don't know whether this is equivalent to the below
	   ;; (modulo nesting).  -- fx
	   (modify-syntax-entry ?{  "(}5" table)
	   (modify-syntax-entry ?}  "){8" table)
	   (modify-syntax-entry ?-  "_ 1267" table))
	  (t
	   ;; The following get comment syntax right, similarly to C++
	   ;; In Emacs 21, the `n' indicates that they nest.
	   ;; The `b' annotation is actually ignored because it's only
	   ;; meaningful on the second char of a comment-starter, so
	   ;; on Emacs 20 and before we get wrong results.  --Stef
	   (modify-syntax-entry ?\{  "(}1nb" table)
	   (modify-syntax-entry ?\}  "){4nb" table)
	   (modify-syntax-entry ?-  "_ 123" table)))
    (modify-syntax-entry ?\n ">" table)

    (let (i lim)
      (map-char-table
       (lambda (k v)
	 (when (equal v '(1))
	   ;; The current Emacs 22 codebase can pass either a char
	   ;; or a char range.
	   (if (consp k)
	       (setq i (car k)
		     lim (cdr k))
	     (setq i k
		   lim k))
	   (while (<= i lim)
	     (when (> i 127)
	       (modify-syntax-entry i "_" table))
	     (setq i (1+ i)))))
       (standard-syntax-table)))

    (modify-syntax-entry ?\` "$`" table)
    (modify-syntax-entry ?\\ "\\" table)
    (mapcar (lambda (x)
	      (modify-syntax-entry x "_" table))
	    ;; Some of these are actually OK by default.
	    "!#$%&*+./:=?@^|~")
    (unless (featurep 'mule)
      ;; Non-ASCII syntax should be OK, at least in Emacs.
      (mapcar (lambda (x)
		(modify-syntax-entry x "_" table))
	      (concat "¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿"
		      "×÷"))
      (mapcar (lambda (x)
		(modify-syntax-entry x "w" table))
	      (concat "ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ"
		      "ØÙÚÛÜÝÞß"
		      "àáâãäåæçèéêëìíîïðñòóôõö"
		      "øùúûüýþÿ")))
    table)
  "Syntax table used in GF mode.")

;; Lin         PType     Str        Strs       Tok        Type
;; abstract    case      cat        concrete   data       def
;; flags       fn        fun        grammar    in         include
;; incomplete  instance  interface  let        lin        lincat
;; lindef      lintype   of         open       oper       out
;; package     param     pattern    pre        printname  resource
;; reuse       strs      table      tokenizer  transfer   union
;; var         variants  where      with
;;   ; = { } ( ) : -> ** , [ ] - . | % ? < > @ ! * \ => ++ + _ $ /

;; Judgements
(defvar gf-top-level-keywords
  '("cat" "fun" "lincat" "lintype" "lin" "pattern"
    "oper" "def" "param" "flags" "lindef" "printname"
    "data" "transfer"
    ))

(defvar gf-module-keywords
  '("abstract" "concrete" "resource" "instance" "interface"))

(defvar gf-keywords
  (append '("of" "let" "include" "open" "in" "where"
	    "with" "case" "incomplete" "table"
	    "variants" "pre" "strs" "overload")
	  gf-top-level-keywords
	  gf-module-keywords))

(defvar gf-top-level-keyword-regexp (regexp-opt gf-top-level-keywords 'words))
(defvar gf-keyword-regexp (regexp-opt gf-keywords 'words))

(defvar gf-font-lock-keywords
  (let ((sym "\\(\\s_\\|\\\\\\)+")
	;; (keyw gf-keyword-regexp)
	(mod (concat (regexp-opt gf-module-keywords 'words)
		     "\\s-\\(\\w+\\)"))
	(pface '(if (boundp 'font-lock-preprocessor-face)
		    font-lock-preprocessor-face
		  font-lock-builtin-face)))
    `(;; Module
      (,mod (1 font-lock-keyword-face)
	    (2 font-lock-type-face))
      ;; Keywords
      (,(lambda (end)
	  (let (parse-sexp-lookup-properties)
	    (re-search-forward gf-keyword-regexp end t)))
       . font-lock-keyword-face)
      ;; Operators
      (,sym  . font-lock-variable-name-face)
      ;; Pragmas
      ("^--\\(#.*\\)" (1 ,pface prepend))
      ("--\\(#\\s-*\\(notpresent\\|prob\\).*\\)" (1 ,pface prepend))
      ;; GFDoc
      ("^--[0-9]+\\s-*\\(.*\\)" (1 'underline prepend))
      ("^--\\([*!.]\\)"         (1 'underline prepend))
      (,(lambda (end)
	  (let (found)
	    (while
		(and (setq found (re-search-forward
				  ;; "\\$.*?\\$\\|\\*.*?\\*\\|\".*?\""
				  "\\$.*?\\$"
				  end t))
		     (not (eq (get-text-property (match-beginning 0) 'face)
			      'font-lock-comment-face))))
	    found))
       (0 (if (face-italic-p 'font-lock-comment-face)
	      '((:slant normal))
	    '((:slant italic)))
	  prepend))
      ;; Types (?)
      ;; ("[^.]\\(\\<[[:upper:]]\\w*\\)[^.]" 1 font-lock-type-face)
      ))
  "Keyword highlighting specification for `gf-mode'.")

(defcustom gf-let-brace-style t
  "The let...in style to use for indentaton.

A value of t means unbraced (new) style:


     let x = a;
         y = b; in ...

A value of nil means braced (old) style

     let { x = a;
           y = b; } in ...

Anything else means try to guess."
  :type '(choice (const :tag "Unbraced"  t)
		 (const :tag "Braced"    nil)
		 (const :tag "Heuristic" 'heuristic))
  :group 'gf)

;; let x = let a = f;
;;             b = g;
;;       in b;
;;     y = d;
;;   in h
(defun gf-match-let/in (let/in end)
  (when gf-let-brace-style
    (if (eq 'let let/in)
	(and (re-search-forward "\\<le\\(t\\)\\>" end t)
	     (or (eq t gf-let-brace-style)
		 (save-excursion
		   (skip-syntax-forward " ")
		   (not (eq ?\{ (char-after))))))
      (and (re-search-forward "\\<\\(i\\)n\\>" end t)
	   (or (eq t gf-let-brace-style)
	       (save-excursion
		 (backward-char 2)
		 (skip-syntax-backward " ")
		 (not (eq ?\} (char-before)))))))))

(defvar gf-font-lock-syntactic-keywords
  `(;; let ...
    (,(lambda (end) (gf-match-let/in 'let end))
     1 "(")
    ;; ;; open ...
    ;; (,(lambda (end)
    ;; 	(and (re-search-forward "\\<ope\\(n\\)\\>" end t)
    ;; 	     (save-excursion
    ;; 	       (skip-syntax-forward " ")
    ;; 	       (not (eq ?\{ (char-after))))))
    ;;  1 "(")
    ;; ... in
    (,(lambda (end) (gf-match-let/in 'in end))
     1 ")")
    ))

 ;; (defvar gf-imenu-generic-expression
 ;;   ...)

 ;; (defvar gf-outline-regexp
 ;;   ...)

;;;###autoload
(define-derived-mode gf-mode fundamental-mode "GF"
  "A major mode for editing GF files."
  ;; (set (make-local-variable 'imenu-generic-expression)
  ;;      gf-imenu-generic-expression)
  ;; (set (make-local-variable 'outline-regexp) sample-outline-regexp)
  (set (make-local-variable 'comment-start) "-- ")
  (set (make-local-variable 'comment-start-skip) "[-{]-[ \t]*")
  (set (make-local-variable 'font-lock-defaults)
       '(gf-font-lock-keywords
	 nil nil nil nil
	 (font-lock-syntactic-keywords . gf-font-lock-syntactic-keywords)
	 ))
  (set (make-local-variable 'indent-line-function) 'gf-indent-line)
  (set (make-local-variable 'eldoc-documentation-function) 'gf-doc-display)
  (set (make-local-variable 'beginning-of-defun-function)
       'gf-beginning-of-section)
  (set (make-local-variable 'end-of-defun-function)
       'gf-end-of-section))

;;; Indentation
(defcustom gf-indent-basic-offset 2
  "*Number of columns to indent in GF mode."
  :type 'integer
  :group 'gf)

(defcustom gf-indent-judgment-offset 2
  "*Column where judement should be indented to."
  :type 'integer
  :group 'gf)

(defun gf-indent-line ()
  "Indent current line of GF code."
  (interactive)
  (save-excursion
    (font-lock-fontify-syntactic-keywords-region
     (point-at-bol) (point-at-bol)))
  (let* ((case-fold-search nil)
	 (parse-sexp-lookup-properties t)
	 (parse-sexp-ignore-comments t)
	 (savep (> (current-column) (current-indentation)))
	 (indent (condition-case err
		     (max (gf-calculate-indentation) 0)
		   (error (message "%s" err) 0))))
    (if savep
	(save-excursion (indent-line-to indent))
      (indent-line-to indent))))

(defun gf-beginning-of-section ()
  (when (re-search-backward
	 (concat "^\\s-*" gf-top-level-keyword-regexp)
	 nil 'move)
    (goto-char (match-beginning 0)))
  (point))

(defun gf-end-of-section ()
  (gf-forward-comment)
  (when (looking-at gf-top-level-keyword-regexp)
    (goto-char (match-end 0)))
  (when (re-search-forward
	 (concat "^\\s-*" gf-top-level-keyword-regexp)
	 (condition-case nil
	     (1- (scan-lists (point) 1 1))
	   (error nil))
	 'move)
    (goto-char (match-beginning 0)))
  (gf-backward-comment)
  (point))

;; (defun gf-beginning-of-defun ()
;;   (let* ((beg (save-excursion (gf-beginning-of-section) (point)))
;; 	 (end (save-excursion (progn (forward-line 0) (point))))
;; 	 (pps (parse-partial-sexp beg end)))
;;     (when (nth 1 pps) (backward-up-list (nth 0 pps)))
;;     (back-to-indentation)
;;     (point)))

(defun gf-beginning-of-sequence (&optional keep-going limit)
  (or limit (let ((com-start (gf-in-comment-p)))
	      (when com-start
		(save-excursion
		  (goto-char com-start)
		  (skip-chars-forward "{")
		  (skip-chars-forward "-")
		  (setq limit (point))))))
  (let* ((str "[;]")
	 (found-it nil)
	 (pps   (gf-ppss))
	 (depth (or (nth 0 pps) 0))
	 (bol   (point-at-bol))
	 (lim   (max (or limit (point-min))
		     (if (nth 1 pps)
			 (1+ (nth 1 pps))
		       (save-excursion
			 (gf-beginning-of-section)
			 (when (looking-at
				(concat "\\s-*" gf-top-level-keyword-regexp))
			   (goto-char (match-end 0))
			   (gf-forward-comment))
			 (point))))))
    (while (and (> (point) lim)
		(setq found-it (re-search-backward str lim 'move))
		(let ((pps (gf-ppss)))
		  (or (/= depth (nth 0 pps))
		      (nth 3 pps)
		      (nth 4 pps)))))
    (when found-it
      (when keep-going
	(setq lim (max lim bol))
	(while (and (> (point) lim)
		    (setq found-it (re-search-backward str lim 'move))
		    ;;(/= depth (nth 0 (gf-ppss)))
		    )))
      (when found-it (forward-char)))))

(defun gf-in-comment-p ()
  (let ((pps (gf-ppss)))
    (and (nth 4 pps) (nth 8 pps))))

(defun gf-forward-comment () (forward-comment (buffer-size)))
(defun gf-backward-comment ()
  (forward-comment (- (buffer-size)))
  ;; (while (or (not (zerop (skip-chars-backward " \t\n")))
  ;; 	     (let  ((start (gf-in-comment)))
  ;; 	       (and start (goto-char start)))))
  )


(defun gf-ppss ();; (&optional from to)
  (parse-partial-sexp
   (save-excursion (gf-beginning-of-section))
   (point)))

(if (fboundp 'syntax-after)
    (defalias 'gf-syntax-after 'syntax-after)
  (defun gf-syntax-after (pos)
    "Return the raw syntax of the char after POS.
If POS is outside the buffer's accessible portion, return nil."
    (unless (or (< pos (point-min)) (>= pos (point-max)))
      (let ((st (if parse-sexp-lookup-properties
		    (get-char-property pos 'syntax-table))))
	(if (consp st) st
	  (aref (or st (syntax-table)) (char-after pos)))))))

(if (fboundp 'syntax-class)
    (defalias 'gf-syntax-class 'syntax-class)
  (defun gf-syntax-class (syntax)
    "Return the syntax class part of the syntax descriptor SYNTAX.
If SYNTAX is nil, return nil."
    (and syntax (logand (car syntax) 65535))))

(defun gf-calculate-indentation ()
  "Return the column to which the current line should be indented."
  (save-excursion
    (forward-line 0)
    (skip-chars-forward " \t")
    (cond
     ;; judgement
     ((looking-at gf-top-level-keyword-regexp)
      gf-indent-judgment-offset)
     ((and gf-let-brace-style
	   (looking-at "in\\>"))
      (if (condition-case nil
	      (progn (backward-up-list)
		     nil)
	    (error t))
	  gf-indent-basic-offset
	(gf-beginning-of-sequence)
	(if (= (point) (point-min))
	    0
	  (gf-forward-comment)
	  (+ gf-indent-basic-offset (current-column)))))
     ((looking-at "[]})]")
      ;; (looking-at "[]})]")
      ;; (eq 5 (gf-syntax-class (gf-syntax-after (point))))
      (backward-up-list)
      (gf-beginning-of-sequence)
      (if (= (point) (point-min))
	  0
	(gf-forward-comment)
	(+ gf-indent-basic-offset (current-column))))
     ;; heading
     ((looking-at "---")
      (gf-beginning-of-sequence)
      (if (= (point) (point-min))
	  0
	gf-indent-judgment-offset))
     (t
      (let ((opoint (point)))
	(gf-backward-comment)
	(cond
	  ((eq  ?\; (char-before))
	   ;; ?\,
	   (backward-char)
	   (gf-beginning-of-sequence t)
	   (gf-forward-comment)
	   (current-column))
	  (;; (memq (char-before) '( ?\{ ?\[ ?\( ;; ?\<
	   ;; 			      ))
	   (eq 4 (gf-syntax-class (gf-syntax-after (1- (point)))))
	   (backward-char)
	   ;; alt. (gf-beginning-of-sequence nil nil)
	   (gf-beginning-of-sequence nil (point-at-bol))
	   (gf-forward-comment)
	   ;; alt. (+ (* 2 gf-indent-basic-offset) (current-column)))
	   (+ gf-indent-basic-offset (current-column)))
	  (t
	   (gf-beginning-of-sequence)
	   (let ((head (= (point) (point-min))))
	     (gf-forward-comment)
	     (cond
	      ;; ((< opoint (point)) 0)
	      ((> opoint (point)) (+ gf-indent-basic-offset (current-column)))
	      ;; i.e. opoint == (point)
	      (head 0)
	      (t    (gf-beginning-of-section)
		    (skip-chars-forward " \t")
		    (+ gf-indent-basic-offset (current-column))))))))))))

(defun gf-load-file ()
  (interactive)
  (start-gf)
  (comint-send-string gf-process (format "i %s\n" buffer-file-name))
  (gf-clear-lang-cache)
  (gf-display-inf-buffer))

(defun gf-display-inf-buffer ()
  (interactive)
  (and (get-buffer gf-process-buffer-name)
       (display-buffer gf-process-buffer-name)))

;; Inferior GF Mode ----------------

(defcustom gf-program-name "gf"
  "*Name of GF shell invoked by `run-gf'."
  :type 'file
  :group 'gf)
(defvar gf-program-args nil "*Arguments passed to GF by `run-gf'.")
(defvar gf-process-buffer-name "*gf*")
(defvar gf-process)

(require 'comint)

(define-derived-mode inf-gf-mode comint-mode "Inf-GF"
  (gf-setup-pcomplete))

(define-key inf-gf-mode-map "\t" 'gf-complete)

;;;###autoload
(defun run-gf ()
  "Run an inferior GF process."
  (interactive)
  (start-gf)
  (pop-to-buffer gf-process-buffer-name))

(defun start-gf ()
  (unless (comint-check-proc gf-process-buffer-name)
    (with-current-buffer
	(apply 'make-comint-in-buffer
	       "gf" gf-process-buffer-name gf-program-name
	       nil gf-program-args)
      (setq gf-process (get-buffer-process (current-buffer)))
      (set-buffer-process-coding-system 'latin-1-unix 'latin-1-unix)
      (inf-gf-mode))))

;; (defun gf-norm-func (string)
;;   (if (string-match "\\(.*\\)\\(=[^=]*\\)" string)
;;       (match-string 1 string)
;;     string))

;; (defmacro gf-pcomplete-here (&optional form stub paring form-only)
;;   `(pcomplete-here ,form ,stub (or ,paring 'gf-norm-func) ,form-only))
;; (put 'gf-pcomplete-here 'edebug-form-spec t)

(put 'pcomplete-here 'edebug-form-spec t)

(defun gf-setup-pcomplete ()
  (set (make-local-variable 'comint-prompt-regexp) "^[^>\n]*> *")
  (set (make-local-variable 'pcomplete-ignore-case) nil)
  (set (make-local-variable 'pcomplete-use-paring)  t)
  (set (make-local-variable 'pcomplete-suffix-list) '(?/ ?=))
  ;; (set (make-local-variable 'comint-dynamic-complete-functions)
  ;;      (add-to-list 'comint-dynamic-complete-functions 'pcomplete))
  (set (make-local-variable 'pcomplete-parse-arguments-function)
       'gf-parse-arguments)
  (set (make-local-variable 'pcomplete-command-completion-function)
       'gf-complete-command)
  ;; (set (make-local-variable 'pcomplete-command-name-function)
  ;;      'pcomplete-erc-command-name)
  (set (make-local-variable 'pcomplete-default-completion-function)
       'gf-default-completion-function)
  (add-hook 'comint-input-filter-functions
	    'gf-watch-for-loading
	    nil t))

(defun gf-watch-for-loading (string)
  (when (string-match (concat "\\(\\`\\||\\;;\\)\\s-*"
			      (regexp-opt '("i" "e" "rl") 'words))
		      string)
    (gf-clear-lang-cache)))

(defun gf-parse-arguments ()
  "Parse whitespace separated arguments in the current region."
  (let ((begin (save-excursion
		 ;; (parse-partial-sexp begin end)
		 (if (re-search-backward "|\\|;;" (point-at-bol) t)
		     (match-end 0)
		   (comint-bol nil)
		   (point))))
	(end (point))
	begins args)
    (save-excursion
      (goto-char begin)
      (while (< (point) end)
	(skip-chars-forward " \t\n")
	(setq begins (cons (point) begins))
	(let ((skip t))
	  (while skip
	    (skip-chars-forward "^ \t\n")
	    (if (eq (char-before) ?\\)
		(skip-chars-forward " \t\n")
	      (setq skip nil))))
	(setq args (cons (buffer-substring-no-properties
			  (car begins) (point))
			 args)))
      (cons (reverse args) (reverse begins)))))

(defun gf-complete ()
  (interactive)
  ;; (setq this-command 'pcomplete)
  (pcomplete))

(defun gf-default-completion-function ()
  (pcomplete-here (pcomplete-entries)))

(defun gf-complete-command ()
  (pcomplete-here (gf-complete-commands)))

(defun gf-complete-commands () gf-short-command-names)

;; (defun gf-complete-flagify (flags)
;;   (mapcar (lambda (s) (concat s "=")) flags))

(defvar gf-short-command-names
  '("i" "rl" "e" "sf" "s" "pg" "pm" "vg" "po" "pl" "pi"
    "eh" "ph" "l" "p" "tt" "cc" "so" "t" "gr" "gt" "ma"
    "ps" "pt" "st" "wt" "vt" "es" "ts" "tq" "tl" "mq"
     "ml" "rf" "wf" "af" "tg" "cl" "sa" "h" "q" "!"))

(defvar gf-long-command-names
  '("import" "remove_language" "empty" "set_flags" "strip"
    "print_grammar" "print_multigrammar" "visualize_graph"
    "print_options" "print_languages" "print_info"
    "execute_history" "print_history" "linearize" "parse" "test_tokenizer"
    "compute_concrete" "show_operations" "translate" "generate_random"
    "generate_trees" "morphologically_analyse" "put_string" "put_tree"
    "show_tree" "wrap_tree" "visualize_tree" "editing_session"
    "translation_session" "translation_quiz" "translation_list"
    "morphology_quiz" "morphology_list" "read_file" "write_file"
    "append_file" "transform_grammar" "convert_latex" "speak_aloud"
    "help" "quit" "system_command"))

(defun gf-complete-options (options flags &optional flags-extra-table
				    extra-completions)
  (let ((-options (mapcar (lambda (s) (concat "-" s)) options))
	(-flags= (mapcar (lambda (s) (concat "-" s "=")) flags)))
    ;; do-while
    (while (progn
	     (cond
	      ((pcomplete-match "\\`-\\(\\w+\\)=\\(.*\\)" 0)
	       (pcomplete-here
		(let ((opt (cdr (assoc (car (member
					     (pcomplete-match-string 1 0)
					     flags))
				       (append flags-extra-table
					       gf-flags-table)))))
		  (if (functionp opt)
		      (funcall opt)
		    opt))
		(pcomplete-match-string 2 0)))
	      (t (pcomplete-here
		  (append
		   (if (functionp extra-completions)
		       (funcall extra-completions)
		     extra-completions)
		   -options -flags=))))
	     (pcomplete-match "\\`-" 1)))))

(defun gf-collect-results (process command function)
  (let ((output-buffer " *gf-tmp*")
	results)
    (save-excursion
      (set-buffer (get-buffer-create output-buffer))
      (erase-buffer)
      (comint-redirect-send-command-to-process
       command output-buffer process nil t)
      ;; Wait for the process to complete
      (set-buffer (process-buffer process))
      (while (null comint-redirect-completed)
	(accept-process-output nil 1))
      ;; Collect the output
      (set-buffer output-buffer)
      (goto-char (point-min))
      ;; Skip past the command, if it was echoed
      (and (looking-at command) (forward-line))
      (funcall function))))

;; Command Completion ---------------------------------------------

;; i,  import: i File
;;       Reads a grammar from File and compiles it into a GF runtime grammar.
;;       Files "include"d in File are read recursively, nubbing repetitions.
;;       If a grammar with the same language name is already in the state,
;;       it is overwritten - but only if compilation succeeds.
;;       The grammar parser depends on the file name suffix:
;;         .gf    normal GF source
;;         .gfc   canonical GF
;;         .gfr   precompiled GF resource
;;         .gfcm  multilingual canonical GF
;;         .gfe   example-based grammar files (only with the -ex option)
;;         .ebnf  Extended BNF format
;;         .cf    Context-free (BNF) format
;;   options:
;;       -old          old: parse in GF<2.0 format (not necessary)
;;       -v            verbose: give lots of messages
;;       -s            silent: don't give error messages
;;       -src          source: ignore precompiled gfc and gfr files
;;       -retain       retain operations: read resource modules (needed in comm cc)
;;       -nocf         don't build context-free grammar (thus no parser)
;;       -nocheckcirc  don't eliminate circular rules from CF
;;       -cflexer      build an optimized parser with separate lexer trie
;;       -noemit       do not emit code (default with old grammar format)
;;       -o            do emit code (default with new grammar format)
;;       -ex           preprocess .gfe files if needed
;;   flags:
;;       -abs          set the name used for abstract syntax (with -old option)
;;       -cnc          set the name used for concrete syntax (with -old option)
;;       -res          set the name used for resource (with -old option)
;;       -path         use the (colon-separated) search path to find modules
;;       -optimize     select an optimization to override file-defined flags
;;       -conversion   select parsing method (values strict|nondet)
;;   examples:
;;       i English.gf                      -- ordinary import of Concrete
;;       i -retain german/ParadigmsGer.gf  -- import of Resource to test

(defun pcomplete/inf-gf-mode/i ()
  (gf-complete-options
   '("old" "v" "s" "src" "retain" "nocf" "nocheckcirc"
     "cflexer" "noemit" "o" "ex")
   '("abs" "cnc" "res" "path" "optimize" "conversion")
   '(("conversion" . ("strict" "nondet")))
   (lambda ()
     (pcomplete-dirs-or-entries
      (regexp-opt
       '(".gf" ".gfc" ".gfr" ".gfcm" ".gfe" ".ebnf" ".cf"
	 ".trc"))))))

;; * rl, remove_language: rl Language
;;       Takes away the language from the state.
(defun pcomplete/inf-gf-mode/rl ()
  (pcomplete-here (gf-complete-lang)))

;; e,  empty: e
;;       Takes away all languages and resets all global flags.
(defun pcomplete/inf-gf-mode/e ())

;; sf, set_flags: sf Flag*
;;       The values of the Flags are set for Language. If no language
;;       is specified, the flags are set globally.
;;   examples:
;;       sf -nocpu     -- stop showing CPU time
;;       sf -lang=Swe  -- make Swe the default concrete
(defun pcomplete/inf-gf-mode/sf ()
  (message "Usage: sf Flag*")
  (throw 'pcompleted nil))

;; s,  strip: s
;;       Prune the state by removing source and resource modules.
(defun pcomplete/inf-gf-mode/s ())

;; pg, print_grammar: pg
;;       Prints the actual grammar (overridden by the -lang=X flag).
;;       The -printer=X flag sets the format in which the grammar is
;;       written.
;;       N.B. since grammars are compiled when imported, this command
;;       generally does not show the grammar in the same format as the
;;       source. In particular, the -printer=latex is not supported.
;;       Use the command tg -printer=latex File to print the source
;;       grammar in LaTeX.
;;   options:
;;       -utf8  apply UTF8-encoding to the grammar
;;   flags:
;;       -printer
;;       -lang
;;   examples:
;;       pg -printer=cf  -- show the context-free skeleton
(defun pcomplete/inf-gf-mode/pg ()
  (gf-complete-options  '("utf8")
  			'("printer" "lang")))
  ;; (while (progn
  ;; 	   (cond
  ;; 	    ((pcomplete-match "\\`-printer=\\(.*\\)" 0)
  ;; 	     (pcomplete-here gf-flag-printer-options
  ;; 			     (pcomplete-match-string 1 0)))
  ;; 	    ((pcomplete-match "\\`-\\w+=" 0)
  ;; 	     (pcomplete-here))
  ;; 	    (t (pcomplete-here
  ;; 		(append  '("-utf8")
  ;; 			'("-printer=" "-lang=")))))
  ;; 	   (pcomplete-match "\\`-" 1)))

;; pm, print_multigrammar: pm
;;       Prints the current multilingual grammar in .gfcm form.
;;       (Automatically executes the strip command (s) before doing this.)
;;   options:
;;       -utf8  apply UTF8 encoding to the tokens in the grammar
;;       -utf8id apply UTF8 encoding to the identifiers in the grammar
;;       -graph print module dependency graph in 'dot' format
;;   examples:
;;       pm | wf Letter.gfcm  -- print the grammar into the file Letter.gfcm
;;       pm -printer=graph | wf D.dot  -- then do 'dot -Tps D.dot > D.ps'
(defun pcomplete/inf-gf-mode/pm ()
  (gf-complete-options '("utf8" "utf8id" "graph")
		       '("printer" "lang")
		       '(("printer" . ("graph")))))

;; vg, visualize_graph: vg
;;      Show the dependency graph of multilingual grammar via dot and gv.
(defun pcomplete/inf-gf-mode/vg ())

;; po, print_options: po
;;       Print what modules there are in the state. Also prints those
;;       flag values in the current state that differ from defaults.
(defun pcomplete/inf-gf-mode/po ())

;; pl, print_languages: pl
;;       Prints the names of currently available languages.
(defun pcomplete/inf-gf-mode/pl ())

;; pi, print_info: pi Ident
;;       Prints information on the identifier.
(defun pcomplete/inf-gf-mode/pi ()
  (message "Usage: pi Ident")
  (throw 'pcompleted nil))

;; eh, execute_history: eh File
;;       Executes commands in the file.
(defun pcomplete/inf-gf-mode/eh ()
  (pcomplete-here (pcomplete-entries)))

;; ph, print_history; ph
;;       Prints the commands issued during the GF session.
;;       The result is readable by the eh command.
;;   examples:
;;       ph | wf foo.hist"  -- save the history into a file
(defun pcomplete/inf-gf-mode/ph ())

;; -- linearization, parsing, translation, and computation

;; l,  linearize: l PattList? Tree
;;       Shows all linearization forms of Tree by the actual grammar
;;       (which is overridden by the -lang flag).
;;       The pattern list has the form [P, ... ,Q] where P,...,Q follow GF
;;       syntax for patterns. All those forms are generated that match with the
;;       pattern list. Too short lists are filled with variables in the end.
;;       Only the -table flag is available if a pattern list is specified.
;;       HINT: see GF language specification for the syntax of Pattern and Term.
;;       You can also copy and past parsing results.
;;   options:
;;       -table   show parameters
;;       -struct  bracketed form
;;       -record  record, i.e. explicit GF concrete syntax term
;;       -all     show all forms and variants
;;       -multi   linearize to all languages (the other options don't work)
;;   flags:
;;       -lang    linearize in this grammar
;;       -number  give this number of forms at most
;;       -unlexer filter output through unlexer
;;   examples:
;;       l -lang=Swe -table  -- show full inflection table in Swe
(defun pcomplete/inf-gf-mode/l ()
  (gf-complete-options '("table" "struct" "record" "all" "multi")
		       '("lang" "number" "unlexer"))
  (message "Usage: l [-option*] PattList? Tree")
  (throw 'pcompleted nil))

;; p,  parse: p String
;;       Shows all Trees returned for String by the actual
;;       grammar (overridden by the -lang flag), in the category S (overridden
;;       by the -cat flag).
;;   options for batch input:
;;       -lines   parse each line of input separately, ignoring empty lines
;;       -all     as -lines, but also parse empty lines
;;   options for selecting parsing method:
;;       (default)parse using an overgenerating CFG
;;       -cfg     parse using a much less overgenerating CFG
;;       -mcfg    parse using an even less overgenerating MCFG
;;       Note:    the first time parsing with -cfg or -mcfg might take a long time
;;   options that only work for the default parsing method:
;;       -n       non-strict: tolerates morphological errors
;;       -ign     ignore unknown words when parsing
;;       -raw     return context-free terms in raw form
;;       -v       verbose: give more information if parsing fails
;;   flags:
;;       -cat     parse in this category
;;       -lang    parse in this grammar
;;       -lexer   filter input through this lexer
;;       -parser  use this parsing strategy
;;       -number  return this many results at most
;;   examples:
;;       p -cat=S -mcfg "jag är gammal"   -- parse an S with the MCFG
;;       rf examples.txt | p -lines      -- parse each non-empty line of the file
(defun pcomplete/inf-gf-mode/p ()
  (gf-complete-options
   '("lines" "all" "cfg" "mcfg" "n" "ign" "raw" "v")
   '("cat" "lang" "lexer" "parser" "number"))
  (message "Usage: p [-option*] String")
  (throw 'pcompleted nil))

;; tt, test_tokenizer: tt String
;;       Show the token list sent to the parser when String is parsed.
;;       HINT: can be useful when debugging the parser.
;;   flags:
;;      -lexer    use this lexer
;;   examples:
;;      tt -lexer=codelit "2*(x + 3)"  -- a favourite lexer for program code
(defun pcomplete/inf-gf-mode/tt ()
  (gf-complete-options '() '("lexer"))
  (message "Usage: tt [-lexer] String")
  (throw 'pcompleted nil))

;; cc, compute_concrete: cc Term
;;       Compute a term by concrete syntax definitions. Uses the topmost
;;       resource module (the last in listing by command po) to resolve
;;       constant names.
;;       N.B. You need the flag -retain when importing the grammar, if you want
;;       the oper definitions to be retained after compilation; otherwise this
;;       command does not expand oper constants.
;;       N.B.' The resulting Term is not a term in the sense of abstract syntax,
;;       and hence not a valid input to a Tree-demanding command.
;;   flags:
;;      -res      use another module than the topmost one
;;   examples:
;;      cc -res=ParadigmsFin (nLukko "hyppy")   -- inflect "hyppy" with nLukko
(defun pcomplete/inf-gf-mode/cc ()
  (gf-complete-options '() '("res"))
  (message "Usage: cc [-res] Term")
  (throw 'pcompleted nil))

;; so, show_operations: so Type
;;       Show oper operations with the given value type. Uses the topmost
;;       resource module to resolve constant names.
;;       N.B. You need the flag -retain when importing the grammar, if you want
;;       the oper definitions to be retained after compilation; otherwise this
;;       command does not find any oper constants.
;;       N.B.' The value type may not be defined in a supermodule of the
;;       topmost resource. In that case, use appropriate qualified name.
;;   flags:
;;      -res      use another module than the topmost one
;;   examples:
;;      so -res=ParadigmsFin ResourceFin.N  -- show N-paradigms in ParadigmsFin
(defun pcomplete/inf-gf-mode/so ()
  (gf-complete-options '() '("res"))
  (message "Usage: so [-res] Type")
  (throw 'pcompleted nil))

;; t,  translate: t Lang Lang String
;;       Parses String in Lang1 and linearizes the resulting Trees in Lang2.
;;   flags:
;;       -cat
;;       -lexer
;;       -parser
;;   examples:
;;       t Eng Swe -cat=S "every number is even or odd"
(defun pcomplete/inf-gf-mode/t ()
  (gf-complete-options '() '("cat" "lexer" "parser"))
  (message "Usage: t [-options] Lang Lang String")
  (throw 'pcompleted nil))

;; gr, generate_random: gr Tree?
;;       Generates a random Tree of a given category. If a Tree
;;       argument is given, the command completes the Tree with values to
;;       the metavariables in the tree.
;;   flags:
;;       -cat     generate in this category
;;       -lang    use the abstract syntax of this grammar
;;       -number  generate this number of trees (not impl. with Tree argument)
;;       -depth   use this number of search steps at most
;;   examples:
;;       gr -cat=Query            -- generate in category Query
;;       gr (PredVP ? (NegVG ?))  -- generate a random tree of this form
;;       gr -cat=S -tr | l        -- gererate and linearize
(defun pcomplete/inf-gf-mode/gr ()
  (ding)
  (gf-complete-options '() '("cat" "lang" "number" "depth"))
  (message "Usage: gr [-options] Tree?")
  (throw 'pcompleted nil))

;; gt, generate_trees: gt Tree?
;;       Generates all trees up to a given depth. If the depth is large,
;;       a small -alts is recommended. If a Tree argument is given, the
;;       command completes the Tree with values to the metavariables in
;;       the tree.
;;   options:
;;       -metas   also return trees that include metavariables
;;   flags:
;;       -depth   generate to this depth (default 3)
;;       -alts    take this number of alternatives at each branch (default unlimited)
;;       -cat     generate in this category
;;       -lang    use the abstract syntax of this grammar
;;       -number  generate (at most) this number of trees
;;   examples:
;;       gt -depth=10 -cat=NP     -- generate all NP's to depth 10
;;       gt (PredVP ? (NegVG ?))  -- generate all trees of this form
;;       gt -cat=S -tr | l        -- gererate and linearize
(defun pcomplete/inf-gf-mode/gt ()
  (gf-complete-options '("metas")
		       '("depth" "alts" "cat" "lang" "number")))

;; ma, morphologically_analyse: ma String
;;       Runs morphological analysis on each word in String and displays
;;       the results line by line.
;;   options:
;;       -short   show analyses in bracketed words, instead of separate lines
;;   flags:
;;       -lang
;;   examples:
;;       wf Bible.txt | ma -short | wf Bible.tagged  -- analyse the Bible
(defun pcomplete/inf-gf-mode/ma ()
  (gf-complete-options '("short") '("lang")))

;; -- elementary generation of Strings and Trees

;; ps, put_string: ps String
;;       Returns its argument String, like Unix echo.
;;       HINT. The strength of ps comes from the possibility to receive the
;;       argument from a pipeline, and altering it by the -filter flag.
;;   flags:
;;       -filter  filter the result through this string processor
;;       -length  cut the string after this number of characters
;;   examples:
;;       gr -cat=Letter | l | ps -filter=text -- random letter as text
(defun pcomplete/inf-gf-mode/ps ()
  (gf-complete-options '() '("filter" "length")))

;; pt, put_tree: pt Tree
;;       Returns its argument Tree, like a specialized Unix echo.
;;       HINT. The strength of pt comes from the possibility to receive
;;       the argument from a pipeline, and altering it by the -transform flag.
;;   flags:
;;       -transform   transform the result by this term processor
;;       -number      generate this number of terms at most
;;   examples:
;;       p "zero is even" | pt -transform=solve  -- solve ?'s in parse result
(defun pcomplete/inf-gf-mode/pt ()
  (gf-complete-options '() '("transform" "number")))

;; * st, show_tree: st Tree
;;       Prints the tree as a string. Unlike pt, this command cannot be
;;       used in a pipe to produce a tree, since its output is a string.
;;   flags:
;;       -printer     show the tree in a special format (-printer=xml supported)
(defun pcomplete/inf-gf-mode/st ())

;; wt, wrap_tree: wt Fun
;;       Wraps the tree as the sole argument of Fun.
;;   flags:
;;       -c           compute the resulting new tree to normal form
(defun pcomplete/inf-gf-mode/wt ()
  (gf-complete-options '("c") '()))

;; vt, visualize_tree: vt Tree
;;       Shows the abstract syntax tree via dot and gv (via temporary files
;;       grphtmp.dot, grphtmp.ps).
;;   flags:
;;       -c           show categories only (no functions)
;;       -f           show functions only (no categories)
;;       -g           show as graph (sharing uses of the same function)
;;       -o           just generate the .dot file
;;   examples:
;;     p "hello world" | vt -o | wf my.dot ;; ! open -a GraphViz my.dot
;;     -- This writes the parse tree into my.dot and opens the .dot file
;;     -- with another application without generating .ps.
(defun pcomplete/inf-gf-mode/vt ()
  (gf-complete-options '("c" "f" "g" "o") '()))

;; -- subshells

;; es, editing_session: es
;;       Opens an interactive editing session.
;;       N.B. Exit from a Fudget session is to the Unix shell, not to GF.
;;   options:
;;       -f Fudget GUI (necessary for Unicode; only available in X Window System)

;; ts, translation_session: ts
;;       Translates input lines from any of the actual languages to all other ones.
;;       To exit, type a full stop (.) alone on a line.
;;       N.B. Exit from a Fudget session is to the Unix shell, not to GF.
;;       HINT: Set -parser and -lexer locally in each grammar.
;;   options:
;;       -f    Fudget GUI (necessary for Unicode; only available in X Windows)
;;       -lang prepend translation results with language names
;;   flags:
;;       -cat    the parser category
;;   examples:
;;       ts -cat=Numeral -lang  -- translate numerals, show language names
(defun pcomplete/inf-gf-mode/ts ()
  (gf-complete-options '("f" "lang") '("cat")))

;; tq, translation_quiz: tq Lang Lang
;;       Random-generates translation exercises from Lang1 to Lang2,
;;       keeping score of success.
;;       To interrupt, type a full stop (.) alone on a line.
;;       HINT: Set -parser and -lexer locally in each grammar.
;;   flags:
;;       -cat
;;   examples:
;;       tq -cat=NP TestResourceEng TestResourceSwe  -- quiz for NPs
(defun pcomplete/inf-gf-mode/tq ()
  (pcomplete-here (gf-complete-lang))
  (pcomplete-here (gf-complete-lang)))

;; tl, translation_list: tl Lang Lang
;;       Random-generates a list of ten translation exercises from Lang1
;;       to Lang2. The number can be changed by a flag.
;;       HINT: use wf to save the exercises in a file.
;;   flags:
;;       -cat
;;       -number
;;   examples:
;;       tl -cat=NP TestResourceEng TestResourceSwe  -- quiz list for NPs
(defun pcomplete/inf-gf-mode/tl ()
  (pcomplete-here (gf-complete-lang))
  (pcomplete-here (gf-complete-lang)))

;; mq, morphology_quiz: mq
;;       Random-generates morphological exercises,
;;       keeping score of success.
;;       To interrupt, type a full stop (.) alone on a line.
;;       HINT: use printname judgements in your grammar to
;;       produce nice expressions for desired forms.
;;   flags:
;;       -cat
;;       -lang
;;   examples:
;;       mq -cat=N -lang=TestResourceSwe  -- quiz for Swedish nouns

;; ml, morphology_list: ml
;;       Random-generates a list of ten morphological exercises,
;;       keeping score of success. The number can be changed with a flag.
;;       HINT: use wf to save the exercises in a file.
;;   flags:
;;       -cat
;;       -lang
;;       -number
;;   examples:
;;       ml -cat=N -lang=TestResourceSwe  -- quiz list for Swedish nouns
(defun pcomplete/inf-gf-mode/ml ()
  (gf-complete-options '() '("cat" "lang" "number")))

;; -- IO related commands

;; rf, read_file: rf File
;;       Returns the contents of File as a String; error if File does not exist.
(defun pcomplete/inf-gf-mode/rf ()
  (pcomplete-here (pcomplete-entries)))

;; wf, write_file: wf File String
;;       Writes String into File; File is created if it does not exist.
;;       N.B. the command overwrites File without a warning.

;; af, append_file: af File
;;       Writes String into the end of File; File is created if it does not exist.

;; * tg, transform_grammar: tg File
;;       Reads File, parses as a grammar,
;;       but instead of compiling further, prints it.
;;       The environment is not changed. When parsing the grammar, the same file
;;       name suffixes are supported as in the i command.
;;       HINT: use this command to print the grammar in
;;       another format (the -printer flag); pipe it to wf to save this format.
;;   flags:
;;       -printer  (only -printer=latex supported currently)

;; * cl, convert_latex: cl File
;;       Reads File, which is expected to be in LaTeX form.
;;       Three environments are treated in special ways:
;;         \begGF    - \end{verbatim}, which contains GF judgements,
;;         \begTGF   - \end{verbatim}, which contains a GF expression (displayed)
;;         \begInTGF - \end{verbatim}, which contains a GF expressions (inlined).
;;       Moreover, certain macros should be included in the file; you can
;;       get those macros by applying 'tg -printer=latex foo.gf' to any grammar
;;       foo.gf. Notice that the same File can be imported as a GF grammar,
;;       consisting of all the judgements in \begGF environments.
;;       HINT: pipe with 'wf Foo.tex' to generate a new Latex file.

;; sa, speak_aloud: sa String
;;       Uses the Flite speech generator to produce speech for String.
;;       Works for American English spelling.
;;   examples:
;;     h | sa              -- listen to the list of commands
;;     gr -cat=S | l | sa  -- generate a random sentence and speak it aloud

;; h, help: h Command?
;;       Displays the paragraph concerning the command from this help file.
;;       Without the argument, shows the first lines of all paragraphs.
;;   options
;;        -all  show the whole help file
;;   examples:
;;        h print_grammar  -- show all information on the pg command

;; q, quit: q
;;       Exits GF.
;;       HINT: you can use 'ph | wf history' to save your session.

;; !, system_command: ! String
;;       Issues a system command. No value is returned to GF.
;;    example:
;;       ! ls
(defun pcomplete/inf-gf-mode/! ()
  ;;(pcomplete-here (eshell-complete-commands-list))
  )

;; -- Flags. The availability of flags is defined separately for each command.

;; -cat, category in which parsing is performed.
;;       The default is S.

;; -depth, the search depth in e.g. random generation.
;;       The default depends on application.

;; -filter, operation performed on a string. The default is identity.
;;     -filter=identity     no change
;;     -filter=erase        erase the text
;;     -filter=take100      show the first 100 characters
;;     -filter=length       show the length of the string
;;     -filter=text         format as text (punctuation, capitalization)
;;     -filter=code         format as code (spacing, indentation)
(defvar gf-flag-filter-options
  '("identity" "erase" "take100" "length" "text" "code"))

;; -lang, grammar used when executing a grammar-dependent command.
;;        The default is the last-imported grammar.

(defvar gf-lang-cache 'empty)
(defun gf-clear-lang-cache () (setq gf-lang-cache 'empty))

(defvar gf-flag-lang-options 'gf-complete-lang)
(defun gf-complete-lang ()
  (if (listp gf-lang-cache)
      gf-lang-cache
    (setq gf-lang-cache
	  (gf-collect-results
	   gf-process "pl"
	   (lambda ()
	     ;; we're at point-min
	     (let (result)
	       (while (re-search-forward "\\S-+" (point-at-eol) t)
		 (push (match-string 0) result))
	       result))))))

;; -language, voice used by Festival as its --language flag in the sa command.
;;        The default is system-dependent.

;; -length, the maximum number of characters shown of a string.
;;        The default is unlimited.

;; -lexer, tokenization transforming a string into lexical units for a parser.
;;        The default is words.
;;     -lexer=words         tokens are separated by spaces or newlines
;;     -lexer=literals      like words, but GF integer and string literals recognized
;;     -lexer=vars          like words, but "x","x_...","$...$" as vars, "?..." as meta
;;     -lexer=chars         each character is a token
;;     -lexer=code          use Haskell's lex
;;     -lexer=codevars      like code, but treat unknown words as variables, ?? as meta
;;     -lexer=text          with conventions on punctuation and capital letters
;;     -lexer=codelit       like code, but treat unknown words as string literals
;;     -lexer=textlit       like text, but treat unknown words as string literals
;;     -lexer=codeC         use a C-like lexer
(defvar gf-flag-lexer-options
  '("words" "literals" "vars" "chars" "code" "codevars"
    "text" "codelit" "textlit" "codeC"))

;; -number, the maximum number of generated items in a list.
;;        The default is unlimited.

;; -optimize, optimization on generated code.
;;        The default is share for concrete, none for resource modules.
;;        Each of the flags can have the suffix _subs, which performs
;;        common subexpression elimination after the main optimization.
;;        Thus, -optimize=all_subs is the most aggressive one.

;;     -optimize=share        share common branches in tables
;;     -optimize=parametrize  first try parametrize then do share with the rest
;;     -optimize=values       represent tables as courses-of-values
;;     -optimize=all          first try parametrize then do values with the rest
;;     -optimize=none         no optimization
(defvar gf-flag-optimize-options
  '("share" "parametrize" "values" "all" "none"))

;; -parser, parsing strategy. The default is chart. If -cfg or -mcfg are selected, only bottomup and topdown are recognized.
;;     -parser=chart          bottom-up chart parsing
;;     -parser=bottomup       a more up to date bottom-up strategy
;;     -parser=topdown        top-down strategy
;;     -parser=old            an old bottom-up chart parser
(defvar gf-flag-parser-options
  '("chart" "bottomup" "topdown" "old"))

;; -printer, format in which the grammar is printed. The default is gfc.
;;     -printer=gfc            GFC grammar
;;     -printer=gf             GF grammar
;;     -printer=old            old GF grammar
;;     -printer=cf             context-free grammar, with profiles
;;     -printer=bnf            context-free grammar, without profiles
;;     -printer=lbnf           labelled context-free grammar for BNF Converter
;;     -printer=plbnf          grammar for BNF Converter, with precedence levels
;;    *-printer=happy          source file for Happy parser generator (use lbnf!);;     -printer=srg            speech recognition grammar
;;     -printer=haskell        abstract syntax in Haskell, with transl to/from GF
;;     -printer=morpho         full-form lexicon, long format
;;    *-printer=latex          LaTeX file (for the tg command)
;;     -printer=fullform       full-form lexicon, short format
;;    *-printer=xml            XML: DTD for the pg command, object for st
;;     -printer=old            old GF: file readable by GF 1.2
;;     -printer=stat           show some statistics of generated GFC
;;     -printer=gsl            Nuance GSL speech recognition grammar
;;     -printer=jsgf           Java Speech Grammar Format
;;     -printer=slf            a finite automaton in the HTK SLF format
;;     -printer=slf_graphviz   the same automaton as in SLF, but in Graphviz format
;;     -printer=fa_graphviz    a finite automaton with labelled edges
;;     -printer=regular        a regular grammar in a simple BNF
;;     -printer=unpar          a gfc grammar with parameters eliminated
(defvar gf-flag-printer-options
  '("gfc" "gf" "cf" "old" "srg" "gsl" "jsgf" "slf" "slf_graphviz"
    "fa_graphviz" "regular" "plbnf" "lbnf" "bnf" "haskell" "morpho"
    "fullform" "opts" "words" "printnames" "stat" "unpar" "subs"
    "mcfg" "cfg" "pinfo" "abstract" "gfc-haskell" "mcfg-haskell"
    "cfg-haskell" "gfc-prolog" "mcfg-prolog" "cfg-prolog" "abs-skvatt"
    "cfg-skvatt" "simple" "mcfg-erasing" "mcfg-old" "cfg-old"
    ;;"happy" "latex" "xml"
    ))


;; -startcat, like -cat, but used in grammars (to avoid clash with keyword cat)

;; -transform, transformation performed on a syntax tree. The default is identity.
;;     -transform=identity  no change
;;     -transform=compute   compute by using definitions in the grammar
;;     -transform=typecheck return the term only if it is type-correct
;;     -transform=solve     solve metavariables as derived refinements
;;     -transform=context   solve metavariables by unique refinements as variables
;;     -transform=delete    replace the term by metavariable
(defvar gf-flag-transform-options
  '("identity" "compute" "typecheck" "solve" "context" "delete"))

;; -unlexer, untokenization transforming linearization output into a string.
;;        The default is unwords.
;;     -unlexer=unwords     space-separated token list (like unwords)
;;     -unlexer=text        format as text: punctuation, capitals, paragraph <p>
;;     -unlexer=code        format as code (spacing, indentation)
;;     -unlexer=textlit     like text, but remove string literal quotes
;;     -unlexer=codelit     like code, but remove string literal quotes
;;     -unlexer=concat      remove all spaces
;;     -unlexer=bind        like identity, but bind at "&+"
(defvar gf-flag-unlexer-options
  '("unwords" "text" "code" "textlit" "codelit" "concat" "bind"))

;; -- *: Commands and options marked with * are not yet implemented.

(defvar gf-flags-table
  `(("filter"    . ,gf-flag-filter-options)
    ("lang"      . ,gf-flag-lang-options)
    ("lexer"	 . ,gf-flag-lexer-options)
    ("optimize"  . ,gf-flag-optimize-options)
    ("parser"    . ,gf-flag-parser-options)
    ("printer"   . ,gf-flag-printer-options)
    ("transform" . ,gf-flag-transform-options)
    ("unlexer"   . ,gf-flag-unlexer-options)))

;;; gf.el ends here
