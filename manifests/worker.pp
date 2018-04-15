# cult_dockerswarm::worker
#
# Configures a node as a Docker Swarm cluster worker.
#
# @summary A short summary of the purpose of this class
#
# @example
#   include cult_dockerswarm::worker
class cult_dockerswarm::worker (
  String $ip_address = $facts['ipaddress'],
){

  $token = $::cult_dockerswarm::is_manager ? {
    true  => $::cult_dockerswarm::manager_token,
    false => $::cult_dockerswarm::worker_token,
  }
  
  docker::swarm { "${facts['hostname']}-swarm-node" :
    join           => true,
    advertise_addr => $ip_address,
    listen_addr    => $ip_address,
    manager_ip     => "${::cult_dockerswarm::leader_ip}:${::cult_dockerswarm::leader_port}",
     token          => $token,
  }

  if $::cult_dockerswarm::is_manager == true {
    include ::cult_dockerswarm::networks
  }

}
