# openssl

Using openssl for symmetric file encryption is a bit dicey, because the default encryption parameters change over different releases.   That means that a file encrypted with an older version of openssl may require additional command line parameters to decrypt the file, in order to match the complete set of relevant encryption parameters.

### encrypt a file
```
openssl enc -aes-256-cbc -salt -md sha512 -pbkdf2 -iter 1000000 -in cleartext.txt -out encrypted.dat
```
### decrypt a file
```
openssl enc -aes-256-cbc -salt -md sha512 -pbkdf2 -iter 1000000 -in encrypted.dat -out cleartext.txt -d
```
### download a TLS/SSL certificate
This will fetch the base64-encoded (PEM format) of the certificate
The -servername <servername> is the certificate name that is being asked for.  Some sites will not respond with a certificate without this parameter.  
It is an "SNI issue" https://stackoverflow.com/questions/26583857/problems-getting-a-sites-https-certificates
SNI allows a single site to serve multiple certificates for different sites
```
openssl s_client -servername www.wellsfargo.com -connect www.wellsfargo.com:443 < /dev/null > wf.crt
```
(or don't use an intermediate file and directly pipe it to another openssl invocation to decode the cert)
### Show the sha256 checksum fingerprint of the entire cert
(this fingerprint is shown in the browser "lock" icon certificate dialog)
By default the input format is assumed to be the base64/PEM format.  use `-inform DER` to specify a binary DER format cert
```
openssl x509 -in wf.crt -fingerprint -noout
```
### Decode the entire certificate to text
```
openssl x509 -in wf.crt -text
```
### Translate a PEM certificate into DER format
DER format is a binary format, and it is the checksum of the DER format of the certificate that determines the fingerprint of the cert!   So if a browswer doesn't show you the fingerprint that you're interested in (SHA-1, SHA256, etc.), then you can download and convert the cert to DER format, then run "shasum <args> cert.der" yourself to generate the fingerprint
```
openssl x509 -in wf.crt -outform DER -out wf.der
```
### Manually generate a certificate fingerprint given your desired hash algorithm (SHA-1)
(openssl -fingerprint already provides SHA256)
```
shasum -inform DER -in wf.der
```

