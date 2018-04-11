package { "nginx":
    ensure => installed
}

service { "nginx":
    require => Package["nginx"],
    ensure => running,
    enable => true
}


$files = [ 'nginx.conf', 'server.key', 'server.crt' ]


file { "/etc/nginx/${files}":
    require => Package["nginx"],
    ensure => present,
    source => "file:///tmp/cloudformation/puppet/files/${files}",
    notify => Service["nginx"]
}


#file { "/etc/nginx/nginx.conf":
#    require => Package["nginx"],
#    ensure => present,
#    source => "file:///tmp/cloudformation/puppet/files/nginx.conf",
#    notify => Service["nginx"]
#}

#file { "/etc/nginx/server.key":
#    require => Package["nginx"],
#    ensure => present,
#    source => "file:///tmp/cloudformation/puppet/files/server.key",
#    notify => Service["nginx"]
#}

#file { "/etc/nginx/server.crt":
#    require => Package["nginx"],
#    ensure => present,
#    source => "file:///tmp/cloudformation/puppet/files/server.crt",
#    notify => Service["nginx"]
#}




file{ "/usr/share/nginx/html/index.html":
    ensure => present,
    source => "/var/lib/cloud/data/instance-id",
    require => Package["nginx"],
}


file{ "/usr/share/nginx/html/404.html":
    ensure => present,
    source => "file:///tmp/cloudformation/puppet/files/404.html",
    require => Package["nginx"],
}
