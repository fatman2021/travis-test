#!/bin/sh

set -x

coverity_load_proc()
{
    PLATFORM=`uname`
    TOOL_ARCHIVE=/tmp/cov-analysis-${PLATFORM}.tgz
    TOOL_BASE=/tmp/coverity-scan-analysis
    
    wget -nv -O $TOOL_ARCHIVE https://scan.coverity.com/download/${PLATFORM} --post-data "project=$COVERITY_PROJECT_NAME&token=$COVERITY_SCAN_TOKEN"
    
    mkdir -p $TOOL_BASE
    tar xzf $TOOL_ARCHIVE -C $TOOL_BASE
    
    TOOL_DIR=`find $TOOL_BASE -type d -name 'cov-analysis*'`
    export PATH=$TOOL_DIR/bin:$PATH
    return 0
}

coverity_run_proc()
{
    COV_BUILD_OPTIONS=""
    RESULTS_DIR="cov-int"
    
    cov-build --dir $RESULTS_DIR blb -blb
    #cov-import-scm --dir $RESULTS_DIR --scm git --log $RESULTS_DIR/scm_log.txt 2>&1
    return 0
}

coverity_upload_proc()
{
    return 0
}

coverity_load_proc $*
coverity_run_proc $*
