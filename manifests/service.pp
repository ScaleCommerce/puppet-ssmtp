# @summary This class contain the services for ssmtp module
# @example include ssmtp::service
#
class sc_ssmtp::service {
  # sSMTP service configuration
  if $ssmtp::default_mta == 'ssmtp' {
    if $::osfamily == 'RedHat' {
      exec { 'alternatives --set mta /usr/sbin/sendmail.ssmtp':
        path   => '/bin:/sbin:/usr/bin:/usr/sbin',
        unless => 'test /etc/alternatives/mta -ef /usr/sbin/sendmail.ssmtp',
      }
    }
    if $::osfamily == 'FreeBSD' {
      file {
        $sc_ssmtp::params::config_mailer_conf:
          ensure  => file,
          mode    => $ssmtp::mailer_conf_mode,
          owner   => $ssmtp::mailer_conf_owner,
          group   => $ssmtp::mailer_conf_group,
          path    => $ssmtp::params::config_mailer_conf,
          content => template($sc_ssmtp::params::config_mailer_conf_template);
      }
    }
  }
}
