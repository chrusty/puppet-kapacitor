# == Class: kapacitor::package
#
# Manage the Kapacitor package:
#
class kapacitor::package {
  $package_ensure = $::kapacitor::ensure
  case $package_ensure {
    true:     {
      $my_package_ensure = 'present'
    }
    false:    {
      $my_package_ensure = 'absent'
    }
    default:  {
      $my_package_ensure = $package_ensure
    }
  }

  if ((!$::kapacitor::install_from_repository) and ($my_package_ensure =~ /present|installed|latest/ )) {
    # package source and provider
    case $::osfamily {
      'debian': {
        $package_source_name = $::architecture ? {
          /386/   => "kapacitor_${::kapacitor::version}_i386.deb",
          default => "kapacitor_${::kapacitor::version}_amd64.deb",
        }
        $package_source = "http://get.influxdb.org/kapacitor/${package_source_name}"
        wget::fetch { 'kapacitor':
          source      => $package_source,
          destination => "/tmp/${package_source_name}"
        }
        package { 'kapacitor':
          ensure   => $my_package_ensure,
          provider => 'dpkg',
          source   => "/tmp/${package_source_name}",
          require  => Wget::Fetch['kapacitor'],
        }
      }
      'redhat': {
        $package_source_name = $::architecture ? {
          /386/   => "kapacitor-${::kapacitor::version}-1.i686.rpm",
          default => "kapacitor-${::kapacitor::version}-1.x86_64.rpm",
        }
        $package_source = "http://get.influxdb.org/kapacitor/${package_source_name}"
        exec {
          'kapacitor_rpm':
            command => "rpm -ivh ${package_source}",
            path    => ['/bin', '/usr/bin'],
            unless  => 'rpm -qa | grep kapacitor';

          'kapacitor_from_web':
            command => "echo Installed ${package_source_name} on `date --rfc-2822` > /opt/kapacitor/versions/kapacitor_from_web",
            path    => ['/bin', '/usr/bin'],
            require => [ Exec['kapacitor_rpm'] ];
        }
      }
      default: {
        fail("OS family ${::osfamily} not supported")
      }
    }
  }
  else {
    # install / purge the package
    package { 'kapacitor':
      ensure => $package_ensure,
    }
  }
}
