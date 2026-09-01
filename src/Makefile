#
# Makefile for tetra-dynamo
#
#   Akira Kageyama (kage@port.kobe-u.ac.jp)
#

.SUFFIXES:

eflist   := $(shell ls *.ef)                # e.g., example.ef
filebase := $(basename $(notdir $(eflist))) # => example
f90list  := $(addsuffix .F90, $(filebase))  # => example.F90
modlist  := $(addsuffix .mod, $(filebase))  # => example.mod
objlist  := $(addsuffix .o, $(filebase))    # => example.o

# mpi_nprocs := $(shell ../bin/grep_process_num_from_src.sh constants.ef)

.SECONDARY: $(f90list)  # to avoid deleting F90 files.
       # .SECONDARY: obj/%.F90 does not work (GNU Make 3.81).

.PHONY: clean line list


%.F90: %.ef
	$(EFPP) $< > $@

%.o: %.F90
	$(FC) $(FFLAGS) -o $@ -c $< $(FLIB)

$(info ** Setting variables for Mac)
EFPP = ../bin/efpp.py
FC = gfortran 
FFLAGS = 
     # FFLAGS += -fcheck=all <== This causes mysterious error on my Mac.
#FFLAGS += -Wall
#FFLAGS += -fbounds-check
#FFLAGS += -fcheck-array-temporaries
#FFLAGS += -ffpe-trap=invalid,zero,overflow

#-----------<Print out macros>--------------
ifeq ($(MAKE_RESTARTS),)
  $(info ** THIS_HOST    = $(THIS_HOST))
  $(info ** EFPP         = $(EFPP))
endif
#-----------</Print out macros>--------------

# default target


runme: $(objlist)
	$(FC) $(FFLAGS) -o runme $(objlist) $(FLIB)

# 
# run: runme 
# 	./runme namelistファイルを引数として渡す
#
# 	詳しくは以下を見よ。
# 	_tools_generate_contour_level_vs_length_by_crofton

-include depend_list.mk

depend_list.mk: *.ef
	../bin/gendep.sh > $@ 



clean:
	rm -rf depend_list.mk
	rm -rf *.o *.lst *.F90 *.mod *.L
	rm -rf runme
