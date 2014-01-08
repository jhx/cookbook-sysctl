require 'spec_helper'

describe 'sysctl::default' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'sysctl::default' }

  it 'tests ruby_block' do
    pending 'TODO: figure out how to test ruby_block'
  end # it

end # describe
