#!/bin/bash

# this is left as an example 
function compile() {
  
  if [[ -n $CPU2006 && $CPU2006 -eq 1 ]]; then
    # rbc -> lnk
    $LLVM_PATH/opt -S $rbc_name -o $lnk_name

	# Optimizations
	$LLVM_PATH/opt -S -load $PASS_PATH -${PASS} $lnk_name -o $prf_name
	  
	# Generate obj file
	$LLVM_PATH/llc -filetype=obj $prf_name -o $obj_name ;
	  
	# Compile everything now, producing a final executable file:
	$LLVM_PATH/$COMPILER -lm $obj_name -o INS_$exe_name ;
  
  elif [[ -n $SGX && $SGX -eq 1 ]]; then
  	echo "SGX:$SGX"
  	echo "JOBS:$JOBS"
  	echo "LLVM_PATH:$LLVM_PATH"
  	echo "COMPILER:$COMPILER"
  	echo "COMPILE_FLAGS:$APP_C_COMPILE_FLAGS"
  	echo "LINK_FLAGS:$APP_LINK_FLAGS"

    echo "lnk_name:$lnk_name"
    echo "prf_name:$prf_name"
    echo "obj_name:$obj_name"
    echo "exe_name:$exe_name"
    echo "inlined_name:$inlined_name"
   
   
    app_source_files=("${app_c_source_files[@]}" "${app_cpp_source_files[@]}")
    echo "app-source-files:$app_source_files"

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
  
   	parallel --tty --jobs=${JOBS} $LLVM_PATH/opt -S {.}.bc -o {.}.rbc ::: "${app_source_files[@]}"



    if [[ -n $INLINE && $INLINE -eq 1 ]]; then
      #Generate all the bcs into a big bc and inline functions:
          
      $LLVM_PATH/llvm-link -S *.rbc -o $preinlined_name

      sed -i 's/attributes #0 = { noinline/attributes #0 = { /g' $preinlined_name

      $LLVM_PATH/opt -S -inline $preinlined_name -o $postinlined_name
      $LLVM_PATH/llvm-link -S $SGX_User_Libs/$App_Lib $postinlined_name -o $lnk_name

    else
      #Generate all the bcs into a big bc:
      $LLVM_PATH/llvm-link -S $SGX_User_Libs/$App_Lib *.rbc -o $lnk_name
    fi
  	

    # optimizations  	
    $LLVM_PATH/opt -S -load $PASS_PATH -${PASS} $lnk_name -o $prf_name
    # Compile our instrumented file, in IR format, to x86:
    $LLVM_PATH/llc -filetype=obj $prf_name -o $obj_name ;
	# Compile everything now, producing a final executable file:
    $LLVM_PATH/$COMPILER -lm $obj_name -o $exe_name $App_Link_Flags;

    #Since LD_LIBRARY_PATH does not trick for applicatoins to find for enclave.{signed}.so files, we create links for those libraries which include trusted functions to be instrumented
    ln -s $SGX_User_Libs/$Enclave_File $Enclave_File
    ln -s $SGX_User_Libs/$Signed_Enclave_File $Signed_Enclave_File

  else
    # source_files is the variable with all the files we're gonna compile
    parallel --tty --jobs=${JOBS} $LLVM_PATH/$COMPILER $COMPILE_FLAGS \
      -Xclang -disable-O0-optnone \
      -S -c -emit-llvm {} -o {.}.bc ::: "${source_files[@]}" 
    
    parallel --tty --jobs=${JOBS} $LLVM_PATH/opt -S {.}.bc -o {.}.rbc ::: "${source_files[@]}"
  
    #Generate all the bcs into a big bc:
    $LLVM_PATH/llvm-link -S *.rbc -o $lnk_name

  	# Optimizations
  	$LLVM_PATH/opt -S -load $PASS_PATH -${PASS} $lnk_name -o $prf_name
  	  
  	# Generate obj file
  	$LLVM_PATH/llc -filetype=obj $prf_name -o $obj_name ;
  	  
  	# Compile everything now, producing a final executable file:
  	$LLVM_PATH/$COMPILER -lm $obj_name -o INS_$exe_name ;
  fi
  
  
}
