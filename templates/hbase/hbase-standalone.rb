Eye.application 'hbase-standalone' do
  working_dir '/etc/eye'
  stdall '/var/log/eye/hbase-standalone-stdall.log' # stdout,err logs for processes by default
  trigger :flapping, times: 10, within: 1.minute, retry_in: 3.minutes
  check :cpu, every: 10.seconds, below: 100, times: 3 # global check for all processes
  env "USER" => "root"

  process :hbase do
    pid_file '/tmp/hbase-root-master.pid'
    start_command '/opt/hbase/bin/start-hbase.sh'
    stop_command '/opt/hbase/bin/stop-hbase.sh'

    daemonize true
    start_timeout 20.seconds
    stop_timeout 120.seconds

  end

end
