Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin', '/usr/local/bin']
}

stage { 'pre':
  before => Stage['main']
}

stage { 'post':
  require => Stage['main'],
}

