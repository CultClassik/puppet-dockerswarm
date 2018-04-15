# cult_dockerswarm::mounts
#
# Configures fstab mounts required by a Docker Swarm cluster.
#
# @summary A short summary of the purpose of this class
#
# @example
#   include cult_dockerswarm::mounts
class cult_dockerswarm::mounts (
  Hash $shares,
){

  $shares.each |String $name, Hash $share| {
    file { $share['target'] :
      ensure => directory,
    }

    file_line { "fstab entry for ${name}" :
      ensure             => present,
      path               => '/etc/fstab',
      line               => "${$share['source']} ${$share['target']} ${$share['type']} ${$share['opts']}",
      notify             => Exec['Re-mount File Systems'],
      append_on_no_match => true,
    }
  }

  exec { 'Re-mount File Systems' :
    command     => '/bin/mount -a',
    refreshonly => true,
  }

}
