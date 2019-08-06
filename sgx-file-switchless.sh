######## SGX SDK Settings ########
SGX_SDK="/opt/intel/sgxsdk"
SGX_MODE=HW
SGX_ARCH=x64
SGX_DEBUG=0
SGX_PRERELEASE=1

if [ $SGX_ARCH == x86 ]; then
	SGX_COMMON_CFLAGS="-m32"
	SGX_LIBRARY_PATH="$SGX_SDK/lib"
	SGX_ENCLAVE_SIGNER="$SGX_SDK/bin/x86/sgx_sign"
	SGX_EDGER8R="$SGX_SDK/bin/x86/sgx_edger8r"
else
	SGX_COMMON_CFLAGS="-m64"
	SGX_LIBRARY_PATH="$SGX_SDK/lib64"
	SGX_ENCLAVE_SIGNER="$SGX_SDK/bin/x64/sgx_sign"
	SGX_EDGER8R="$SGX_SDK/bin/x64/sgx_edger8r"
fi

if [ $SGX_DEBUG == 1 ]; then
    SGX_COMMON_CFLAGS="$SGX_COMMON_CFLAGS -O0 -g"
else
	SGX_COMMON_CFLAGS="$SGX_COMMON_CFLAGS -O2"
fi

######## App Settings ########
if [ $SGX_MODE != HW ]; then
	Urts_Library_Name=sgx_urts_sim
else
	Urts_Library_Name=sgx_urts
fi

App_Include_Paths=" -IInclude -IApp -I$SGX_SDK/include"

App_C_Flags="$SGX_COMMON_CFLAGS -fPIC -Wno-attributes $App_Include_Paths"

# Three configuration modes - Debug, prerelease, release
#   Debug - Macro DEBUG enabled.
#   Prerelease - Macro NDEBUG and EDEBUG enabled.
#   Release - Macro NDEBUG enabled.
if [ $SGX_DEBUG == 1 ]; then
	App_C_Flags="$App_C_Flags -DDEBUG -UNDEBUG -UEDEBUG"
elif [ $SGX_PRERELEASE == 1 ]; then
	App_C_Flags="$App_C_Flags -DNDEBUG -DEDEBUG -UDEBUG"
else
	App_C_Flags="$App_C_Flags -DNDEBUG -UEDEBUG -UDEBUG"
fi

App_Cpp_Flags="$App_C_Flags -std=c++11"
App_Link_Flags="$SGX_COMMON_CFLAGS -L$SGX_LIBRARY_PATH -l$Urts_Library_Name -lsgx_uprotected_fs -lpthread" 

if [ $SGX_MODE != HW ]; then
	App_Link_Flags="$App_Link_Flags -lsgx_uae_service_sim"
else
	App_Link_Flags="$App_Link_Flags -lsgx_uae_service"
fi



######## Enclave Settings ########
if [ $SGX_MODE != HW ]; then
	Trts_Library_Name=sgx_trts_sim
	Service_Library_Name=sgx_tservice_sim
else
	Trts_Library_Name=sgx_trts
	Service_Library_Name=sgx_tservice
fi

Crypto_Library_Name=sgx_tcrypto

#Enclave_Cpp_Files=Enclave/Enclave.cpp
#Enclave_Cpp_Objects=Enclave/Enclave.o
Enclave_Include_Paths=" -IInclude -IEnclave -I$SGX_SDK/include -I$SGX_SDK/include/tlibc -I$SGX_SDK/include/libcxx"

#CC_BELOW_4_9= $(shell expr "`$(CC) -dumpversion`" \< "4.9")
#ifeq ($(CC_BELOW_4_9), 1)
#	Enclave_C_Flags := $(SGX_COMMON_CFLAGS) -nostdinc -fvisibility=hidden -fpie -ffunction-sections -fdata-sections -fstack-protector
#else
#	Enclave_C_Flags := $(SGX_COMMON_CFLAGS) -nostdinc -fvisibility=hidden -fpie -ffunction-sections -fdata-sections -fstack-protector-strong
#endif

Enclave_C_Flags="$SGX_COMMON_CFLAGS -nostdinc -fvisibility=hidden -fpie -ffunction-sections -fdata-sections -fstack-protector-strong"
Enclave_C_Flags="$Enclave_C_Flags $Enclave_Include_Paths"
Enclave_Cpp_Flags="$Enclave_C_Flags -std=c++11 -nostdinc++"

