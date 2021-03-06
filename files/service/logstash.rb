#!/opt/logstash/embedded/bin/ruby

require 'rubygems'
require 'daemons'
require 'pathname'
require 'fileutils'

# Get the full path to this script's directory since Daemons does a chdir to
# / just after forking..
scriptdir = "/opt/logstash/"

# some variables to make things easier to remember

JAVA         = "/opt/logstash/embedded/jre/bin/java"
CONFIG_DIR   = "/opt/logstash/etc/logstash.d"
PATTERNSPATH = "/opt/logstash/patterns"
JARNAME      = "/opt/logstash/bin/logstash.jar"
JAVAMEM      = 256
ARGS="-jar #{JARNAME} agent --config #{CONFIG_DIR} --grok-patterns-path #{PATTERNSPATH}"


# populate environment variables
pid_dir = "/opt/logstash/tmp"
app_name = "logstash"
log_output = true
log_dir = "/opt/logstash/log"
cmd = "#{JAVA} #{ARGS}"

options = {
          :dir_mode => :normal,
          :dir => pid_dir,
          :log_output => log_output,
          :log_dir => log_dir
          }

Daemons.run_proc(app_name, options) do
  Dir.chdir(scriptdir)
  exec "#{cmd}"
end