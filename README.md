### **README.md**

---

# **Project Setup and Usage Guide**

This document provides instructions on how to build and run the project using Docker and Make. The setup involves integrating **Flex** and **Bison** inside a Docker container for lexical and syntactic analysis.

---

## **Requirements**

Ensure you have the following tools installed on your system:

1. **Docker**  
   [Installation Guide](https://docs.docker.com/get-docker/)

2. **Make**  
   [Installation Guide](https://www.gnu.org/software/make/manual/html_node/Installing.html)

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
    └── rules.l```

---

## **Setup Steps**

### **1. Build the Docker Image and Start the Container**

Use the `make build-up` command to build the Docker image and run the container:

```bash
make build-up
```

- This command builds the Docker image using the **Dockerfile** and starts the container with the current directory mounted inside.

### **2. Run the Project Inside the Container**

Once the container is running, you can enter it and execute the program using:

```bash
make run
```

This command will:

- Generate the necessary files using **Bison** and **Flex**.
- Compile the output into an executable.
- Run the program inside the container.

---

## **Available Makefile Commands**

| Command        | Description                                       |
|----------------|---------------------------------------------------|
| `make build-up`| Builds the Docker image and starts the container. |
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

### **Cleaning Up**

To remove any generated files or clean up the `build` directory, run:

```bash
make clean
```

---

## **Additional Information**

- **Dockerfile** ensures a consistent environment, reducing dependency issues.
- The **Makefile** provides a simplified interface to run complex commands, making the build process easier.

---
