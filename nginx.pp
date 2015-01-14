class { 'nginx': }

nginx::resource::upstream { 'puppet_nginx':
  members => [
    'localhost:8888',
  ],
}

nginx::resource::vhost { 'puppet_nginx':
  proxy => 'https://github.com/nwea-techops/tech_quiz',
  ssl => true,
  ssl_only => true,
  listen_port => 443,
}
