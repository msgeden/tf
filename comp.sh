#!/bin/bash

# this is left as an example 
function compile() {
  
  if [[ -n $CPU2006 && $CPU2006 -eq 1 ]]; then
    # rbc -> lnk
    $LLVM_PATH/opt -S $rbc_name -o $lnk_name

    $LLVM_PATH/opt -S ${OPT} $lnk_name -o $prf_name
    # Compile our instrumented file, in IR format, to x86:
    $LLVM_PATH/llc -filetype=obj $prf_name -o $obj_name ;
    # Compile everything now, producing a final executable file:
    $LLVM_PATH/$COMPILER -lm $obj_name -o $exe_name ;
  
  elif [[ -n $SGX && $SGX -eq 1 ]]; then
   
    app_source_files=("${app_c_source_files[@]}" "${app_cpp_source_files[@]}")

	  if [ ${#app_c_source_files[@]} != 0 ]; then
		  echo "parallel --tty --jobs=${JOBS} $LLVM_PATH/$COMPILER $App_C_Flags \
      -Xclang -disable-O0-optnone \
      -S -c -emit-llvm {} -o {.}.bc ::: "${app_c_source_files[@]}""
  
	    parallel --tty --jobs=${JOBS} $LLVM_PATH/$COMPILER $App_C_Flags \
	      -Xclang -disable-O0-optnone \
	      -S -c -emit-llvm {} -o {.}.bc ::: "${app_c_source_files[@]}" 
    
    fi


	  if [ ${#app_cpp_source_files[@]} != 0 ]; then
			echo "parallel --tty --jobs=${JOBS} $LLVM_PATH/$COMPILER $App_Cpp_Flags \
      -Xclang -disable-O0-optnone \
      -S -c -emit-llvm {} -o {.}.bc ::: "${app_cpp_source_files[@]}""
  	
	    parallel --tty --jobs=${JOBS} $LLVM_PATH/$COMPILER $App_Cpp_Flags \
	      -Xclang -disable-O0-optnone \
	      -S -c -emit-llvm {} -o {.}.bc ::: "${app_cpp_source_files[@]}" 
    
    fi
  
    echo "parallel --tty --jobs=${JOBS} $LLVM_PATH/opt -S {.}.bc -o {.}.rbc ::: "${app_source_files[@]}""
   	parallel --tty --jobs=${JOBS} $LLVM_PATH/opt -S {.}.bc -o {.}.rbc ::: "${app_source_files[@]}"
   	#Generate all the bcs into a big bc:
    echo "$LLVM_PATH/llvm-link -S $SGX_User_Libs/$App_Lib *.rbc -o $lnk_name "
    $LLVM_PATH/llvm-link -S $SGX_User_Libs/$App_Lib *.rbc -o $lnk_name 
	  #optimizations
    echo "$LLVM_PATH/opt -S ${OPT} $lnk_name -o $prf_name"
    $LLVM_PATH/opt -S ${OPT} $lnk_name -o $prf_name
    # Compile our instrumented file, in IR format, to x86:
    echo "$LLVM_PATH/llc -filetype=obj $prf_name -o $obj_name ;"
    $LLVM_PATH/llc -filetype=obj $prf_name -o $obj_name ;

    # Compile everything now, producing a final executable file:
    echo "$LLVM_PATH/$COMPILER -lm $obj_name -o $exe_name $App_Link_Flags"
    $LLVM_PATH/$COMPILER -lm $obj_name -o $exe_name $App_Link_Flags;    

    #Since LD_LIBRARY_PATH does not trick for applicatoins to find for enclave.{signed}.so files, we create links for those libraries which include trusted functions to be instrumented
    ln -s $SGX_User_Libs/$Enclave_File $Enclave_File
    ln -s $SGX_User_Libs/$Signed_Enclave_File $Signed_Enclave_File
    
  else    
    echo "parallel --tty --jobs=${JOBS} $LLVM_PATH/$COMPILER $COMPILE_FLAGS $OFLAGS \
      -Xclang -disable-O0-optnone \
      -S -c -emit-llvm {} -o {.}.bc ::: "${source_files[@]}""
      
    # source_files is the variable with all the files we're gonna compile
    parallel --tty --jobs=${JOBS} $LLVM_PATH/$COMPILER $COMPILE_FLAGS $OFLAGS \
      -Xclang -disable-O0-optnone \
      -S -c -emit-llvm {} -o {.}.bc ::: "${source_files[@]}"     

    parallel --tty --jobs=${JOBS} $LLVM_PATH/opt -S {.}.bc -o {.}.rbc ::: "${source_files[@]}"
  
    #Generate all the bcs into a big bc:
    $LLVM_PATH/llvm-link -S *.rbc -o $lnk_name
    # optimizations
    $LLVM_PATH/opt -S ${OPT} $lnk_name -o $prf_name
    # Compile our instrumented file, in IR format, to x86:
    $LLVM_PATH/llc -filetype=obj $prf_name -o $obj_name ;
    # Compile everything now, producing a final executable file:
    $LLVM_PATH/$COMPILER -lm $obj_name -o $exe_name ;
  
  fi
}
