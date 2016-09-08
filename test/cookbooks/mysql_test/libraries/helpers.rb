# This is only used by the replication recipe in the smoke test quite

require 'chef/mixin/shell_out'
require 'shellwords'
include Chef::Mixin::ShellOut

# Duplicated in recipes/smoke.rb
strong_root_password = 'MyPa$$word\Has_"Special\'Chars%!'
shell_root_password  = Shellwords.escape(strong_root_password)

def start_slave_1
  query = ' CHANGE MASTER TO'
  query << " MASTER_HOST='127.0.0.1',"
  query << " MASTER_USER='repl',"
  query << " MASTER_PASSWORD='REPLICAAATE',"
  query << ' MASTER_PORT=3306,'
  query << " MASTER_LOG_POS=#{::File.open('/root/position').read.chomp};"
  query << ' START SLAVE;'
  shell_out("echo \"#{query}\" | /usr/bin/mysql -u root -h 127.0.0.1 -P3307 -p#{shell_root_password)}")
end

def start_slave_2
  query = ' CHANGE MASTER TO'
  query << " MASTER_HOST='127.0.0.1',"
  query << " MASTER_USER='repl',"
  query << " MASTER_PASSWORD='REPLICAAATE',"
  query << ' MASTER_PORT=3306,'
  query << " MASTER_LOG_POS=#{::File.open('/root/position').read.chomp};"
  query << ' START SLAVE;'
  shell_out("echo \"#{query}\" | /usr/bin/mysql -u root -h 127.0.0.1 -P3308 -p#{shell_root_password)}")
end
