#!/bin/bash

function ASC_Sequoia() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function BenchmarkGame() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function BitBench() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function CoyoteBench() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function Dhrystone() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function DOE_ProxyApps_C() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function McGill() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBench() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBench-Full-O0-HEAP() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBench-Full-O1-HEAP() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBench-Full-O2-HEAP() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBench-Full-O0-SGX-SIM() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBench-Full-O1-SGX-SIM() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBench-Full-O2-SGX-SIM() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBench-Full-O0-HW() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBench-Full-O1-HW() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBench-Selective-O0-HEAP() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBench-Selective-O1-HEAP() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBench-Selective-O2-HEAP() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBench-Selective-O0-SGX-SIM() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBench-Selective-O1-SGX-SIM() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBench-Selective-O2-SGX-SIM() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBench-Selective-O0-HW() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBench-Selective-O1-HW() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }

function MiBenchR() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBenchR-Full-O0-HEAP() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBenchR-Full-O1-HEAP() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBenchR-Full-O2-HEAP() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBenchR-Full-O0-SGX-SIM() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBenchR-Full-O1-SGX-SIM() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBenchR-Full-O2-SGX-SIM() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBenchR-Selective-O0-HEAP() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBenchR-Selective-O1-HEAP() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBenchR-Selective-O2-HEAP() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBenchR-Selective-O0-SGX-SIM() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBenchR-Selective-O1-SGX-SIM() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MiBenchR-Selective-O2-SGX-SIM() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function Misc() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function Shootout() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function Shootout-Full() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function Shootout-Selective() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function Stanford() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function Stanford-Selective() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function Stanford-Full() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function Stanford-Full-O0-HEAP() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function Stanford-Full-O1-HEAP() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function Stanford-Full-O0-SGX-SIM() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function Stanford-Full-O1-SGX-SIM() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function Stanford-Selective-O0-HEAP() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function Stanford-Selective-O1-HEAP() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function Stanford-Selective-O0-SGX-SIM() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function Stanford-Selective-O1-SGX-SIM() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function Ptrdist() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function Trimaran() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function TSVC() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function NPB-serial() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function VersaBench() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function FreeBench() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function MallocBench() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function McCat() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function Olden() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function Olden-Full() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function Olden-Selective() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }

function Prolangs-C() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function Custom() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function SGXBench() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function SGXBench-Selective() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function SGXBench-Selective-cpp() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function SGXBench-Full() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }
function SGXBench-Selective-O1() { dirs=($( ls -d */ )); walk "${dirs[@]}" ; }


function Fhourstones() { walk "." ; }
function Fhourstones_31() { walk "." ; }
function Linpack() { walk "." ; }
function ASCI_Purple() { walk "." ; }
function SciMark2-C() { walk "." ; }
function sim() { walk "." ; }
function mafft() { walk "." ; }
function tramp3d-v4() { walk "." ; }
function llubenchmark() { walk "." ; }
function nbench() { walk "." ; }
function PAQ8p() { walk "." ; }

function mediabench() {
  dirs=("adpcm/rawcaudio" "adpcm/rawdaudio" "g721/g721encode" "jpeg/jpeg-6a" 
        "gsm/toast" "mpeg2/mpeg2dec")
  walk "${dirs[@]}"
}

function PolyBench(){
  dirs=("linear-algebra/kernels/2mm" "linear-algebra/kernels/3mm" "linear-algebra/kernels/atax"
        "linear-algebra/kernels/bicg" "linear-algebra/kernels/doitgen" "linear-algebra/kernels/mvt" 
        "linear-algebra/solvers/cholesky" "linear-algebra/solvers/durbin" "linear-algebra/solvers/gramschmidt"
        "linear-algebra/solvers/lu" "linear-algebra/solvers/ludcmp" "linear-algebra/solvers/trisolv"
        "linear-algebra/blas/gemm" "linear-algebra/blas/gemver" "linear-algebra/blas/gesummv"
        "linear-algebra/blas/symm" "linear-algebra/blas/syr2k" "linear-algebra/blas/syrk"
        "linear-algebra/blas/trmm"
        "datamining/correlation" "datamining/covariance"
        "medley/floyd-warshall" "medley/deriche" "medley/nussinov"
        "stencils/adi" "stencils/fdtd-2d" "stencils/heat-3d" "stencils/jacobi-1d" "stencils/jacobi-2d"
        "stencils/seidel-2d")
  walk "${dirs[@]}"
}

