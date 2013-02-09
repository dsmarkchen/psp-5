CC = gcc
CC += -c
CPP = g++
CPP += -c 
LD = g++
RM = rm
RM += -rf


SRC_DIR=../../source/ex-01
BUILD_DIR=../../build
CPP_EX_01 = $(BUILD_DIR)/ex-01
GTEST_OBJS = $(BUILD_DIR)/gtest-all.o $(BUILD_DIR)/gtest-main.o
CPP_LIBS = -lpthread 


OBJS_CPP_EX_01 = $(BUILD_DIR)/ex-01.o 

$(BUILD_DIR)/ex-01.o: $(SRC_DIR)/ex-01.cpp
	@echo "Compiling "$@
	@echo "    CPP       "$<
	$(CPP) -I../.. -O0 -g3 -Wall -o $@ $< -DTESTING
	@echo 'Finished building: $<'
	@echo ' '

all: pre_compile $(CPP_EX_01)

pre_compile: $(SRC_DIR)/ex-01.w
	@echo "CWEB weaving: "$<
	@echo ' '
	ctangle $<
	cweave  $<
	pdftex ex-01.tex
	cp ex-01.c ex-01.cpp
	@echo 'Finished weaving: $<'
	@echo ' '


$(CPP_EX_01) : $(OBJS_CPP_EX_01) 
	@echo "Linking "$@
	@echo "    LD        -o "$(CPP_EX_01)"        "$(OBJS_CPP_EX_01)
	$(LD) -o $(CPP_EX_01) $(OBJS_CPP_EX_01) $(GTEST_OBJS) $(CPP_LIBS)


clean:
	$(RM) $(OBJS_CPP_EX_01) $(FILES_TEMP)

FILES_TEMP = $(SRC_DIR)/ex-01.cpp  \
              $(SRC_DIR)/ex-01.pdf  \
              $(SRC_DIR)/ex-01.tex  \
              $(SRC_DIR)/ex-01.log \
              $(SRC_DIR)/ex-01.idx  \
              $(SRC_DIR)/ex-01.scn  \
              $(SRC_DIR)/ex-01.toc  \
              $(SRC_DIR)/ex-01.c


