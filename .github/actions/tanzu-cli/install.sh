# Install Tanzu CLI and initialize
curl -Lo tanzu-cli-linux-amd64.tar.gz https://github.com/vmware-tanzu/tanzu-cli/releases/download/${TANZU_CLI_VERSION}/tanzu-cli-linux-amd64.tar.gz
curl -Lo tanzu-cli-binaries-checksums.txt https://github.com/vmware-tanzu/tanzu-cli/releases/download/${TANZU_CLI_VERSION}/tanzu-cli-binaries-checksums.txt

if [ "$(cat tanzu-cli-binaries-checksums.txt | grep tanzu-cli-linux-amd64.tar.gz)" != "$(sha256sum tanzu-cli-linux-amd64.tar.gz)" ]; then echo "Checksum does not match"; exit 1; fi

tar -xf tanzu-cli-linux-amd64.tar.gz
mv ${TANZU_CLI_VERSION}/tanzu-cli-linux_amd64 /usr/local/bin/tanzu
tanzu ceip-participation set false
tanzu config eula accept
tanzu init
tanzu version
