// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DegenGamingToken is ERC20 {
    
    struct item{
        uint id;
        string name;
        uint price;
        uint supply;
    }

    item [100000] public collections;

    item[100000] public DegenStore ;

    constructor() ERC20("Degen Token", "DGT") {

        DegenStore[1] = item(1, "XSuit", 1000,1);
        DegenStore[2] = item(2, "Mummy Suit", 800,1);
        DegenStore[3] = item(3, "Pharoa Suit", 900,1);
        DegenStore[4] = item(4, "Silver Coin", 100,1000);
        DegenStore[5] = item(5, "Gold Coin", 100,1000);

    }

    string public degensotre = "1. XSuit, 2. Mummy Suit, 3. Pharoa Suit, 4. Silver Coin, 5. Gold Coin";
    
    function mint(uint amount) external {
        _mint(msg.sender, amount);
    }

    function  burn(uint amount) external {

        require(balanceOf(msg.sender) >= amount, "You dont have enough DEGEN Tokens");
        _burn(msg.sender, amount);

    }

    function balance() external view returns(uint){
        return balanceOf(msg.sender);
    }

    function sendToken(address recipient, uint amount) external {
        require(balanceOf(msg.sender ) >= amount, "you dont have enough tokens");
        approve(msg.sender, amount);
        transferFrom(msg.sender, recipient, amount);
    }

    function redeemItem(uint256 id) public payable {
    
    require(DegenStore[id - 1].supply > 0, "Item not available");
    require(balanceOf(msg.sender) >= DegenStore[id - 1].price, "You don't have enough DGT");

    DegenStore[id - 1].supply -= 1;
    _burn(msg.sender, DegenStore[id - 1].price);
    collections[id] = item(id, DegenStore[id - 1].name, DegenStore[id - 1].price, collections[id].supply + 1);
    }
    
}
