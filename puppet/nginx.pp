package { "nginx":
    ensure => installed
}

service { "nginx":
    require => Package["nginx"],
    ensure => running,
    enable => true
}

file { "/etc/nginx/nginx.conf":
    ensure => present,
    source => "file:///tmp/cloudformation/puppet/files/nginx.conf",
    notify => Service["nginx"]
}

file { "/etc/nginx/server.key":
    ensure => present,
    source => "file:///tmp/cloudformation/puppet/files/server.key",
    notify => Service["nginx"]
}

file { "/etc/nginx/server.crt":
    ensure => present,
    source => "file:///tmp/cloudformation/puppet/files/server.crt",
    notify => Service["nginx"]
}

file{ "/usr/share/nginx/html/index.html":
    ensure => present,
    source => "/var/lib/cloud/data/instance-id",
    require => Package["nginx"],
}
