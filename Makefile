PROGRAM = bin
YACC_FILE = src/grammar.y
LEX_FILE = src/rules.l

BUILD_DIR = build

BISON_OUTPUT = $(BUILD_DIR)/grammar-out.tab.c
FLEX_OUTPUT = $(BUILD_DIR)/rules-out.yy.c
PROGRAM_OUTPUT = $(BUILD_DIR)/$(PROGRAM)
IMAGE_NAME = lexy

all: build-up

$(PROGRAM_OUTPUT): $(BISON_OUTPUT) $(FLEX_OUTPUT)
	mkdir -p $(BUILD_DIR)
	gcc -o $(PROGRAM_OUTPUT) $(BISON_OUTPUT) $(FLEX_OUTPUT) -lfl

$(BISON_OUTPUT): $(YACC_FILE)
	mkdir -p $(BUILD_DIR)
	bison -d $(YACC_FILE) -o $(BISON_OUTPUT)

$(FLEX_OUTPUT): $(LEX_FILE)
	mkdir -p $(BUILD_DIR)
	flex -o $(FLEX_OUTPUT) $(LEX_FILE)

clean:
	rm -rf $(BUILD_DIR)

run: $(PROGRAM_OUTPUT)
	$(PROGRAM_OUTPUT)

compile:
	gcc -o $(PROGRAM_OUTPUT) $(BISON_OUTPUT) $(FLEX_OUTPUT) -lfl

################################################################################
# Docker shortcuts
################################################################################

build:
	docker build . -t $(IMAGE_NAME)

up:
	docker run -it --rm -v .:/workspace $(IMAGE_NAME)

build-up:
	docker build . -t ${IMAGE_NAME}
	docker run -it --rm -v .:/workspace $(IMAGE_NAME)
