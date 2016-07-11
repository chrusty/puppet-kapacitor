# == Define: kapacitor::task::define
#
# Defines a task from a tick-script:
#
define kapacitor::task::define(
  $enabled          = true,
  $influx_database  = 'telegraf',
  $influx_retention = 'default',
  $task_type        = 'stream',
  $tickfile_content = undef,
) {

  # Generate a name for the tick-file:
  $tick_file = "${::kapacitor::conf_tick_directory}/${name}.tick"
  $disable_file = "${tick_file}.disabled"

  # Only do this if we want the task enabled:
  if $enabled {

    # Remove the disable file (in case we've previously disabled this task):
    file { $disable_file:
        ensure => 'absent',
        purge  => true,
        force  => true,
        notify => Exec["kapacitor-task-define-${name}"]
    }

    # Make a tick-file for the task:
    file { $tick_file:
      ensure  => file,
      content => $tickfile_content,
      mode    => '0444',
      owner   => 'root',
      group   => 'kapacitor',
      require => Class['kapacitor'],
      notify  => Exec["kapacitor-task-define-${name}"]
    }

    # Define the task:
    exec { "kapacitor-task-define-${name}":
      command     => "/usr/bin/kapacitor define ${name} -type=${task_type} -tick=${tick_file} -dbrp=${influx_database}.${influx_retention}",
      refreshonly => true,
      notify      => Exec["kapacitor-task-enable-${name}"]
    }

    # Enable the task:
    exec { "kapacitor-task-enable-${name}":
      command     => "/usr/bin/kapacitor enable ${name}",
      refreshonly => true,
      notify      => Exec["kapacitor-task-reload-${name}"]
    }

    # Re-load the task (in case a task has been re-defined):
    exec { "kapacitor-task-reload-${name}":
      command     => "/usr/bin/kapacitor reload ${name}",
      refreshonly => true
    }

  } else {

    # Disable the task:
    exec { "kapacitor-task-disable-${name}":
      command     => "/usr/bin/kapacitor disable ${name} && touch ${disable_file}",
      creates     => $disable_file
    }

  }

}
