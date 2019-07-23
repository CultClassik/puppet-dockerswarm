# cult_dockerswarm::networks
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include cult_dockerswarm::networks
class cult_dockerswarm::networks (
  Hash $networks,
){

  if $networks != Undef {
    $networks.each |String $name, Hash $network| {
      docker_network { $name :
        ensure  => $network['ensure'],
        driver  => $network['driver'],
        options => $network['options'],
      }
    }
  }

}
