// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MetaVerse is ERC20, Ownable {
    
    uint public MTVTokenPrice= 1 ether;
   
    error AmountCannotBeZero();
    error OwnerIsRestrictedToBuyToken();
    error PleaseSendExactAmount();
    
    event TokenMinted(address MinterAddress, uint amount);
    event TokenPurchasedBy(address BuyerAddress, uint _Price);
    event UpdatedPrice(address UpdatedBy, uint _NewPrice);
    
    constructor() ERC20("MetaVerse", "MTV") {
    }
    
    /**
    
       * @dev mint is for minting MTV token 
       * Requirements: 
       * @param amount- No of tokens to be minted
       * OnlyOwner is allowed to perform this function
       * Check: The amount of tokens to be minted cannot be zero
       * Emits a TokenMinted event
    
    **/
    
    function mint(uint256 amount) public onlyOwner{
        if(amount<=0){
           revert AmountCannotBeZero();
    }
        _mint(msg.sender, amount);
        emit TokenMinted(msg.sender, amount);
    }
    
    /**
    
       * @dev BuyToken is for buying MTV token 
       * Requirements: 
       * Check: Contract owner is not allowed to call this function
       * Check: Amount to be sent must be equal to the price of token 
       * Emits a TokenPurchasedBy event
    
    **/
    

    function BuyToken() public payable{
        if(msg.sender==owner()){
           revert OwnerIsRestrictedToBuyToken();
    }

        if (msg.value !=MTVTokenPrice) {
           revert PleaseSendExactAmount();
    }
    _transfer(owner(), msg.sender, 1);
    payable(owner()).transfer(msg.value);

    emit TokenPurchasedBy(msg.sender, msg.value);
    
    }
    
    /**
    
       * @dev UpdateTokenPrice for MTV token 
       * Requirements:
       * @param amount- UpdatedPrice of MTV Token
       * Check: OnlyOwner is allowed to call this function
       * Check: Amount to be sent must be equal to the price of token 
       * Emits UpdatedPrice event
    
    **/
    
    function UpdateTokenPrice(uint NewPrice) public onlyOwner{
        if(NewPrice<=0){
           revert AmountCannotBeZero();
      }
    MTVTokenPrice=NewPrice;

    emit UpdatedPrice(msg.sender,NewPrice);
    
    }
}
