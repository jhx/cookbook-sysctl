# coding: utf-8
maintainer        'James Hardie Building Products, Inc.'
maintainer_email  'doc.walker@jameshardie.com'
license           'Apache 2.0'
description       'Configures sysctl'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))

name              'sysctl'
version           '0.0.2'

recipe 'sysctl', 'Configures sysctl kernel.pid_max value'

attribute 'sysctl/kernel/pid_max',
  :display_name => 'pid_max',
  :description => 'PID allocation wrap value',
  :default => '999999'
