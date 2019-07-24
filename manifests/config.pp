# @summary This class contain the configuration for ssmtp module
# @example include ssmtp::config
#
class sc_ssmtp::config {
  # make parameters available in local scope for usage in templates
  $default_mta           = $sc_ssmtp::default_mta
  $root_email            = $sc_ssmtp::root_email
  $mail_hub              = $sc_ssmtp::mail_hub
  $revaliases            = $sc_ssmtp::revaliases
  $from_line_override    = $sc_ssmtp::from_line_override
  $hostname              = $sc_ssmtp::hostname
  $rewritedomain         = $sc_ssmtp::rewritedomain
  $authuser              = $sc_ssmtp::authuser
  $authpass              = $sc_ssmtp::authpass
  $authmethod            = $sc_ssmtp::authmethod
  $usetls                = $sc_ssmtp::usetls
  $usestarttls           = $sc_ssmtp::usestarttls
  $tlscert               = $sc_ssmtp::tlscert
  $tlskey                = $sc_ssmtp::tlskey
  $tlscafile             = $sc_ssmtp::tlscafile
  $tlscadir              = $sc_ssmtp::tlscadir
  $ssmtp_conf_mode       = $sc_ssmtp::ssmtp_conf_mode
  $ssmtp_conf_owner      = $sc_ssmtp::ssmtp_conf_owner
  $ssmtp_conf_group      = $sc_ssmtp::ssmtp_conf_group
  $revaliases_conf_mode  = $sc_ssmtp::revaliases_conf_mode
  $revaliases_conf_owner = $sc_ssmtp::revaliases_conf_owner
  $revaliases_conf_group = $sc_ssmtp::revaliases_conf_group

  # sSMTP configuration
  file {
    $sc_ssmtp::params::config_ssmtp_conf:
      ensure  => file,
      mode    => $ssmtp_conf_mode,
      owner   => $ssmtp_conf_owner,
      group   => $ssmtp_conf_group,
      path    => $sc_ssmtp::params::config_ssmtp_conf,
      content => template($sc_ssmtp::params::config_ssmtp_conf_template);

    $sc_ssmtp::params::config_revaliases_conf:
      ensure  => file,
      mode    => $revaliases_conf_mode,
      owner   => $revaliases_conf_owner,
      group   => $revaliases_conf_group,
      path    => $sc_ssmtp::params::config_revaliases_conf,
      content => template($sc_ssmtp::params::config_revaliases_conf_template);
  }
}
