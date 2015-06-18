class timezone {

    file { "/etc/timezone":
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => 0644,
        source  => "puppet:///modules/timezone/timezone",
    }

    package { ["rdate"]:
        ensure => present,
    }

    exec { "data-time-setup":
        command => "/usr/bin/rdate -s ntp.fu-berlin.de >/dev/null 2>&1",
        require => [
            File['/etc/timezone'],
            Package['rdate'],
        ],
    }

    exec { "rsyslog-restart":
        command => "service rsyslog restart",
        require => [
            File['/etc/timezone'],
            Exec['data-time-setup'],
        ],
    }


    cron { "rdate":
        command => "/usr/bin/rdate -s ntp.fu-berlin.de >/dev/null 2>&1",
        user => "root",
        hour => [8, 10, 12, 14],
        minute => 5,
        ensure => present,
        require => Package['rdate'],
    }
}

