## CGRA-ME is a project from UofT. It is uploaded here for quick access

**Please see the [website](http://cgra-me.ece.utoronto.ca/) for full documentation!**

---

## Building

### Prerequisites

#### Linux (Ubuntu/Debian)

```bash
sudo apt-get install -y llvm-14-dev
```

Gurobi 13 must be installed at `~/gurobi1301/`. A compatibility symlink is needed the first time:

```bash
ln -sf ~/gurobi1301/linux64/lib/libgurobi_g++8.5.a \
        ~/gurobi1301/linux64/lib/libgurobi_g++5.2.a
```

#### macOS

Install LLVM 14 via Homebrew:

```bash
brew install llvm@14
```

Install Gurobi 13 from the [official website](https://www.gurobi.com/downloads/). The default install path is `/Library/gurobi1301/macos_universal2`.

Set the `GUROBI_HOME` environment variable (add to your shell profile):

```bash
export GUROBI_HOME=/Library/gurobi1301/macos_universal2
```

### Configure & Build

#### Linux

Run this once from the repo root (re-run after `make fullclean`):

```bash
cd build && cmake \
  -DCMAKE_BUILD_TYPE=release \
  -DBUILD_LLVM_PASSES=ON \
  -DLLVM_DIR=/usr/lib/llvm-14/cmake \
  -DGUROBI_INCLUDE_DIR=~/gurobi1301/linux64/include \
  -DGUROBI_MAIN_LIBRARY=~/gurobi1301/linux64/lib/libgurobi.so.13.0.1 \
  -DGUROBI_5_2_LIBRARY=~/gurobi1301/linux64/lib/libgurobi_g++5.2.a \
  .. && cd ..
```

```bash
USRCXXFLAGS="-Wno-template-body" make -C build
```

`USRCXXFLAGS` suppresses a GCC 15 error in the bundled SoPlex library.

#### macOS

From the repo root, simply run:

```bash
make
```

The Makefile auto-detects Homebrew's LLVM 14 and Gurobi via `$GUROBI_HOME`. No manual cmake invocation is needed.

### Outputs

| Artifact | Path (Linux) | Path (macOS) |
|---|---|---|
| Main executable | `build/bin/cgrame` | `build/bin/cgrame` |
| Shared library | `build/lib/libcgra-me.so` | `build/lib/libcgra-me.dylib` |
| LLVM DFG pass | `build/lib/libDFG.so` | `build/lib/libDFG.so` |

### Quick test

```bash
./build/bin/cgrame --cpp 0 --dfg path/to/graph.dot --mapper 0 --timelimit 30
```
