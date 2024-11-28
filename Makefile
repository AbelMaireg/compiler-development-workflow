EXECUTABLE = bin
SRC_YACC = src/grammar.y
SRC_LEX = src/rules.l

BUILD_DIR = build

BISON_OUT = $(BUILD_DIR)/grammar-out.tab.c
FLEX_OUT = $(BUILD_DIR)/rules-out.yy.c
EXECUTABLE_OUT = $(BUILD_DIR)/$(EXECUTABLE)
IMAGE_NAME = alpine-lexy

all: build-up

$(EXECUTABLE_OUT): $(BISON_OUT) $(FLEX_OUT)
	mkdir -p $(BUILD_DIR)
	gcc -o $(EXECUTABLE_OUT) $(BISON_OUT) $(FLEX_OUT)

$(BISON_OUT): $(SRC_YACC)
	mkdir -p $(BUILD_DIR)
	bison -d $(SRC_YACC) -o $(BISON_OUT)

$(FLEX_OUT): $(SRC_LEX)
	mkdir -p $(BUILD_DIR)
	flex -o $(FLEX_OUT) $(SRC_LEX)

################################################################################
# Program execution shortcuts
################################################################################

clean:
	rm -rf $(BUILD_DIR)

flex-run: $(SRC_LEX)
	mkdir -p $(BUILD_DIR)
	flex -o $(FLEX_OUT) $(SRC_LEX)
	gcc -o $(EXECUTABLE_OUT) $(FLEX_OUT) -lfl
	./$(EXECUTABLE_OUT)

run: $(EXECUTABLE_OUT)
	$(EXECUTABLE_OUT)

compile:
	gcc -o $(EXECUTABLE_OUT) $(BISON_OUT) $(FLEX_OUT) -lfl

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