# To generate a proper enclave, it is recommended to follow below guideline to link the trusted libraries:
#    1. Link sgx_trts with the `--whole-archive' and `--no-whole-archive' options,
#       so that the whole content of trts is included in the enclave.
#    2. For other libraries, you just need to pull the required symbols.
#       Use `--start-group' and `--end-group' to link these libraries.
# Do NOT move the libraries linked with `--start-group' and `--end-group' within `--whole-archive' and `--no-whole-archive' options.
# Otherwise, you may get some undesirable errors.
Enclave_Link_Flags="$SGX_COMMON_CFLAGS -Wl,--no-undefined -nostdlib -nodefaultlibs -nostartfiles -L$SGX_LIBRARY_PATH  
-Wl,--whole-archive -l$Trts_Library_Name -Wl,--no-whole-archive -Wl,--start-group -lsgx_tstdc -lsgx_tcxx -l$Crypto_Library_Name 
-l$Service_Library_Name -Wl,--end-group -Wl,-Bstatic -Wl,-Bsymbolic -Wl,--no-undefined -Wl,-pie,-eenclave_entry 
-Wl,--export-dynamic -Wl,--defsym,__ImageBase=0 -Wl,--gc-sections  -Wl,--version-script=Enclave/Enclave.lds"


App_Lib="sgx-app.bc"
Enclave_File="enclave.so"
Signed_Enclave_File="enclave.signed.so"
Enclave_Config_File=Enclave/Enclave.config.xml

# echo "SGX_SDK:$SGX_SDK"
# echo "SGX_MODE:$SGX_MODE"
# echo "SGX_ARCH:$SGX_ARCH"
# echo "SGX_DEBUG:$SGX_DEBUG"
# echo "SGX_COMMON_CFLAGS:$SGX_COMMON_CFLAGS"
# echo "SGX_LIBRARY_PATH:$SGX_LIBRARY_PATH"
# echo "SGX_ENCLAVE_SIGNER:$SGX_ENCLAVE_SIGNER"
# echo "SGX_EDGER8R:$SGX_EDGER8R"
# echo "SGX_COMMON_CFLAGS:$SGX_COMMON_CFLAGS"

# echo "Urts_Library_Name:$Urts_Library_Name"
# echo "App_Cpp_Files:$App_Cpp_Files"
# echo "App_Include_Paths:$App_Include_Paths"
# echo "App_C_Flags:$App_C_Flags"
# echo "App_Cpp_Flags:$App_Cpp_Flags"
# echo "App_Cpp_Objects:$App_Cpp_Objects"
# echo "App_Link_Flags:$App_Link_Flags"
# echo "App_Name:$App_Name"

# echo "Service_Library_Name:$Service_Library_Name"
# echo "Trts_Library_Name:$Trts_Library_Name"
# echo "Crypto_Library_Name:$Crypto_Library_Name"
# echo "Enclave_Cpp_Files:$Enclave_Cpp_Files"
# echo "Enclave_Cpp_Objects:$Enclave_Cpp_Objects"
# echo "Enclave_Include_Paths:$Enclave_Include_Paths"
# echo "Enclave_C_Flags:$Enclave_C_Flags"
# echo "Enclave_Cpp_Flags:$Enclave_Cpp_Flags"
# echo "Enclave_Link_Flags:$Enclave_Link_Flags"
# echo "Enclave_File:$Enclave_Name"
# echo "Signed_Enclave_File:$Signed_Enclave_Name"
# echo "Enclave_Config_File:$Enclave_Config_File"


# cd App
# Enclave_u_h="$SGX_EDGER8R --untrusted ../Enclave/Enclave.edl --search-path ../Enclave --search-path $SGX_SDK/include"
# echo $Enclave_u_h
# $Enclave_u_h

# cd ../Enclave

# Enclave_t_c="$SGX_EDGER8R --trusted ../Enclave/Enclave.edl --search-path ../Enclave --search-path $SGX_SDK/include"
# echo $Enclave_t_c
# $Enclave_t_c

SGX_User_Libs=$HOME/SGX/lib
app_c_source_files=("${source_files[@]}")
#app_cpp_source_files=()
echo "source files: $app_c_source_files"
