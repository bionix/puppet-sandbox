# Puppet module grml
#
# A presentation module for the FrOSCon2013 (St. Augustin, Germany).
#
#
class grml ( $ensure = 'present' ) {
  # install zsh package
  package { 'zsh':
    ensure        => $ensure
  }
  file { '/home/grml':
    ensure        => directory,
    mode          => '0777'
  }
  user { 'grml':
    ensure        => $ensure,
    uid           => '7777',
    gid           => '7777',
    home          => '/home/grml',
    comment       => 'Pseudo User grml',
    password      => '$6$WHcAHiUR$Fk3NxjGOe/ykbP9zj5YwiDVC/j/DXlS7zKwQ5GEfJG47kONuoRWa6NrY7nxw6GENcSjw1AhrxmBeiXsOwKk6r/',
    shell         => '/bin/zsh',
    require       => Package['zsh'],
  }
  group { 'grml':
    ensure        => $ensure,
    gid           => '7777',
  }
  file { '/home/grml/.zshrc':
    ensure       => $ensure,
    source       => 'puppet:///modules/grml/zshrc',
    owner        => 'grml',
    group        => 'grml',
    mode         => '0444'
  }
  File['/home/grml'] ~> Group['grml'] ~> User['grml'] ~> File['/home/grml/.zshrc']
}