# cult_dockerswarm::leader
#
# Configures a node as the Docker Swarm cluster leader.
#
# @summary A short summary of the purpose of this class
#
# @example
#   include cult_dockerswarm::leader
class cult_dockerswarm::leader (
  String $ip_address = $facts['ipaddress'],
){
  if $::cult_dockerswarm::is_leader == true {

    include cult_dockerswarm::networks

    docker::swarm { "${facts['hostname']}-swarm-node" :
      advertise_addr => $ip_address,
      listen_addr    => $ip_address,
    }

    -> Class['::cult_dockerswarm::networks']

  }
}
