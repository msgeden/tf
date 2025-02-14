# tf
Easily run llvm test-suite benchmarks. This is a simple test framework built using bash.

## What tf can do for you?
- Run programs with [PIN](https://software.intel.com/en-us/articles/pin-a-dynamic-binary-instrumentation-tool)
- Compile and run benchmarks with your own llvm pass
- Parallel execution
- Easily collect statistics
- Run with a time limit

## Benchmarks

Here is a list of benchmarks available in this repo:

- ASCI_Purple
- ASC_Sequoia
- BenchmarkGame
- BitBench
- CoyoteBench
- Dhrystone
- DOE_ProxyApps_C
- Fhourstones
- Fhourstones_31
- FreeBench
- Linpack
- llubenchmark
- mafft
- MallocBench
- McCat
- McGill
- mediabench
- MiBench
- Misc
- nbench
- NPB-serial
- Olden
- PAQ8p (**C++**)
- Prolangs-C
- Ptrdist
- SciMark2-C
- Shootout
- sim
- Stanford
- tramp3d-v4 (**C++**)
- Trimaran
- TSVC
- VersaBench
- PolyBench

Benchmarks are stored in a different [repo](https://github.com/guilhermeleobas/Benchmarks).

## Requirements
- timeout or [gtimeout](https://stackoverflow.com/questions/3504945/timeout-command-on-mac-os-x) if you're on OS X.
- [gnu-parallel](http://brewformulas.org/Parallel)
- Any version of LLVM.

## Getting tf
Simply clone this repository **recursively**
```bash
git clone --recursive https://github.com/guilhermeleobas/tf.git
```

## Building LLVM (if you gonna use your pass)

Below is a set of instructions to build LLVM 3.8 from source. Remember the path you build LLVM because you gonna need later.

```bash
svn co http://llvm.org/svn/llvm-project/llvm/tags/RELEASE_380/final llvm38
cd llvm38/tools
svn co http://llvm.org/svn/llvm-project/cfe/tags/RELEASE_380/final clang
cd ..
mkdir build
cd build
../configure
make -j8
```

## Usage

The first thing you need to do is select which benchmarks you want to execute. Open `benchs.sh` and add the benchmark you want to run into the variable `benchs`.

Then, go to the file `vars.sh` and set the variable `$LLVM_PATH` to where you build LLVM. This path is something like `/path/to/llvm/build/Release+Asserts/bin` or `/path/to/llvm/build/bin` in newer versions.

### Compiling Benchmarks

Simply type `./run.sh`. If you only want to compile, set the flag `EXEC=0` before calling `run.sh`.

Tip: You can skip compilation by setting `COMPILE=0` before calling `run.sh`.

### Running with a time limit

`RUNTIME=8m ./run.sh` or change the file `vars.sh`.

`RUNTIME` receives a floating point number followed by an optional unit:
- `s` for seconds (the default)
- `m` for minutes
- `h` for hours
- `d` for days

After the specified time interval, **timeout** will send a `TERM` signal to the benchmark process.

Tip: Set `RUNTIME=0` to run indefinitely.

### Compare output

Just run with `DIFF=1` and **tf** will compare the output produced by the binary with a reference output.

### Parallel execution

We use gnu-parallel to run the benchmarks, even if you're running things sequentially. To run in parallel, change the variable `$JOBS` in `vars.sh` or call `JOBS=njobs ./run.sh` from the command line.

### Using with Intel PIN

You need to set a few variables before. Go to the file `vars.sh` and change:
- `PIN_PATH=/path/to/pin/`
- `PIN_LIB=/path/to/pintool/`

The later must point to where your Pintool **source code** is, this way we can easily build your Pintool for you.

Now, call `PIN=1 ./run.sh`

### Collecting stats

**gnu-parallel** creates a logfile called `run.log`. This log contains the job sequence, which host the job was run on, the start time and run time, how much data was transferred, the exit value, the signal that killed the job, and finally the command being run.

You can easily parse the logfile to a csv using python and [pandas](https://pandas.pydata.org/):

```python
import pandas as pd
pd.read_csv('run.log', sep='\t').to_csv('run.csv')
```

You can also add your own code in the file `collect.sh`. **tf** will execute this file after all benchmarks have finished executing.

### Compiling benchmarks with your own LLVM pass

See `instrument.sh`file. You can control how each benchmark is compiled there.

Add the path of your pass to the variable `pass_path` at the beginning of the `instrument.sh` file. Then, call **tf** with `INSTRUMENT=1 PASS=YourPassNameHere`

```bash
COMPILE=1 INSTRUMENT=1 PASS=YourPassNameHere EXEC=1 ./run.sh
```

------------

### Adding more benchmarks

1) For each folder that contains .c files, i.e., the folder that will
   contain the executable file that you are creating, add the following
   `info.sh` file there:

```bash
 bench_name="XX"

 source_files=( "foo.c" "bar.c" "baz.c" "..." )
 COMPILE_FLAGS=" -lm "
 COMPILER="clang"  # or clang++ for C++ programs
 RUN_OPTIONS=" irsmk_input "
 STDIN=" file.in "
 DIFF_CMD=""
```

The last two variables are used when `tf` creates the command that will be executed:

```bash
timeout -signal=TERM $RUNTIME ./$bench_name.exe $RUN_OPTIONS < $STDIN > /dev/null
```

2) Add a function into `benchs.sh`, for the new benchmark.

If the benchmark does not contain subfolders, add:
```bash
function Fhourstones() {
	walk "." ;
}
```
otherwise, add:
```bash
function Misc() {
	dirs=($( ls -d */ )) ;   # list every folder inside Misc/
	walk "${dirs[@]}" ;
}
```

--------

### TIPS
Compiling all benchmarks takes a **considerable** amount of time. Is a good idea to compile them first and execute later:

```bash
COMPILE=1 EXEC=0 ./run.sh   # To compile
COMPILE=0 EXEC=1 ./run.sh   # To execute
```

Also, run benchmarks in parallel whenever you can. Running 220 benchmarks with a time limit of 8 minutes takes 29 hours to complete.
