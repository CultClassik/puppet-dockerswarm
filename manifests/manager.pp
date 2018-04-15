# cult_dockerswarm::manager
#
# Configures a node as a DOcker Swarm cluster manager.
#
# @summary A short summary of the purpose of this class
#
# @example
#   include cult_dockerswarm::manager
class cult_dockerswarm::manager (
  String $ip_address = $facts['ipaddress'],
){
  if $::cult_dockerswarm::is_manager == true {
    include cult_dockerswarm::networks

    docker::swarm { "${facts['hostname']}-swarm-node" :
      join           => true,
      advertise_addr => $ip_address,
      listen_addr    => $ip_address,
      manager_ip     => "${::cult_dockerswarm::leader_ip}:${::cult_dockerswarm::leader_port}",
      token          => $::cult_dockerswarm::manager_token,
    }
    -> Class['::cult_dockerswarm::networks']
  }
}
