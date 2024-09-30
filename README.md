# DegenToken

This Solidity contract is for the DegenToken, an ERC20 token built using OpenZeppelin's ERC20 contract. The contract also contains a simple in-game store (DegenStore) where users can redeem items using the DegenToken. Users can mint, burn, and transfer tokens, as well as redeem items from the store by paying with the tokens.

## Description

DegenToken is an ERC20 token contract that enables the creation, burning, and transfer of tokens. The contract also features an in-game store with five items that can be redeemed by users. The store tracks item supply, and when a user redeems an item, the token amount equivalent to the item's price is burned from the user’s account.

The purpose of this contract is to demonstrate the use of ERC20 tokens with additional functionality like minting, burning, and using tokens to redeem virtual items in a store.
## Getting Started

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., DegenGame.sol). Copy and paste the following code into the file:

```javascript
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

```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.26" (or another compatible version), and then click on the "Compile DegenGame.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "DegenToken - DegenGame.sol" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can mint, burn, check balances, transfer tokens, and redeem store items through the contract’s functions.
