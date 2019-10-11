######## SGX SDK Settings ########
SGX_SDK="/opt/intel/sgxsdk"
SGX_MODE=HW
SGX_ARCH=x64
SGX_DEBUG=1
SGX_PRERELEASE=0

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
App_Link_Flags="-L$SGX_LIBRARY_PATH -l$Urts_Library_Name -lpthread" 

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

Enclave_File="enclave.so"
Signed_Enclave_File="enclave.signed.so"
App_Lib="sgx-app.bc"

SGX_User_Libs=$HOME/SGX/lib
app_c_source_files=("${source_files[@]}")
echo "source files: $app_c_source_files"
