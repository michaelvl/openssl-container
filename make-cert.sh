set -x
set -e

CERT_SUBJ='/C=DK/ST=ACMEprov/L=ACMEloc/O=ACMEcompany Bar\/Foo/OU=ACMEorg/CN=*.example.com'
FILENAME=server

echo "**********************"
echo "Generating private key"
echo "**********************"

docker run --rm -it --user $(id -u):$(id -g) -v $(pwd):/work openssl genrsa -out /work/${FILENAME}.key 2048

echo "**************"
echo "Generating CSR"
echo "**************"

docker run --rm -it --user $(id -u):$(id -g) -v $(pwd):/work openssl req -subj "$CERT_SUBJ" -new -key ${FILENAME}.key -out /work/${FILENAME}.csr

echo "************"
echo "CSR content:"
echo "************"

docker run --rm -it --user $(id -u):$(id -g) -v $(pwd):/work:ro openssl req -verify -in /work/${FILENAME}.csr -text -noout
