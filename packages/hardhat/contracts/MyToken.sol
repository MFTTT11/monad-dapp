// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleContract {
    // Sözleşme sahibi
    address public owner;
    
    // Adminler için bir harita
    mapping(address => bool) public admins;

    // Constructor: Sözleşme dağıtıldığında sahibi belirler
    constructor() {
        owner = msg.sender; // Sözleşme dağıtan kişi sahibi olur
    }

    // Modifier: sadece sahibin erişebileceği fonksiyonlar için
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can execute this");
        _;
    }

    // Modifier: sadece adminlerin erişebileceği fonksiyonlar için
    modifier onlyAdmin() {
        require(admins[msg.sender] == true, "Only admins can execute this");
        _;
    }

    // Admin eklemek için sadece sahip erişebilir
    function addAdmin(address _admin) public onlyOwner {
        admins[_admin] = true;
    }

    // Adminliği kaldırmak için sadece sahip erişebilir
    function removeAdmin(address _admin) public onlyOwner {
        admins[_admin] = false;
    }

    // Sahiplik değişikliği
    function transferOwnership(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    // Admin tarafından erişilebilen basit bir fonksiyon
    function adminFunction() public onlyAdmin view returns (string memory) {
        return "You are an admin!";
    }

    // Herkesin erişebileceği bir fonksiyon
    function publicFunction() public pure returns (string memory) {
        return "This function is public!";
    }
}
