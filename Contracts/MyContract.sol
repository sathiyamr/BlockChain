// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract OwnerContract {
    address ownerAddress;

    constructor() {
        ownerAddress = msg.sender;
    }

    modifier isOwner() {
        require(ownerAddress == msg.sender, "only owner can view the secret vault");
        _;
    }
}

contract SecretVault {
    string secretVault;

    constructor(string memory secretVault_) {
        secretVault = secretVault_;
    }

    function getSecretVault() public view returns (string memory) {
        return secretVault;
    }
}


contract MyContract is OwnerContract {
    address secretVaultContractAddress;

    constructor(string memory _secretVaultString) {
        super;
        SecretVault _secretVault = new SecretVault(_secretVaultString);
        secretVaultContractAddress = address(_secretVault);

    }

    function getSecretVault() public view isOwner returns (string memory) {
        return SecretVault(secretVaultContractAddress).getSecretVault();
    }
}