# these parameters need to be accessed from several locations and
# should be considered to be constant
class horizon::params {

  $logdir       = '/var/log/horizon'
  $http_service = 'httpd'

  case $::osfamily {
    'RedHat': {
      $http_modwsgi                = 'mod_wsgi'
      $package_name                = 'openstack-dashboard'
      $config_file                 = '/etc/openstack-dashboard/local_settings'
      $httpd_config_file           = '/etc/httpd/conf.d/openstack-dashboard.conf'
      $httpd_listen_config_file    = '/etc/httpd/conf/httpd.conf'
      $root_url                    = '/dashboard'
      $apache_user                 = 'apache'
      $apache_group                = 'apache'
    }
    'Debian': {
      $config_file                 = '/etc/openstack-dashboard/local_settings.py'
      $httpd_config_file           = '/etc/apache2/conf.d/openstack-dashboard.conf'
      $httpd_listen_config_file    = '/etc/apache2/ports.conf'
      $root_url                    = '/horizon'
      $apache_user                 = 'www-data'
      $apache_group                = 'www-data'
      case $::operatingsystem {
        'Debian': {
            $package_name          = 'openstack-dashboard-apache'
        }
        default: {
            $package_name          = 'openstack-dashboard'
        }
      }
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only support osfamily RedHat and Debian")
    }
  }
}
