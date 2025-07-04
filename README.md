# Htmlize — Convert buffer text and decorations to HTML

[![NonGNU ELPA](https://elpa.nongnu.org/nongnu/htmlize.svg)](https://elpa.nongnu.org/nongnu/htmlize.html)
[![MELPA Stable](https://stable.melpa.org/packages/htmlize-badge.svg)](https://stable.melpa.org/#/htmlize)
[![MELPA](https://melpa.org/packages/htmlize-badge.svg)](https://melpa.org/#/htmlize)

This package converts the buffer text and the associated
decorations to HTML.

To use it, just switch to the buffer you want HTML-ized and type
<kbd>M-x htmlize-buffer</kbd>.  You will be switched to a new buffer
that contains the resulting HTML code.  You can edit and inspect this
buffer, or you can just save it with <kbd>C-x C-w</kbd>.  <kbd>M-x
htmlize-file</kbd> will find a file, fontify it, and save the HTML
version in `FILE.html`, without any additional intervention.  <kbd>M-x
htmlize-many-files</kbd> allows you to htmlize any number of files in
the same manner.  <kbd>M-x htmlize-many-files-dired</kbd> does the
same for files marked in a dired buffer.

Htmlize supports three types of HTML output, selected by setting
`htmlize-output-type`: `css`, `inline-css` (optimized for code
snippets), and `font` (simpler output, doesn't rely on CSS).  See
[`htmlize.el.html`][1] for an example of generated HTML.

You can also use htmlize from your Emacs Lisp code.  When called
non-interactively, `htmlize-buffer` and `htmlize-region` will
return the resulting HTML buffer, but will not change current
buffer or move the point.  Htmlize will do its best to work on
non-windowing Emacs sessions but the result will be limited to
colors supported by the terminal.

[1]: http://htmlpreview.github.io/?https://github.com/emacsorphanage/htmlize/blob/master/htmlize.el.html
