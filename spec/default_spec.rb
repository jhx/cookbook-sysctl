require 'spec_helper'

describe 'sysctl::default' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'sysctl::default' }
  
  it 'should test ruby_block' do
    pending 'TODO: figure out how to test ruby_block'
  end # it 'should test ruby_block'
  
end # describe 'sysctl::default'
