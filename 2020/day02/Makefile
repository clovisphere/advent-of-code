# Compiler and flags
GHC = ghc
GHCFLAGS = -Wall -fno-warn-incomplete-uni-patterns

# Source files and main module
SRCDIR = .
MAINMODULE = Main
SOURCES = $(wildcard $(SRCDIR)/*.hs)

# Output directory
BINDIR = bin

# Target executable
TARGET = $(BINDIR)/output

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(SOURCES)
	@mkdir -p $(BINDIR)
	$(GHC) $(GHCFLAGS) -o $@ $^

clean:
	rm -rf $(BINDIR) && rm -f *.hi *.o
