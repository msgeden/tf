#!/bin/bash

function compile() {

  # source_files is the variable with all the files we're gonna compile

  for file_name in "${source_files[@]}"; do
    
    # ignore _AI.c files in source_files[@]
    if [[ $file_name = *_AI.c ]]; then
      continue
    fi

    f=$(basename $file_name .c) # filename without extension
    bash ${BASEDIR}/runAnalyzesTest.sh $file_name 2> taskminer_$f.out # creates a tmp_AI.c
    mv tmp_AI.c ${f}_AI.c
  done

  files=$(ls -d *_AI.c)
  cmd="gcc-6 -fopenmp  $files  -o $exe_name" ;
  eval $cmd ;

  # for file_name in "${source_files[@]}"; do
  #   base_name=$(basename $file_name .c) ;
  #   btc_name="$base_name.bc" ;
  #   rbc_name="$base_name.rbc" ;
  #   # Convert the target program to LLVM IR:
  #   $LLVM_PATH/$COMPILER $CXXFLAGS -g -c -emit-llvm ${base_name}_AI.c -o $btc_name ;
  #   # Convert the target IR program to SSA form:
  #   $LLVM_PATH/opt $btc_name -o $rbc_name ;
  #
  #   # You can add llvm pass in the command above:
  #   # $LLVM_PATH/opt -mem2reg -instnamer -load DCC888.$suffix -vssa $btc_name -o $rbc_name ;
  # done
  #
  # #Generate all the bcs into a big bc:
  # $LLVM_PATH/llvm-link *.rbc -o $lnk_name ;
  #
  # $LLVM_PATH/opt $lnk_name -o $prf_name ;
  #
  # # Compile our instrumented file, in IR format, to x86:
  # $LLVM_PATH/llc -filetype=obj $prf_name -o $obj_name ;
  # $LLVM_PATH/$COMPILER -lm $obj_name -o $exe_name ;
}
