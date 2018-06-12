require 'spec_helper'

describe 'centreontrapd' do
    let(:title) { 'centreontrapd' }
    let(:facts) {{ :centreon_poller => true }}

    test_on = {
        :hardwaremodels => [ 'x86_64', 'i386' ],
        :supported_os   => [
            {
                :operatingsystem        => 'Debian',
                :operatingsystemrelease => [ '6', '7', '8', '9' ]
            },
            {
                :operatingsystem        => 'RedHat',
                :operatingsystemrelease => [ '6', '7' ]
            }
        ]
    }

    on_supported_os(test_on).each do |os, facts|
        context "on #{os}" do
            let(:facts) { facts }

            let(:params) {{
                :dbType         => 'SQLite',
                :centreonDb     => 'dbname=/etc/snmp/centreon_traps/centreontrapd.sdb',
                :centstorageDb  => 'dbname=/etc/snmp/centreon_traps/centreontrapd.sdb'
            }}

            service_name = 'centreontrapd'
        
            [
                "/etc/sysconfig/#{service_name}",
                '/etc/centreon/conf.pm',
                '/etc/centreon/centreontrapd.pm'
            ].each do |f|
                it { is_expected.to contain_file('/var/www/index.html').with(:ensure => 'file') }
            end
        
            it {
                is_expected.to contain_service(service_name).with(:ensure => 'running', :enabled => true )
            }

            it { is_expected.to compile }
            it { is_expected.to compile.with_all_deps }
        end
    end
end
