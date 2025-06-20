bansi-to-html
==============

Convert ANSI to HTML purely in Bash.

Live Example
------------

I wrote this tool specifically for my websites related to my YSAP series - see
it in action here:

- [style.ysap.sh](https://style.ysap.sh)

Getting Started
---------------

Simply pipe data into `bansi-to-html` and HTML will be written to stdout.  Note
that the HTML output in this example has been formatted and indented just for
this example:

    $ echo -ne 'Regular Text\e[1mBold Text\e[0mRegular Again' | ./bansi-to-html

``` html
<!-- generated by bansi-to-html | https://github.com/bahamas10/bansi-to-html -->
<span class="ansi-color-fg-default ansi-color-bg-default">
    Regular Text
</span>
<span class="ansi-bold ansi-color-fg-default ansi-color-bg-default">
    Bold Text
</span>
<span class="ansi-color-fg-default ansi-color-bg-default">
    Regular Again
</span>
```

Examples
--------

Simple example of red text to the terminal:

    echo -e '\e[31mhello world!\e[0m' | bansi-to-html

Render `ls` with color output to `ls.html`:

    ls --color=always | bansi-to-html > ls.html

Render my website as HTML with debug output to the terminal:

    curl ysap.sh | bansi-to-html -d

Render data already in a file, ignoring invalid sequences instead of exiting
when encountering them, using a custom CSS class prefix name:

    ls --color=always > foo.txt
    bansi-to-html -w -p my-css-prefix- foo.txt

Notes
-----

- Implemented in pure bash - absolutely 0 external utilities are used.
- Will error whenever *any* unaccepted, unexpected, or invalid ANSI sequences
  are encountered (overridden with `-w` to turn errors into warnings).
- Reads input from stdin and writes output stdout by default (input file can be
  passed as the final operand).
- No inline styling - this tool outputs CSS class names in span elements (never
  nested) and ships with a CSS file that applies the coloring/style.

Usage
-----

```
$ bansi-to-html -h
Usage: bansi-to-html [-hdwH] [-p prefix] [file]

Convert ANSI to HTML purely in Bash.

This program will read a file passed as the first argument or from stdin if no
argument is given.  ANSI escape sequences for color output will be processed and
turned into their relevant CSS classes in <span> elements.  No extraneous
newlines or processing will be done on the input - so the output should be safe
to put in your own <pre><code>...</code></pre> block and have it appear exactly
as it should.

Any unexpected, unsupported, or broken escape sequences will be considered an
error and will cause this program to halt immediately with an error exit status.
The '-w' flag can be given to tell this program to ignore those warnings and
just discard the unknown sequences (warnings will be emitted to stderr).

Source code: https://github.com/bahamas10/bansi-to-html

Options
  -d             Print debug message to stderr.
  -h             Print this message and exit.
  -H             Don't emit HTML program header comment.
  -p <prefix>    CSS class prefix to use, defaults to "ansi-" - used directly in
                 the HTML so make sure it is HTML safe.
  -w             Ignore unsupported sequences, just emit a warning to stderr and
                 keep running.
  -v             Print the version number and exit.
```

Contributing Guidelines
-----------------------

- New code must follow my [Bash Style Guide](https://style.ysap.sh).
- Hard tabs, no lines over 80 columns (tabs == 8 spaces).

New code must pass the syntax check and integration tests:

    make check
    make test

License
-------

MIT License
