EMACS =
PYTHON =

ifndef EMACS
EMACS = guix shell -C -f emacs.scm -- emacs -Q
endif

ifndef PYTHON
PYTHON = guix shell python -- python3
endif

all: publish

publish: publish.el
	${EMACS} --script publish.el

server:
	${PYTHON} -m http.server --directory=public/

clean:
	@rm -rvf *.elc
	@rm -rvf public
	@rm -rvf ~/.org-timestamps/*
