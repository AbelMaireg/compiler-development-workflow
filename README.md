### README.md

---

# **Project Setup and Usage Guide**

This document provides instructions on how to build and run the project using Docker and Make. The setup involves integrating **Flex** and **Bison** inside a Docker container for lexical and syntactic analysis.

---

## **Requirements**

Ensure you have the following tools installed on your system:

1. **Docker**  
   [Installation Guide](https://docs.docker.com/get-docker/)

2. **Make** (Optional)  
   [Installation Guide](https://www.gnu.org/software/make/)  
   You can use **raw Docker commands** outside the docker environment instead of Make if you prefer.

---

## **Project Structure**

```
.
├── build
│   ├── grammar-out.tab.c
│   ├── grammar-out.tab.h
│   └── rules-out.yy.c
├── Dockerfile
├── Makefile
├── README.md
└── src
    ├── grammar.y
    └── rules.l
```

---

## **Setup Steps**

### **Option 1: Using Make (Recommended)**

### **1. Build the Docker Image and Start the Container**

```bash
make build-up
```

This command builds the Docker image using the **Dockerfile** and starts the container with the current directory mounted inside.

### **2. Run the Project Inside the Container**

```bash
make run
```

This command will:

- Generate the necessary files using **Bison** and **Flex**.
- Compile the output into an executable.
- Run the program inside the container.

---

### **Option 2: Using Raw Docker Commands**

If you don’t want to install **Make**, you can build and run the Docker container manually using these commands:

### **1. Build the Docker Image**

```bash
docker build -t lexy .
```

### **2. Start the Container with Volume Binding**

#### For Linux and MacOs users 

```bash
docker run -it --rm -v "$(pwd)":/workspace lexy bash
```

#### For Windows users 

```bash
docker run -it --rm -v "$(PWD)":/workspace lexy bash
```

- **Explanation**:
  - `-it`: Runs the container in interactive mode.
  - `--rm`: Automatically removes the container when it exits.
  - `-v "$(pwd)":/workspace`: Mounts the current directory into the container at `/workspace`.

### **3. Run Flex and Bison Commands Inside the Container**

Once inside the container, run the following commands manually:

| Command        | Description                                       |
|----------------|---------------------------------------------------|
| `make run`     | Runs the project inside the container.            |
| `make clean`   | Cleans up the generated files and build artifacts.|

---

## **How It Works**

1. **Building the Image**:
   - The Dockerfile installs the necessary tools (**Bison**, **Flex**, **GCC**, etc.).
   - The current directory is mounted into the container, allowing you to edit files outside the container while compiling them inside.

2. **Running the Project**:
   - Inside the container, the **Makefile** handles the sequence of commands to run **Bison**, **Flex**, and **GCC**.
   - The lexer and parser work together to process your input files.

---

### **How to Use the Project**

#### **Editing Files**

1. **Edit Source Files**:  
   Modify the `grammar.y` (Bison grammar) and `rules.l` (Flex rules) files located in the `src/` directory using your preferred text editor or IDE.

   Example changes:
   - **grammar.y**: Define grammar rules and associated actions.
   - **rules.l**: Specify regular expressions for lexical analysis.

2. **Save Changes**:  
   Ensure all changes are saved in the `src/` directory. Since the current directory is mounted into the container, any changes you make will be immediately available inside the container.

---


### **Cleaning Up**

To remove any generated files or clean up the `build` directory, run:

```bash
make clean
```

Or, if you prefer Docker:

#### For Linux and MacOs users

```bash
docker run -it --rm -v "$(pwd)":/workspace lexy bash -c "rm -rf build"
```

#### For Windows users

```bash
docker run -it --rm -v "$(PWD)":/workspace lexy bash -c "rm -rf build"
```

---


## **Additional Information**

- **Dockerfile** ensures a consistent environment, reducing dependency issues.
- The **Makefile** provides a simplified interface to run complex commands, making the build process easier.
- **Manual Docker commands** provide an alternative for users who prefer not to install Make.

---
