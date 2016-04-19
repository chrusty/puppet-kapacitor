# == Class: kapacitor::config
#
class kapacitor::config(
  $config_data_dir                   = $::kapacitor::config_data_dir,
  $config_hostname                   = $::kapacitor::config_hostname,
  $config_http_bind_address          = $::kapacitor::config_http_bind_address,
  $config_influxdb_name              = $::kapacitor::config_influxdb_name,
  $config_influxdb_password          = $::kapacitor::config_influxdb_password,
  $config_influxdb_urls              = $::kapacitor::config_influxdb_urls,
  $config_influxdb_username          = $::kapacitor::config_influxdb_username,
  $config_logging_file               = $::kapacitor::config_logging_file,
  $config_logging_level              = $::kapacitor::config_logging_level,
  $config_replay_dir                 = $::kapacitor::config_replay_dir,
  $config_tasks_dir                  = $::kapacitor::config_tasks_dir,
  $config_smtp_enabled               = $::kapacitor::config_smtp_enabled,
  $config_smtp_host                  = $::kapacitor::config_smtp_host,
  $config_smtp_port                  = $::kapacitor::config_smtp_port,
  $config_smtp_username              = $::kapacitor::config_smtp_username,
  $config_smtp_password              = $::kapacitor::config_smtp_password,
  $config_smtp_from                  = $::kapacitor::config_smtp_from,
  $config_smtp_global                = $::kapacitor::config_smtp_global,
  $config_smtp_state_changes_only    = $::kapacitor::config_smtp_state_changes_only,
  $config_pagerduty_enabled          = $::kapacitor::config_pagerduty_enabled,
  $config_pagerduty_service_key      = $::kapacitor::config_pagerduty_service_key,
  $config_pagerduty_url              = $::kapacitor::config_pagerduty_url,
  $config_pagerduty_global           = $::kapacitor::config_pagerduty_global,
  $config_slack_enabled              = $::kapacitor::config_slack_enabled,
  $config_slack_url                  = $::kapacitor::config_slack_url,
  $config_slack_channel              = $::kapacitor::config_slack_channel,
  $config_slack_global               = $::kapacitor::config_slack_global,
  $config_slack_state_changes_only   = $::kapacitor::config_slack_state_changes_only,
  $config_hipchat_enabled            = $::kapacitor::config_hipchat_enabled,
  $config_hipchat_url                = $::kapacitor::config_hipchat_url,
  $config_hipchat_room               = $::kapacitor::config_hipchat_room,
  $config_hipchat_token              = $::kapacitor::config_hipchat_token,
  $config_hipchat_global             = $::kapacitor::config_hipchat_global,
  $config_hipchat_state_changes_only = $::kapacitor::config_hipchat_state_changes_only
) {

  # The main Kapacitor config file:
  file { $::kapacitor::conf_file:
    ensure  => file,
    content => template('kapacitor/kapacitor.conf.erb'),
    mode    => '0444',
    owner   => 'root',
    group   => 'kapacitor',
  }

  # The directory for tick files:
  file { $::kapacitor::conf_tick_directory:
    ensure => directory,
    mode   => '0755',
    owner  => 'root',
    group  => 'kapacitor',
  }

}
