class centreontrapd::params {
    if $::kernel != 'Linux' {
        fail('This module only work with Linux')
    }

    $isPoller = $::centreon_poller
    $serviceName = 'centreontrapd'
    $sysconfigFile = "/etc/sysconfig/${serviceName}"

    $sysconfigDefault = {
        '--logfile'     => '/var/log/centreon/centreontrapd.log',
        '--severity'    => 'info'
    }

    $config = {
        'conf_path'             => '/etc/centreon/conf.pm',
        'centreontrapd_path'    => '/etc/centreon/centreontrapd.pm',
        'owner'                 => 'centreon',
        'group'                 => 'centreon',
        'mode'                  => '644'
    }

    $centreonConfig = {
        'VarLib'            => '/var/lib/centreon',
        'CentreonDir'       => '/usr/share/centreon/',
        'centreon_db'       => 'centreon',
        'centstorage_db'    => 'centreon_storage',
        'db_host'           => '127.0.0.1:3306',
        'db_user'           => 'centreon',
        'db_passwd'         => 'password',
        'db_type'           => 'mysql'
    }
}
