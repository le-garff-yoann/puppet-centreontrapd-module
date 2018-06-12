class { '::centreontrapd' :
    isPoller => '1',
    dbType => 'SQLite',
    centreonDb => 'dbname=/etc/snmp/centreon_traps/centreontrapd.sdb',
    centstorageDb => 'dbname=/etc/snmp/centreon_traps/centreontrapd.sdb'
}