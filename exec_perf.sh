#!/bin/bash

function execute() {
  
  exe=$exe_name ;

  if [[ -n $INSTRUMENT && $INSTRUMENT -eq 1 ]]; then
    exe=INS_$exe_name ;
  fi

  cmd="$TIMEOUT --signal=TERM ${RUNTIME} \
       perf stat -e $PERF_TOOL:$PERF_TYPE -o $PERF_FILE \
       ./$exe $RUN_OPTIONS < $STDIN > $STDOUT" ;

  echo "$cmd"
  echo "cd $(pwd) && $cmd" >> $BASEDIR/run.txt ;
  
}
