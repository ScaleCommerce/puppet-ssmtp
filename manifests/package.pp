# @summary This class contain the packages for ssmtp module
# @example include ssmtp::package
#
class sc_ssmtp::package {
  package { $sc_ssmtp::params::package_ssmtp: ensure => installed; }
}
