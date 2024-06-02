resource "tls_private_key" "vmkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "pem_key_file" {
  content  = tls_private_key.vmkey.private_key_pem
  filename = "./vault/vmkey.pem" # Include the file extension and specify a folder path
}
