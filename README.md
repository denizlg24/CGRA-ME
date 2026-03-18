## CGRA-ME is a project from UofT. It is uploaded here for quick access

**Please see the [website](http://cgra-me.ece.utoronto.ca/) for full documentation!**

---

## Building

### Prerequisites

```bash
sudo apt-get install -y llvm-14-dev
```

Gurobi 13 must be installed at `~/gurobi1301/`. A compatibility symlink is needed the first time:

```bash
ln -sf ~/gurobi1301/linux64/lib/libgurobi_g++8.5.a \
        ~/gurobi1301/linux64/lib/libgurobi_g++5.2.a
```

### Configure

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

### Build

```bash
USRCXXFLAGS="-Wno-template-body" make -C build
```

`USRCXXFLAGS` suppresses a GCC 15 error in the bundled SoPlex library.

### Outputs

| Artifact | Path |
|---|---|
| Main executable | `build/bin/cgrame` |
| Shared library | `build/lib/libcgra-me.so` |
| LLVM DFG pass | `build/lib/libDFG.so` |
