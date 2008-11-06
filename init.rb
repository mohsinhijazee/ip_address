# Include hook code here

require 'ip_address.rb'
require File.dirname(__FILE__) + '/../../../lib/dedomenon.rb'


register_datatype :name => 'madb_ip_address', :class_name => 'IPAddress'
