# centreontrapd

This module configure :
* */etc/centreon/conf.pm*.
* */etc/centreon/centreontrapd.pm*.
* Services associated with these two files.

## Examples

```puppet
class { '::centreontrapd':
    isPoller    => true, # if unspecified, $::centreon_poller will try to determinate if the node is a poller or not
    dbHost      => '<IP_DBMS>:<port_DBMS>',
    dbUser      => '<user_DBMS>',
    dbPasswd    => '<password_DBMS>'
}
```
