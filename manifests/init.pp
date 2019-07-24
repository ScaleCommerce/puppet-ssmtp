# @summary This module manage local ssmtp installation
#
# @param default_mta Boolean, if set to ssmtp, ssmtp will be set as default mta
# @param root_email Mail address that get root mails
# @param mail_hub Server that is used for outgoing mail
# @param from_line_override Allow mail client to override from line (default=YES)
# @param revaliases Array of reverse aliases
# @param hostname Override ssmtp.conf parameter, see man 5 ssmtp.conf
# @param rewritedomain Override ssmtp.conf parameter, see man 5 ssmtp.conf
# @param authuser Override ssmtp.conf parameter, see man 5 ssmtp.conf
# @param authpass Override ssmtp.conf parameter, see man 5 ssmtp.conf
# @param authmethod Override ssmtp.conf parameter, see man 5 ssmtp.conf
# @param tlscert Override ssmtp.conf parameter, see man 5 ssmtp.conf
# @param tlskey Override ssmtp.conf parameter, see man 5 ssmtp.conf
# @param authuser Override ssmtp.conf parameter, see man 5 ssmtp.conf
# @param tlscafile Override ssmtp.conf parameter, see man 5 ssmtp.conf
# @param tlscadir Override ssmtp.conf parameter, see man 5 ssmtp.conf
# @param usetls Override ssmtp.conf parameter, see man 5 ssmtp.conf
# @param usestarttls Override ssmtp.conf parameter, see man 5 ssmtp.conf
# @param ssmtp_conf_mode Override ssmtp.conf parameter, see man 5 ssmtp.conf
# @param ssmtp_conf_owner Override ssmtp.conf parameter, see man 5 ssmtp.conf
# @param ssmtp_conf_group Override ssmtp.conf parameter, see man 5 ssmtp.conf
# @param revaliases_conf_mode Override ssmtp.conf parameter, see man 5 ssmtp.conf
# @param revaliases_conf_owner Override ssmtp.conf parameter, see man 5 ssmtp.conf
# @param revaliases_conf_group Override ssmtp.conf parameter, see man 5 ssmtp.conf
#
# @example Declaring the class
#    class { '::ssmtp':
#      mail_hub   => 'mail.example.local',
#      root_email => 'john.doe@example.local',
#    }
#
class sc_ssmtp (
  $default_mta           = $sc_ssmtp::params::default_mta,
  $root_email            = $sc_ssmtp::params::root_email,
  $mail_hub              = $sc_ssmtp::params::mail_hub,
  $revaliases            = $sc_ssmtp::params::revaliases,
  $from_line_override    = $sc_ssmtp::params::from_line_override,
  $hostname              = undef,
  $rewritedomain         = undef,
  $authuser              = undef,
  $authpass              = undef,
  $authmethod            = undef,
  $usetls                = undef,
  $usestarttls           = undef,
  $tlscert               = undef,
  $tlskey                = undef,
  $tlscafile             = undef,
  $tlscadir              = undef,
  $package               = false,
  $ssmtp_conf_mode       = $sc_ssmtp::params::ssmtp_conf_mode,
  $ssmtp_conf_owner      = $sc_ssmtp::params::ssmtp_conf_owner,
  $ssmtp_conf_group      = $sc_ssmtp::params::ssmtp_conf_group,
  $revaliases_conf_mode  = $sc_ssmtp::params::revaliases_conf_mode,
  $revaliases_conf_owner = $sc_ssmtp::params::revaliases_conf_owner,
  $revaliases_conf_group = $sc_ssmtp::params::revaliases_conf_group
) inherits sc_ssmtp::params {

  # Start workflow
  if $sc_ssmtp::params::supported {
    if $package {
      class{ '::sc_ssmtp::package': }
    }
    -> class{ '::sc_ssmtp::config': }
    -> class{ '::sc_ssmtp::service': }
    -> Class['sc_ssmtp']
  }
  else {
    warning('The current operating system is not supported!')
  }
}
