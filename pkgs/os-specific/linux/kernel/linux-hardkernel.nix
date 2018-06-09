{ stdenv, buildPackages, hostPlatform, fetchurl, perl, buildLinux, libelf, utillinux, ... } @ args:

buildLinux (args // rec {
  version = "4.14.47-139";
  modDirVersion = "4.14.47";
# extraMeta.branch = "4.1";

#  src = fetchFromGitHub {
#    owner = "hardkernel";
#    repo ="linux";
#   rev = "a54f259c2adce68e3bd7600be8989bf1ddf9ea3a";
#    sha256 = "140w6mj4hm1vf4zsmcr2w5cghcaalbvw5d4m9z57dmq1z5plsl4q";
#  };
  src = fetchurl {
    url = "https://github.com/hardkernel/linux/archive/4.14.47-139.tar.gz";
    sha256 = "1n43a3rhpjq851qrn17r1dkibv6sqlmwxvl3hras4qr391x61y6n";
  };

  # Should the testing kernels ever be built on Hydra?
# extraMeta.hydraPlatforms = [];

} // (args.argsOverride or {}))
