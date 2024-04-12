{ config, inputs, pkgs, ... }:
{
  myOptions = {
      other = {
          system = {
              hostname = "dyonisos";
              username = "lars";
          };
      };
  };
}
