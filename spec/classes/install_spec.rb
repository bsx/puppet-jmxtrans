require 'spec_helper'

describe 'jmxtrans' do
  let(:facts) { {:osfamily => 'RedHat'} }

  it { should contain_class('jmxtrans') }
  it { should contain_file('/etc/sysconfig/jmxtrans') }
  it do
    should contain_service('jmxtrans').with(
      'ensure' => 'running'
    )
  end
  it do
    should contain_file('/etc/jmxtrans').with(
      'ensure' => 'directory'
    )
  end
end

describe 'jmxtrans' do
  let(:facts) { {:osfamily => 'debian'} }

  it { should contain_class('jmxtrans') }
  it { should contain_file('/etc/default/jmxtrans') }
  it do
    should contain_service('jmxtrans').with(
      'ensure' => 'running'
    )
  end
  it do
    should contain_file('/etc/jmxtrans').with(
      'ensure' => 'directory'
    )
  end
end

