# == Class: selenium::server
#
# simple template
#
#
# === Examples
#
# include selenium::server
#
#
# === Authors
#
# Joshua Hoblitt <jhoblitt@cpan.org>
#
#
class selenium::server(
  $display      = $selenium::params::display,
  $options      = $selenium::params::server_options,
) inherits selenium::params {
  validate_string($display)
  validate_string($options)

  include selenium

  Class[ 'selenium' ] ->
  selenium::config{ 'server':
    display      => $display,
    user         => $selenium::user,
    group        => $selenium::group,
    install_root => $selenium::install_root,
    options      => $options,
    java         => $selenium::java,
  } ->
  service { 'seleniumserver':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
  } ->
  Class[ 'selenium::server' ]

}
