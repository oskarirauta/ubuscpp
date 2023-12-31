all: world

CXX?=g++
CXXFLAGS?=--std=c++17 -Wall -fPIC
LDFLAGS?=-L/lib -L/usr/lib

INCLUDES+= -I./examples/include -I./jsoncpp/include

UBUSCPP_DIR:=.
include Makefile.inc

world: srv cli

objs/ubus_funcs.o: examples/ubus_funcs.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c -o $@ $<;

objs/cli.o: examples/cli.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c -o $@ $<;

objs/srv.o: examples/srv.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c -o $@ $<;

srv: $(UBUS_SRV_OBJS) objs/ubus_funcs.o objs/srv.o
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -L. $(UBUS_LIBS) $^ -o $@;

cli: $(UBUS_CLI_OBJS) objs/cli.o
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -L. $(UBUS_LIBS) $^ -o $@;

.PHONY: clean
clean:
	rm -f objs/*.o srv cli
