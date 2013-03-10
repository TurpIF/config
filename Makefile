# Generic Makefile
# Author : Turpin Pierre
# Date : 22/11/2012

CXX=g++

SRCDIR=./src
INCDIR=./include
OBJDIR=./build/obj
DEPDIR=./build/dep
BINDIR=./bin

WRNFLAGS=-pedantic -Wall -Wextra -Wold-style-cast -Woverloaded-virtual -Wfloat-equal -Wwrite-strings -Wpointer-arith -Wcast-align -Wconversion -Wredundant-decls -Winit-self -Wswitch-default -Wswitch-enum -Wundef -Winline -W -Wunused-parameter -ansi -Weffc++ -Wshadow

CXXFLAGS.release=$(WRNFLAGS) -I$(INCDIR) -std=c++0x
LDFLAGS.release=
LDLIBS.release=

CXXFLAGS.debug=$(WRNFLAGS) -I$(INCDIR) -std=c++0x
LDFLAGS.debug=
LDLIBS.debug=

PROD=release

CXXFLAGS=$(CXXFLAGS.$(PROD))
LDFLAGS=$(LDFLAGS.$(PROD))
LDLIBS=$(LDLIBS.$(PROD))
OUTPUT_OPTION=-MMD

REC_SRCDIR = $(shell find $(SRCDIR) -type d)
SOURCES = $(foreach dir,$(REC_SRCDIR), $(wildcard $(dir)/*.cpp))
OBJECTS = $(addsuffix .o, $(basename $(subst $(SRCDIR), $(OBJDIR), $(SOURCES))))
DEPENDS = $(addsuffix .d, $(basename $(subst $(SRCDIR), $(DEPDIR), $(SOURCES))))

ECHO=@echo
RM=rm -f
MKDIR=mkdir -p

RUN=run
CLEAN=clean
MRPROPER=mrproper
TARGET=$(BINDIR)/App

all:$(TARGET)

.PHONY:all $(CLEAN) $(RUN) $(MRPROPER)

$(RUN):$(TARGET)
	./$(TARGET)

$(TARGET):$(OBJECTS)
	$(MKDIR) $(@D)
	$(LINK.cpp) $^ $(LDLIBS) -o $@

$(OBJDIR)/%.o:$(SRCDIR)/%.cpp
	$(MKDIR) $(@D)
	$(MKDIR) $(dir $(DEPDIR)/$*.d)
	$(COMPILE.cpp) $< $(OUTPUT_OPTION) -MF $(DEPDIR)/$*.d -o $@

$(CLEAN):
	$(RM) $(OBJECTS) $(DEPENDS)

$(MRPROPER):$(CLEAN)
	$(RM) $(TARGET)

-include $(DEPENDS)

