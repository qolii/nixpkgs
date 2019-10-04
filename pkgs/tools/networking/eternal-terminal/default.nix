{ stdenv, fetchFromGitHub, cmake, ninja, gflags, libsodium, protobuf }:

stdenv.mkDerivation rec {
  pname = "eternal-terminal";
  version = "6.0.4";

  src = fetchFromGitHub {
    owner = "MisterTea";
    repo = "EternalTCP";
    rev = "refs/tags/et-v${version}";
    sha256 = "05hbcbbxpvwm17ascnrwrz413kp3i94kp4px3vqx0f635rm41dqc";
  };

  nativeBuildInputs = [ cmake ninja ];
  buildInputs = [ gflags libsodium protobuf ];

  meta = with stdenv.lib; {
    description = "Remote shell that automatically reconnects without interrupting the session";
    license = licenses.asl20;
    homepage = https://mistertea.github.io/EternalTerminal/;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = [ maintainers.dezgeg ];
  };
}
