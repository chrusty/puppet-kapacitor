# == Class: kapacitor::service
#
# Manage the Kapacitor service:
#
class kapacitor::service {
  $service_ensure = $::kapacitor::ensure
  case $service_ensure {
    true: {
      $my_service_ensure = 'running'
    }
    false: {
      $my_service_ensure = 'stopped'
    }
    'absent','purged': {
      $my_service_ensure = 'stopped'
    }
    'ensure','present','installed': {
      $my_service_ensure = 'running'
    }
    default: {
      $my_service_ensure = 'running'
    }
  }

  # use systemd for Debian jessie
  case $::lsbdistcodename {
    'jessie': {
      $provider = 'systemd'
    }
    default: {
      $provider = undef
    }
  }

  service { 'kapacitor':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    provider   => $provider,
  }
}
