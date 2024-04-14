{ pkgs, lib, config, callPackage, ... }:
environment.systemPackages = with pkgs; [
  (st.overrideAttrs (oldAttrs: rec { src = ./st-0.9.2; }))
];

