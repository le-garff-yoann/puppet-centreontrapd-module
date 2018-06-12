class { '::centreontrapd':
    dbType => 'SQLite',
    centreonDb => 'dbname=/etc/snmp/centreon_traps/centreontrapd.sdb',
    centstorageDb => 'dbname=/etc/snmp/centreon_traps/centreontrapd.sdb'
}
