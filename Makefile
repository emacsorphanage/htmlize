-include .config.mk

PKG = htmlize

ELS   = $(PKG).el
ELCS  = $(ELS:.el=.elc)
HTML  = $(ELS:.el=.el.html)

DEPS  =

EMACS      ?= emacs
EMACS_ARGS ?=

LOAD_PATH  ?= $(addprefix -L ../,$(DEPS))
LOAD_PATH  += -L .

all: lisp

help:
	$(info make all          - generate byte-code and autoloads)
	$(info make lisp         - generate byte-code and autoloads)
	$(info make redo         - re-generate byte-code and autoloads)
	$(info make htmlize      - htmlize htmlize.el)
	$(info make clean        - remove generated files)
	@printf "\n"

redo: clean lisp

lisp: $(ELCS) loaddefs check-declare

loaddefs: $(PKG)-autoloads.el

%.elc: %.el
	@printf "Compiling $<\n"
	@$(EMACS) -Q --batch $(EMACS_ARGS) $(LOAD_PATH) -f batch-byte-compile $<

check-declare:
	@printf " Checking function declarations\n"
	@$(EMACS) -Q --batch $(EMACS_ARGS) $(LOAD_PATH) \
	--eval "(check-declare-directory default-directory)"

%.el.html: %.el
	@$(EMACS) -Q $(EMACS_ARGS) $(LOAD_PATH) \
	-l htmlize --eval "(progn (htmlize-file \"$<\") (kill-emacs))"

htmlize: $(HTML)

CLEAN  = $(ELCS) $(PKG)-autoloads.el

clean:
	@printf " Cleaning...\n"
	@rm -rf $(CLEAN)

$(PKG)-autoloads.el: $(ELS)
	@printf " Creating $@\n"
	@$(EMACS) -Q --batch -l autoload -l cl-lib --eval "\
(let ((file (expand-file-name \"$@\"))\
      (autoload-timestamps nil) \
      (backup-inhibited t)\
      (version-control 'never)\
      (coding-system-for-write 'utf-8-emacs-unix))\
  (write-region (autoload-rubric file \"package\" nil) nil file nil 'silent)\
  (cl-letf (((symbol-function 'progress-reporter-do-update) (lambda (&rest _)))\
            ((symbol-function 'progress-reporter-done) (lambda (_))))\
    (let ((generated-autoload-file file))\
      (update-directory-autoloads default-directory))))" \
	2>&1 | sed "/^Package autoload is deprecated$$/d"
