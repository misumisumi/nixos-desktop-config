{ pkgs, user, ... }:
{
  environment.systemPackages = with pkgs; [
    rdma-core # For infiniband
  ];
}
