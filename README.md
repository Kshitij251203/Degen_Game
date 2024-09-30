# DegenToken

This Solidity contract is for the DegenToken, an ERC20 token built using OpenZeppelin's ERC20 contract. The contract also contains a simple in-game store (DegenStore) where users can redeem items using the DegenToken. Users can mint, burn, and transfer tokens, as well as redeem items from the store by paying with the tokens.

## Description

DegenToken is an ERC20 token contract that enables the creation, burning, and transfer of tokens. The contract also features an in-game store with five items that can be redeemed by users. The store tracks item supply, and when a user redeems an item, the token amount equivalent to the item's price is burned from the user’s account.

The purpose of this contract is to demonstrate the use of ERC20 tokens with additional functionality like minting, burning, and using tokens to redeem virtual items in a store.
## Getting Started

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., Project4.sol). Copy and paste the following code into the file:

```javascript
// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DegenToken is ERC20 {
    
    struct item{
        uint id;
        string name;
        uint price;
        uint supply;
    }

    item [100000] public collections;
    item [100000] public DegenStore;

    constructor() ERC20("Degen", "DGN") {
        DegenStore[0] = item(1, "Dragon Armor", 1000, 1);
        DegenStore[1] = item(2, "Phoenix Wings", 800, 500);
        DegenStore[2] = item(3, "Shadow Cloak", 900, 250);
        DegenStore[3] = item(4, "Emerald Coin", 100, 1000);
        DegenStore[4] = item(5, "Diamond Coin", 100, 1000);
    }

    string public degenstore = "1. Dragon Armor, 2. Phoenix Wings, 3. Shadow Cloak, 4. Emerald Coin, 5. Diamond Coin";

    function mint(uint amount) external {
        _mint(msg.sender, amount);
    }

    function burn(uint amount) external {
        require(balanceOf(msg.sender) >= amount, "You don't have enough DEGEN Tokens");
        _burn(msg.sender, amount);
    }

    function balance() external view returns(uint){
        return balanceOf(msg.sender);
    }

    function sendToken(address recipient, uint amount) external {
        require(balanceOf(msg.sender) >= amount, "you don't have enough tokens");
        transfer(recipient, amount);
    }

    function redeemItem(uint256 id) public payable {
        require(DegenStore[id - 1].supply > 0, "Item not available");
        require(balanceOf(msg.sender) >= DegenStore[id - 1].price, "You don't have enough DGT");

        DegenStore[id - 1].supply -= 1;
        _burn(msg.sender, DegenStore[id - 1].price);
        collections[id - 1] = item(id, DegenStore[id - 1].name, DegenStore[id - 1].price, collections[id - 1].supply + 1);
    }
}

```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.26" (or another compatible version), and then click on the "Compile Project4.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "DegenToken - Project4.sol" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can mint, burn, check balances, transfer tokens, and redeem store items through the contract’s functions.
