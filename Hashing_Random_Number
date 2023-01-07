// SPDX-License-Identifier: GPL-3.0
// pragma version
pragma solidity ^0.6.6; 
  
// Creating a contract
contract hashing01
{
    // We want hash to be of 8 digits 
    // hence we store 10^8 which is 
    // used to extract first 8 digits 
    // later by Modulus 
    uint hashDigits = 8;
      
    // Equivalent to 10^8 = 8
    uint hashModulus = 10 ** hashDigits; 
  
    // Function to generate the hash value
    function _generateRandom(string memory _str) 
        public view returns (uint) 
    {
        // "packing" the string into bytes and 
        // then applying the hash function. 
        // This is then typecasted into uint.
        uint random = 
             uint(keccak256(abi.encodePacked(_str)));
               
        // Returning the generated hash value 
        return random % hashModulus;
    }
  
}
