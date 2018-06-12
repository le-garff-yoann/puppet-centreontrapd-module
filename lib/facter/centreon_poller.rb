require 'puppet'

Facter.add('centreon_poller') do
    confine :kernel => 'Linux'

    setcode do
        ['centengine', 'nagios'].reject { |x|
            begin
                svc = Puppet::Type.type('service').new(:name => x)

                svc.provider.status == :false || svc.provider.status == :absent
            rescue Puppet::Error
                true
            end
        }.count > 0
    end
end
