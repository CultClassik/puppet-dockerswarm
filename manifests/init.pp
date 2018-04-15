# cult_dockerswarm
#
# Creates and configures a Docker Swarm cluster.
#
# @summary A short summary of the purpose of this class
#
# @example
#   include cult_dockerswarm
class cult_dockerswarm (
  String $leader_ip,
  String $leader_port = '2377',
  Boolean $is_leader = false,
  Boolean $is_manager = false,
  Boolean $is_worker = false,
  String $manager_token = 'undef',
  String $worker_token = 'undef',
  String $storage_base_path = 'undef',
){

  require docker

  contain ::cult_dockerswarm::mounts
  contain ::cult_dockerswarm::networks
  contain ::cult_dockerswarm::leader
  contain ::cult_dockerswarm::manager
  contain ::cult_dockerswarm::worker

  Class['::cult_dockerswarm::leader']
  -> Class['::cult_dockerswarm::manager']
  -> Class['::cult_dockerswarm::worker']
  -> Class['::cult_dockerswarm::mounts']

}