function cBench(){
  dirs=("security_rijndael_d/src" "automotive_susan_c/src"
        "security_rijndael_e/src" "consumer_jpeg_c/src" "consumer_lame/src"
        "bzip2e/src" "telecom_adpcm_d/src" "bzip2d/src"
        "network_dijkstra/src" "office_stringsearch1/src"
        "consumer_tiffdither/src" "automotive_qsort1/src" 
        "consumer_jpeg_d/src" "automotive_susan_e/src" 
        "automotive_bitcount/src" "security_blowfish_e/src" "consumer_tiff2bw/src"
        "telecom_CRC32/src" "security_sha/src" "consumer_tiffmedian/src"
        "automotive_susan_s/src" "network_patricia/src" "telecom_adpcm_c/src"
        "consumer_tiff2rgba/src" "security_blowfish_d/src")
      
  cant=("consumer_mad/src" "office_ispell/src" "office_ghostscript/src" "office_rsynth/src"
  "security_pgp_d/src" "security_pgp_e/src" "telecom_gsm/src")
  
  walk "${dirs[@]}"
}

function cBench-Selective(){
  dirs=("security_rijndael_d/src" "automotive_susan_c/src"
        "security_rijndael_e/src" "consumer_jpeg_c/src" "consumer_lame/src"
        "bzip2e/src" "telecom_adpcm_d/src" "bzip2d/src"
        "network_dijkstra/src" "office_stringsearch1/src"
        "consumer_tiffdither/src" "automotive_qsort1/src" 
        "consumer_jpeg_d/src" "automotive_susan_e/src" 
        "automotive_bitcount/src" "security_blowfish_e/src" "consumer_tiff2bw/src"
        "telecom_CRC32/src" "security_sha/src" "consumer_tiffmedian/src"
        "automotive_susan_s/src" "network_patricia/src" "telecom_adpcm_c/src"
        "consumer_tiff2rgba/src" "security_blowfish_d/src")
      
  cant=("consumer_mad/src" "office_ispell/src" "office_ghostscript/src" "office_rsynth/src"
  "security_pgp_d/src" "security_pgp_e/src" "telecom_gsm/src")
  
  walk "${dirs[@]}"
}

function cBench-Full(){
  dirs=("security_rijndael_d/src" "automotive_susan_c/src"
        "security_rijndael_e/src" "consumer_jpeg_c/src" "consumer_lame/src"
        "bzip2e/src" "telecom_adpcm_d/src" "bzip2d/src"
        "network_dijkstra/src" "office_stringsearch1/src"
        "consumer_tiffdither/src" "automotive_qsort1/src" 
        "consumer_jpeg_d/src" "automotive_susan_e/src" 
        "automotive_bitcount/src" "security_blowfish_e/src" "consumer_tiff2bw/src"
        "telecom_CRC32/src" "security_sha/src" "consumer_tiffmedian/src"
        "automotive_susan_s/src" "network_patricia/src" "telecom_adpcm_c/src"
        "consumer_tiff2rgba/src" "security_blowfish_d/src")
      
  cant=("consumer_mad/src" "office_ispell/src" "office_ghostscript/src" "office_rsynth/src"
  "security_pgp_d/src" "security_pgp_e/src" "telecom_gsm/src")
  
  walk "${dirs[@]}"
}

function cpu2006(){
  dirs=("400.perlbench/rbc/" "401.bzip2/rbc/" "403.gcc/rbc/" "429.mcf/rbc/"
        "433.milc/rbc/" "444.namd/rbc/" "445.gobmk/rbc/"
        "456.hmmer/rbc/" "458.sjeng/rbc/" "462.libquantum/rbc/" 
        "464.h264ref/rbc/" "470.lbm/rbc/")
  walk "${dirs[@]}"
}

#benchs=( "Stanford-Selective")

#benchs=( "ASC_Sequoia" "BenchmarkGame" "BitBench" "CoyoteBench" "DOE_ProxyApps_C" 
#  "Dhrystone" "McGill" "MiBench" "Misc"  "Shootout" "Stanford" "Fhourstones" 
# "Linpack" "mediabench" "ASCI_Purple" "Fhourstones_31" "PolyBench"
#  "SciMark2-C" "sim" "mafft" "tramp3d-v4" "llubenchmark" "nbench" "Ptrdist"
#  "Trimaran" "TSVC" "PAQ8p" "NPB-serial" "VersaBench" "FreeBench" "cBench"
#  "MallocBench" "McCat" "Olden" "Prolangs-C" "cpu2006")

