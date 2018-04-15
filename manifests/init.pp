# cult_dockerswarm
#
# Creates and configures a Docker Swarm cluster.
#
# @summary A short summary of the purpose of this class
#
# @example
#   include cult_dockerswarm
class cult_dockerswarm (
  String $leader_ip = 'undef',
  String $leader_port = '2377',
  Boolean $is_leader = false,
  Boolean $is_manager = false,
  String $manager_token = 'undef',
  String $worker_token = 'undef',
){

  require docker
  require ::cult_dockerswarm::mounts

  if $::cult_dockerswarm::is_leader = true {
    include ::cult_dockerswarm::leader
  } else {
    include ::cult_dockerswarm::worker
  }

}
