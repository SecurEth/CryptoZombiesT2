# CryptoZombiesT2
Example documentation of the SecurEth Guidelines Process using the CryptoZombies Lessons code

This repository takes the [guidelines](https://guidelines.secureth.org/) and uses their process to 
document the code described in the [CryptoZombies website](https://cryptozombies.io).  The repository has the 
documented code (with requirements), the supporting documents (SDD, Dev Plan, Architecture docs) and it includes 
JavaScript tests for each lesson.  Each lesson compiles and the tests run (or will evenutally).

The code is the same as in the CryptoZombies website except;
1. The code is update to the latest solidity (0.5 for now)
2. require statements have error text, to minimize warnings
3. The onlyOwnerOf modifier was not added because of the require statements
4. The order was modified to meet the solidity style guide (public first)

Please enjoy and let us know about any comments on the [guidelines](https://guidelines.secureth.org/) website.
