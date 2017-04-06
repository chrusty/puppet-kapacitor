# == Class: kapacitor
#
# Manage InfluxDatas Kapacitor:
#
class kapacitor (
  $conf_file                         = '/etc/kapacitor/kapacitor.conf',
  $conf_tick_directory               = '/etc/kapacitor/ticks',
  $config_data_dir                   = '/var/lib/kapacitor',
  $config_hostname                   = 'localhost',
  $config_http_bind_address          = ':9092',
  $config_http_log_enabled           = true,
  $config_influxdb_name              = 'localhost',
  $config_influxdb_password          = '',
  $config_influxdb_urls              = ['http://localhost:8086'],
  $config_influxdb_username          = '',
  $config_logging_file               = '/var/log/kapacitor/kapacitor.log',
  $config_logging_level              = 'INFO',
  $config_replay_dir                 = '/var/lib/kapacitor/replay',
  $config_tasks_dir                  = '/var/lib/kapacitor/tasks',
  $config_smtp_enabled               = false,
  $config_smtp_host                  = 'localhost',
  $config_smtp_port                  = 25,
  $config_smtp_username              = '',
  $config_smtp_password              = '',
  $config_smtp_from                  = 'kapactor@domain.com',
  $config_smtp_global                = false,
  $config_smtp_state_changes_only    = true,
  $config_pagerduty_enabled          = false,
  $config_pagerduty_service_key      = '',
  $config_pagerduty_url              = 'https://events.pagerduty.com/generic/2010-04-15/create_event.json',
  $config_pagerduty_global           = false,
  $config_slack_enabled              = false,
  $config_slack_url                  = '',
  $config_slack_channel              = '',
  $config_slack_global               = false,
  $config_slack_state_changes_only   = false,
  $config_storage_boltdb             = '/var/lib/kapacitor/kapacitor.db',
  $config_hipchat_enabled            = false,
  $config_hipchat_url                = 'https://something.hipchat.com/v2/room',
  $config_hipchat_room               = 'Name of room',
  $config_hipchat_token              = '',
  $config_hipchat_global             = false,
  $config_hipchat_state_changes_only = false,
  $ensure                            = 'installed',
  $install_from_repository           = false,
  $version                           = '1.0.0',
) {

  class { '::kapacitor::package': } ~>
  class { '::kapacitor::config': }  ~>
  class { '::kapacitor::service': } ~>
  Class['kapacitor']

}
