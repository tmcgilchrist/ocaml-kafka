TARGETS = okafka.cma okafka.cmxa okafka.cmxs okafka.a libocamlkafka.a dllocamlkafka.so kafka.cmi kafka.cma kafka.cmx kafkaConsumer.cmi kafkaProducer.cmi
LIB = $(addprefix _build/, $(TARGETS))

all:
	ocamlbuild $(TARGETS)

tools: kafkatail.native create_topic.native

install:
	ocamlfind install okafka META $(LIB)

uninstall:
	ocamlfind remove okafka

tests: tests.native
	_build/tests.native

tests.native: all tests.ml
	ocamlbuild -libs okafka,unix tests.native

kafkatail.native: kafkatail.ml
	ocamlbuild -libs okafka kafkatail.native

create_topic.native: create_topic.ml
	ocamlbuild -libs okafka create_topic.native

clean:
	ocamlbuild -clean

.PHONY: all clean tests install
