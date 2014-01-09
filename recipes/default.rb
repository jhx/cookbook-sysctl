# coding: utf-8
#
# Cookbook Name:: sysctl
# Recipe:: default
#
# Author:: Doc Walker (<doc.walker@jameshardie.com>)
#
# Copyright 2012, James Hardie Building Products, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef/util/file_edit'

file = '/etc/sysctl.conf'
pid_max = node['sysctl']['kernel']['pid_max']

# TODO: FC014: Consider extracting long ruby_block to library:
ruby_block "configure #{file}" do
  block do
    f = Chef::Util::FileEdit.new(file)
    regex = /^kernel.pid_max.*/
    value = "kernel.pid_max = #{pid_max}"
    comment = '# allow higher PIDs (instead of 2^15 to reduce rollover problems); may break some programs'
    f.search_file_replace_line(regex, value)
    f.insert_line_if_no_match(regex, "\n#{comment}\n#{value}")
    f.write_file

    cmd = 'cat /proc/sys/kernel/pid_max'
    before = Chef::ShellOut.new(cmd)
    after = Chef::ShellOut.new(cmd)
    sysctl = Chef::ShellOut.new('/sbin/sysctl -p')

    before.run_command
    Chef::Log.debug "kernel.pid_max = #{before.stdout} (before)"

    Chef::Log.debug "Reload settings from #{file}"
    sysctl.run_command

    after.run_command
    Chef::Log.debug "kernel.pid_max = #{after.stdout} (after)"
  end # block

  action :create
end # ruby_block
