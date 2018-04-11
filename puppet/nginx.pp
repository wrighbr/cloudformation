package { "nginx":
    ensure => installed
}

service { "nginx":
    require => Package["nginx"],
    ensure => running,
    enable => true
}


file { "/etc/nginx/":
    require => Package["nginx"],
    ensure => directory,
    recurse => true,
    source => "file:///tmp/cloudformation/puppet/files/nginx/",
    notify => Service["nginx"]
}

file{ "/usr/share/nginx/html/index.html":
    ensure => present,
    source => "/var/lib/cloud/data/instance-id",
    require => Package["nginx"],
}


file{ "/usr/share/nginx/html/":
    ensure => directory,
    recurse => true,
    source => "file:///tmp/cloudformation/puppet/files/error/",
    require => Package["nginx"],
}
