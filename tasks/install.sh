#!/bin/sh

# bolt will pass in parameter values as ENV vars prefixed with PT_

export SPLUNK_URL=$PT_splunk_url 
export HEC_PORT=$PT_hec_port
export RECEIVER_PORT=$PT_hec_port
export HEC_TOKEN=$PT_hec_token
export DIMENSIONS=$PT_dimensions
export METRIC_TYPES=$PT_metric_types
export METRIC_OPTS=$PT_metric_opts
export LOG_SOURCES=$PT_log_sources

TMP_DIR=$(mktemp -d)

cd $TMP_DIR
if wget --no-check-certificate $PT_agent_url
then
  # save the cd bs
  tar -xzf unix-agent.tgz --strip 1
  bash install_uf.sh
  bash install_agent.sh
  STATUS=0
else
  STATUS=1
fi

exit $STATUS