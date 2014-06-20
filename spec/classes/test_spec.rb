# Use this for testing scenarios you have described in manifests/test.pp

require 'spec_helper'

# Test that creating a resource with the jmxtrans::metrics defined type more
# than once will still compile correctly (there are no duplicated resources)
describe 'jmxtrans::test::metrics::multiple' do
  let(:facts) { {:osfamily => 'RedHat'} }

  it { should contain_jmxtrans__metrics('service_a') }
  it { should contain_jmxtrans__metrics('service_b') }
end

describe 'jmxtrans::test::metrics::duplicate' do
  let(:facts) { {:osfamily => 'RedHat'} }

  it do
    expect {
      should contain_jmxtrans__metrics('service_a')
    }.to raise_error(Puppet::Error)
  end
end
