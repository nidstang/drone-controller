GAMBIT_PATH = $(HOME)/local/Gambit-C

gamsock.o1: gamsock.scm gamsock-headers.scm gamsock-constants.scm
	gsc -keep-c -o $@ gamsock.scm 

gamsock-headers.scm: config-gamsock.scm
	gsi config-gamsock.scm

gamsock-constants.scm: config-gamsock.scm
	gsi config-gamsock.scm
