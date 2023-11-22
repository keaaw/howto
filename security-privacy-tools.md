# openssl

Using openssl for symmetric file encryption is a bit dicey, because the default encryption parameters change over different releases.   That means that a file encrypted with an older version of openssl may require additional command line parameters to decrypt the file, in order to match the complete set of relevant encryption parameters.

## encrypt a file
```
openssl enc -aes-256-cbc -salt -md sha512 -pbkdf2 -iter 1000000 -in cleartext.txt -out encrypted.dat
```
## decrypt a file
```
openssl enc -aes-256-cbc -salt -md sha512 -pbkdf2 -iter 1000000 -in encrypted.dat -out cleartext.txt -d
```
