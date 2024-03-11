# Compiler and flags
DMD = dmd
DMDFLAGS = -w -de -O -release -inline -boundscheck=off

# Source files
SRCDIR = .
SOURCES = $(wildcard $(SRCDIR)/*.d)

# Output directory
BINDIR = bin

# Target executable
TARGET = $(BINDIR)/output

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(SOURCES)
	@mkdir -p $(BINDIR)
	$(DMD) $(DMDFLAGS) -of=$@ $^

clean:
	rm -rf $(BINDIR)
