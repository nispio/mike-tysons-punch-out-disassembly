red=$(shell tput setaf 1)
green=$(shell tput setaf 2)
magenta=$(shell tput setaf 6)
reset=$(shell tput sgr0)

ASM := ophis/ophis
MD5 := $(CURDIR)/helper_programs/md5sum

# Define the source and output directories
SRC_DIR := source_files
OUT_DIR := output_files
ORIG_DIR := original_files

# Dependencies that affect all other source files
INCLUDES := $(SRC_DIR)/Mike_Tysons_Punchout_Defines.asm

# Find assembly source files for all PRG Banks
PRG_SOURCES := $(wildcard $(SRC_DIR)/PRG_Bank*.asm)

# Generate corresponding output file names
PRG_NAMES := $(patsubst $(SRC_DIR)/%.asm,%.bin,$(PRG_SOURCES))
BIN_FILES := $(patsubst %.bin,$(OUT_DIR)/%.bin,$(PRG_NAMES))
ORIG_FILES := $(patsubst %.bin,$(ORIG_DIR)/%.bin,$(PRG_FILES))
CHECKSUM_FILES := $(patsubst %.bin,%.md5,$(BIN_FILES))

# Default target
all: $(BIN_FILES) check

# Rule to generate .bin files from .asm files
$(OUT_DIR)/%.bin: $(SRC_DIR)/%.asm $(INCLUDES)
	@mkdir -p $(OUT_DIR)
	@echo "${magenta}Assembling $<${reset}"
	@$(ASM) $< $@

# One-time computation of reference checksums
$(OUT_DIR)/checksums.md5: $(ORIG_FILES)
	@echo "${magenta}Computing reference checksums...${reset}"
	@(cd $(ORIG_DIR); $(MD5) PRG_Bank*.bin) > $@

# Check the assembled binaries against the reference checksums
check: $(OUT_DIR)/checksums.md5 $(BIN_FILES)
	@echo "${magenta}Verifying checksums of PRG banks...${reset}"
	@(cd $(dir $<); $(MD5) -c $(notdir $<)) 2>&1 |\
	  sed -E 's/(.*OK)/${green}\1${reset}/;s/(.*FAILED)/${red}\1${reset}/'

clean:
	@$(RM) -r $(OUT_DIR)

.PHONY: all clean check


#printf "${magenta}Combining Assembled banks into a ROM...${reset}\n"
#cat original_files/header.bin \
#	output_files/PRG_Bank000.bin \
#	output_files/PRG_Bank001.bin \
#	output_files/PRG_Bank002.bin \
#	output_files/PRG_Bank003.bin \
#	output_files/PRG_Bank004.bin \
#	output_files/PRG_Bank005.bin \
#	output_files/PRG_Bank006.bin \
#	output_files/PRG_Bank007.bin \
#	output_files/PRG_Bank008.bin \
#	output_files/PRG_Bank009.bin \
#	output_files/PRG_Bank00A.bin \
#	output_files/PRG_Bank00B.bin \
#	output_files/PRG_Bank00C.bin \
#	output_files/PRG_BankDEF.bin \
#	original_files/CHR_Bank000.bin \
#	original_files/CHR_Bank001.bin \
#	original_files/CHR_Bank002.bin \
#	original_files/CHR_Bank003.bin \
#	original_files/CHR_Bank004.bin \
#	original_files/CHR_Bank005.bin \
#	original_files/CHR_Bank006.bin \
#	original_files/CHR_Bank007.bin \
#	original_files/CHR_Bank008.bin \
#	original_files/CHR_Bank009.bin \
#	original_files/CHR_Bank00A.bin \
#	original_files/CHR_Bank00B.bin \
#	original_files/CHR_Bank00C.bin \
#	original_files/CHR_Bank00D.bin \
#	original_files/CHR_Bank00E.bin \
#	original_files/CHR_Bank00F.bin \
#	original_files/CHR_Bank010.bin \
#	original_files/CHR_Bank011.bin \
#	original_files/CHR_Bank012.bin \
#	original_files/CHR_Bank013.bin \
#	original_files/CHR_Bank014.bin \
#	original_files/CHR_Bank015.bin \
#	original_files/CHR_Bank016.bin \
#	original_files/CHR_Bank017.bin \
#	original_files/CHR_Bank018.bin \
#	original_files/CHR_Bank019.bin \
#	original_files/CHR_Bank01A.bin \
#	original_files/CHR_Bank01B.bin \
#	original_files/CHR_Bank01C.bin \
#	original_files/CHR_Bank01D.bin \
#	original_files/CHR_Bank01E.bin \
#	original_files/CHR_Bank01F.bin \
#	> assembled_mike_tysons_punchout.nes

#printf "\n${magenta}Combining original banks and header into a ROM...${reset}\n\n"
#cat original_files/Header.bin      \
#	original_files/PRG_Bank000.bin \
#	original_files/PRG_Bank001.bin \
#	original_files/PRG_Bank002.bin \
#	original_files/PRG_Bank003.bin \
#	original_files/PRG_Bank004.bin \
#	original_files/PRG_Bank005.bin \
#	original_files/PRG_Bank006.bin \
#	original_files/PRG_Bank007.bin \
#	original_files/PRG_Bank008.bin \
#	original_files/PRG_Bank009.bin \
#	original_files/PRG_Bank00A.bin \
#	original_files/PRG_Bank00B.bin \
#	original_files/PRG_Bank00C.bin \
#	original_files/PRG_BankDEF.bin \
#	original_files/CHR_Bank000.bin \
#	original_files/CHR_Bank001.bin \
#	original_files/CHR_Bank002.bin \
#	original_files/CHR_Bank003.bin \
#	original_files/CHR_Bank004.bin \
#	original_files/CHR_Bank005.bin \
#	original_files/CHR_Bank006.bin \
#	original_files/CHR_Bank007.bin \
#	original_files/CHR_Bank008.bin \
#	original_files/CHR_Bank009.bin \
#	original_files/CHR_Bank00A.bin \
#	original_files/CHR_Bank00B.bin \
#	original_files/CHR_Bank00C.bin \
#	original_files/CHR_Bank00D.bin \
#	original_files/CHR_Bank00E.bin \
#	original_files/CHR_Bank00F.bin \
#	original_files/CHR_Bank010.bin \
#	original_files/CHR_Bank011.bin \
#	original_files/CHR_Bank012.bin \
#	original_files/CHR_Bank013.bin \
#	original_files/CHR_Bank014.bin \
#	original_files/CHR_Bank015.bin \
#	original_files/CHR_Bank016.bin \
#	original_files/CHR_Bank017.bin \
#	original_files/CHR_Bank018.bin \
#	original_files/CHR_Bank019.bin \
#	original_files/CHR_Bank01A.bin \
#	original_files/CHR_Bank01B.bin \
#	original_files/CHR_Bank01C.bin \
#	original_files/CHR_Bank01D.bin \
#	original_files/CHR_Bank01E.bin \
#	original_files/CHR_Bank01F.bin \
#	> stitched_mike_tysons_punchout.nes

#md5sum original_mike_tysons_punchout.nes
#md5sum assembled_mike_tysons_punchout.nes
#md5sum stitched_mike_tysons_punchout.nes
