#
# Makefile for tetra-dynamo
#
#   Akira Kageyama (kage@port.kobe-u.ac.jp)
#     2022.07.08: Copied from yyz-relax code.
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

EFPP = ../bin/efpp.py
EFPP = $(HOME)/VCS/GitHub/efpp/efpp.py

VIS3DLIB_NAME = vismo  # <= libvismo.a 
VIS3DLIB_DIR  = ../vismo3.62series/lib
VIS3DLIB_DIR  = $(HOME)/VCS/GitHub/vismo-mdm/lib
VIS3DLIB_DIR  = ../vismo-mdm/lib
VIS2DLIB_NAME = slisvg  # <= libslisvg.a 
VIS2DLIB_DIR  = $(HOME)/VCS/GitHub/slisvg/lib

FLIB := -I$(VIS2DLIB_DIR)  -I$(VIS3DLIB_DIR) 
FLIB += -L$(VIS2DLIB_DIR)  -L$(VIS3DLIB_DIR) 
FLIB += -l$(VIS2DLIB_NAME) -l$(VIS3DLIB_NAME)


THIS_HOST := $(shell hostname | cut -c1-3)

ifeq ($(THIS_HOST),csi)  # csi-enshu
  $(info ** Setting variables for csi)
  #-- The following two options are useless.
  # MPIEXEC_OPTION = --mca mtl ^ofi
  # MPIEXEC_OPTION = -mca pml ucx -mca btl '^uct,ofi' -mca mtl '^ofi'
  FC = mpifort
  FFLAGS := -O3
  FFLAGS += -fopenmp
# FFLAGS += -fpp
# FFLAGS += -Wall
# FFLAGS += -fcheck=all
# FFLAGS += -report-all
else ifeq ($(THIS_HOST),pi)  # Kobe
  $(info ** Setting variables for pi-computer)
  FC = mpifrtpx
  FFLAGS = -X03 -Free -Kopenmp -NRtrap
else ifeq ($(THIS_HOST),mac)  # Mac
  $(info ** Setting variables for Mac)
  EFPP = ../bin/efpp.py
  FC = mpifort 
  FFLAGS = -fopenmp -O4
  FFLAGS = -fopenmp

  # FFLAGS = 
  # FFLAGS = -fopenmp
  # FFLAGS += -fcheck=all
  # FFLAGS += -Wall
  # FFLAGS += -fbounds-check
  # FFLAGS += -fcheck-array-temporaries
  # FFLAGS += -ffpe-trap=invalid,zero,overflow
else ifeq ($(THIS_HOST),ofp)  # Oakforest PACS
  $(info ** Setting variables for Oakforest)
  EFPP = ../bin/efpp.py
  FC = mpiifort
  FFLAGS := -O3
  FFLAGS += -qopenmp
  FFLAGS += -axMIC-AVX512
  FFLAGS += -fpe0
  FFLAGS += -ftrapuv
  FFLAGS += -align array64byte
  FFLAGS += -qopt-threads-per-core=1
  #FFLAGS += -CB  # check bounds
  #FFLAGS += -check all
  #FFLAGS += -warn all
  #FFLAGS += -traceback
else ifeq ($(THIS_HOST),fes)  # NIFS
  $(info ** Setting variables for Plasma Simulator)
  EFPP = ../bin/efpp.py
  FC = mpinfort
  FFLAGS += -fopenmp
  # FFLAGS += -X03 -Free -NRtrap -Qt -Koptmsg=2
  # FFLAGS += -Haefosux
  # FFLAGS += -g
  # FFLAGS += -Nquickdbg=argchk
  # FFLAGS += -Nquickdbg=subchk
else ifeq ($(HOME),$(ES3_HOME)) # JAMSTEC
  EFPP = ../../../bin/efpp.py2
  #EFPP = ../bin/efpp.py2
  FC = sxmpif03 # at cg-mhd, must sxmpif03, not sxmpif90
  #FC = sxmpif90 # at yyz-relax, must sxmpif90, not sxmpif03
  FFLAGS := -P openmp
  FFLAGS += -ftrace
  FFLAGS += -R transform fmtlist
  FFLAGS += -pvctl fullmsg
   #FFLAGS += -R2
   #FFLAGS += -Wf"-pvctl fullmsg"
   #FFLAGS += -eR
else 
  $(error "hostnameによる分岐に失敗")
endif

#-----------<Print out macros>--------------
ifeq ($(MAKE_RESTARTS),)
  $(info ** THIS_HOST    = $(THIS_HOST))
  $(info ** EFPP         = $(EFPP))
  $(info ** VIS3DLIB_DIR = $(VIS3DLIB_DIR))
  $(info ** VIS2DLIB_DIR = $(VIS2DLIB_DIR))
  $(info ** mpi_nprocs   = $(mpi_nprocs))
endif
#-----------</Print out macros>--------------

# default target


tetra_dynamo: $(objlist)
	$(FC) $(FFLAGS) -o tetra_dynamo $(objlist) $(FLIB)

#run: tetra_dynamo 
#	OMP_NUM_THREADS=2 mpiexec $(MPIEXEC_OPTION) -n $(mpi_nprocs) ./tetra_dynamo sample.namelist

run: tetra_dynamo 
	mpiexec $(MPIEXEC_OPTION) -n $(mpi_nprocs) ./tetra_dynamo sample.namelist

rerun: 
	rm tetra_dynamo
	$(FC) $(FFLAGS) -o tetra_dynamo $(objlist) $(FLIB)
	mpiexec -n 2 ./tetra_dynamo sample.namelist

-include depend_list.mk


depend_list.mk: *.ef
	../bin/gendep.sh > $@ 


#
# For the print-out list of the source code.
#   Note: Utility libraries "mpiut.ef" and "ut.ef" are skipped
#         Since they are too long
#
print_files := Makefile
print_files += efpp_alias.list
print_files += $(shell ls ../bin/*.sh)
print_files += job/mkjob.sh src/sample.namelist
print_files += $(shell ls *.ef  \
			| sed '/turtle.ef/d' \
			| sed '/turtle_epslib.ef/d' \
			| sed '/kutimer.ef/d' \
			| sed '/ut.ef/d' \
			| sed '/mpiut.ef/d' )

#
# list of the source code.
#
list:
	../bin/print-source-files-to-pdf.sh $(print_files)

line:
	@echo "="{1..100} | sed 's/[ 0-9]//g' # bash one-liner for a line



clean:
	rm -rf list.ps list.pdf
	rm -rf depend_list.mk
	rm -rf *.o *.lst *.F90 *.mod *.L
	rm -rf tetra_dynamo
