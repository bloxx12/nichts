{
  lib,
  stdenv,
  fetchFromGitHub,
  kernelPatches,
  buildLinux,
  variant,
  ...
}: let
  version = "6.11.3";
  hash = "sha256-Pb/7XToBFZstI1DFgWg4a2HiRuSzA9rEsMBLb6fRvYc=";

  xanmod_blox = buildLinux rec {
    inherit version;
    pname = "linux-xanmod";
    modDirVersion = lib.versions.pad 3 "${version}-blox";

    src = fetchFromGitHub {
      owner = "xanmod";
      repo = "linux";
      rev = modDirVersion;
      inherit hash;
    };
    kernelPatches = [
      kernelPatches.bridge_stp_helper
      kernelPatches.request_key_helper
    ];

    enableCommonConfig = true;

    # Default Xanmod options
    structuredExtraConfig = with lib.kernel; {
      # CPUFreq governor Performance
      CPU_FREQ_DEFAULT_GOV_PERFORMANCE = lib.mkOverride 60 yes;
      CPU_FREQ_DEFAULT_GOV_SCHEDUTIL = lib.mkOverride 60 no;

      # Full preemption
      PREEMPT = lib.mkOverride 60 yes;
      PREEMPT_VOLUNTARY = lib.mkOverride 60 no;

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
  };
in
  xanmod_blox
