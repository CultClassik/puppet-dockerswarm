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
  if $::cult_dockerswarm::is_worker == true {
    docker::swarm { "${facts['hostname']}-swarm-node" :
      join           => true,
      advertise_addr => $ip_address,
      listen_addr    => $ip_address,
      manager_ip     => "${::cult_dockerswarm::leader_ip}:${::cult_dockerswarm::leader_port}",
      token          => $::cult_dockerswarm::worker_token,
    }
  }
}
