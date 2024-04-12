{ config, inputs, pkgs, ... }:
{
  myOptions = {
      other = {
          system = {
              hostname = "kronos";
              username = "lars";
          };
      };
  };
}
