{ stdenv
, buildPythonPackage
, fetchPypi
, openssl
, cryptography
, pyasn1
, idna
, pytest
, pretend
, flaky
, glibcLocales
}:

buildPythonPackage rec {
  pname = "pyOpenSSL";
  version = "18.0.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "6488f1423b00f73b7ad5167885312bb0ce410d3312eb212393795b53c8caa580";
  };

  outputs = [ "out" "dev" ];

  preCheck = ''
    sed -i 's/test_set_default_verify_paths/noop/' tests/test_ssl.py
    # https://github.com/pyca/pyopenssl/issues/692
    sed -i 's/test_fallback_default_verify_paths/noop/' tests/test_ssl.py
    # https://github.com/pyca/pyopenssl/issues/791
    sed -i 's/test_op_no_compression/noop/' tests/test_ssl.py
    sed -i 's/test_npn_advertise_error/noop/' tests/test_ssl.py
    sed -i 's/test_npn_select_error/noop/' tests/test_ssl.py
    sed -i 's/test_npn_client_fail/noop/' tests/test_ssl.py
    sed -i 's/test_npn_success/noop/' tests/test_ssl.py
    sed -i 's/test_use_certificate_chain_file_unicode/noop/' tests/test_ssl.py
    sed -i 's/test_use_certificate_chain_file_bytes/noop/' tests/test_ssl.py
    sed -i 's/test_add_extra_chain_cert/noop/' tests/test_ssl.py
    sed -i 's/test_set_session_id_fail/noop/' tests/test_ssl.py
    sed -i 's/test_verify_with_revoked/noop/' tests/test_crypto.py
    sed -i 's/test_set_notAfter/noop/' tests/test_crypto.py
    sed -i 's/test_set_notBefore/noop/' tests/test_crypto.py
  '';

  checkPhase = ''
    runHook preCheck
    export LANG="en_US.UTF-8"
    py.test
    runHook postCheck
  '';

  # Seems to fail unpredictably on Darwin. See http://hydra.nixos.org/build/49877419/nixlog/1
  # for one example, but I've also seen ContextTests.test_set_verify_callback_exception fail.
  doCheck = !stdenv.isDarwin;

  buildInputs = [ openssl ];
  propagatedBuildInputs = [ cryptography pyasn1 idna ];

  checkInputs = [ pytest pretend flaky glibcLocales ];
}
