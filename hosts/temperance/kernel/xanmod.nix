{
  lib,
  fetchFromGitHub,
  buildLinux,
  kernelPatches,
  ...
}: let
  pname = "linux-xanmod";
  version = "6.11.5";
  vendorSuffix = "xanmod1";
  modDirVersion = lib.versions.pad 3 "${version}-blox";

  inherit (lib.modules) mkForce mkOverride;
  inherit (lib.kernel) freeform yes no;
  xanmod_blox =
    (buildLinux {
      inherit pname version modDirVersion;

      src = fetchFromGitHub {
        owner = "xanmod";
        repo = "linux";
        rev = "refs/tags/${version}-${vendorSuffix}";
        hash = "sha256-G4u0LQtIeJ0dNAmjNH0OKihmbkivYVbrbXDB9vPw2xI=";
      };

      kernelPatches = [
        kernelPatches.bridge_stp_helper
        kernelPatches.request_key_helper
      ];

      enableCommonConfig = true;
      # Default Xanmod options
      structuredExtraConfig = {
        # CPUFreq governor Performance
        CPU_FREQ_DEFAULT_GOV_PERFORMANCE = mkOverride 60 yes;
        CPU_FREQ_DEFAULT_GOV_SCHEDUTIL = mkOverride 60 no;

        # Full preemption
        PREEMPT = mkOverride 60 yes;
        PREEMPT_VOLUNTARY = mkOverride 60 no;

        # Google's BBRv3 TCP congestion Control
        TCP_CONG_BBR = yes;
        DEFAULT_BBR = yes;

        # Preemptive Full Tickless Kernel at 250Hz
        HZ = freeform "250";
        HZ_250 = yes;
        HZ_1000 = no;

        # RCU_BOOST and RCU_EXP_KTHREAD
        RCU_EXPERT = yes;
        RCU_FANOUT = freeform "64";
        RCU_FANOUT_LEAF = freeform "16";
        RCU_BOOST = yes;
        RCU_BOOST_DELAY = freeform "0";
        RCU_EXP_KTHREAD = yes;
      };
    })
    # 1:1 taken from raf's custom kernel, check out his config for this.
    .overrideAttrs (oa: {
      prePatch =
        (oa.prePatch or "")
        + ''
          # bragging rights
          echo "Replacing localversion with custom suffix"
          substituteInPlace localversion \
            --replace-fail "xanmod1" "blox"
        '';
    });
in {
  inherit
    xanmod_blox
    ;
}
