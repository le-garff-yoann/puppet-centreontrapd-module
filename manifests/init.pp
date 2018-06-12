class centreontrapd (
    Boolean                                 $isPoller =             $centreontrapd::params::isPoller,
    String                                  $logPath =              $centreontrapd::params::sysconfigDefault['--logfile'],
    Enum['none', 'error', 'info', 'debug']  $logSeverity =          $centreontrapd::params::sysconfigDefault['--severity'],
    String                                  $confPath =             $centreontrapd::params::config['conf_path'],
    String                                  $centreontrapdPath =    $centreontrapd::params::config['centreontrapd_path'],
    String                                  $filesOwner =           $centreontrapd::params::config['owner'],
    String                                  $filesGroup =           $centreontrapd::params::config['group'],
    Pattern[/^[0-7][0-7][0-7]$/]            $filesMode =            $centreontrapd::params::config['mode'],
    String                                  $varLib =               $centreontrapd::params::centreonConfig['VarLib'],
    String                                  $centreonDir =          $centreontrapd::params::centreonConfig['CentreonDir'],
    String                                  $centreonDb =           $centreontrapd::params::centreonConfig['centreon_db'],
    String                                  $centstorageDb =        $centreontrapd::params::centreonConfig['centstorage_db'],
    Variant[String, Undef]                  $dbHost =               $centreontrapd::params::centreonConfig['db_host'],
    Variant[String, Undef]                  $dbUser =               $centreontrapd::params::centreonConfig['db_user'],
    Variant[String, Undef]                  $dbPasswd =             $centreontrapd::params::centreonConfig['db_passwd'],
    Enum['mysql', 'SQLite']                 $dbType =               $centreontrapd::params::centreonConfig['db_type']
) inherits centreontrapd::params {
    validate_absolute_path($logPath, $confPath, $centreontrapdPath, $varLib, $centreonDir)

    $confPathDirName = dirname($confPath)
    $centreontrapdPathDirName = dirname($centreontrapdPath)

    file { $confPathDirName:
        ensure  => 'directory',
        owner   => $filesOwner,
        group   => $filesGroup,
        before  => [File[$confPath], File[$centreontrapdPath]]
    }

    if $confPathDirName != $centreontrapdPathDirName {
        file { $centreontrapdPathDirName:
            ensure      => 'directory',
            owner       => $filesOwner,
            group       => $filesGroup,
            before      => [File[$confPath], File[$centreontrapdPath]]
        }
    }

    file { $sysconfigFile:
        ensure      => 'file',
        mode        => '755',
        content     => template('centreontrapd/centreontrapd.syslog.erb'),
        before      => [File[$confPath], File[$centreontrapdPath]]
    }

    file { $confPath:
        ensure      => 'file',
        owner       => $filesOwner,
        group       => $filesGroup,
        mode        => $filesMode,
        content     => template('centreontrapd/conf.pm.erb')
    }

    file { $centreontrapdPath:
        ensure      => 'file',
        owner       => $filesOwner,
        group       => $filesGroup,
        mode        => $filesMode,
        content     => template('centreontrapd/centreontrapd.pm.erb')
    }

    service { $serviceName:
        ensure      => 'running',
        hasrestart  => true,
        subscribe   => [File[$confPath], File[$centreontrapdPath]]
    }
}
