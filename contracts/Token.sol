//SPDX-License-Identifier: UNLICENSED

// Solidity files have to start with this pragma.
// It will be used by the Solidity compiler to validate its version.
pragma solidity ^0.8.9;

// We import this library to be able to use console.log
import "hardhat/console.sol";

contract Token {
    // 創建公開的字串型別變數token
    string public name = "My Hardhat Token";
    string public symbol = "MHT";

    // 公開固定token供給量為1000000 The fixed amount of tokens stored in an unsigned integer type variable.
    uint256 public totalSupply = 1000000;

    // 公開位置儲存ethereum 帳戶 An address type variable is used to store ethereum accounts.
    address public owner;

    // 為每個帳戶儲存餘額 A mapping is a key/value map. Here we store each account balance.
    mapping(address => uint256) balances;

    // The Transfer event helps off-chain aplications understand
    // what happens within your contract.
    // Transfer事件幫鏈下交易理解合約
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    /**
     * Contract initialization.
     */
    constructor() {
        // 初始化合約 將token供給量分配給合約的發布者
        // The totalSupply is assigned to the transaction sender, which is the
        // account that is deploying the contract.
        balances[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    /**
     * A function to transfer tokens.
     *
     * The `external` modifier makes a function *only* callable from outside
     * the contract.
     */
    //  宣告transfer方法 且只能在合約外部被調用
    function transfer(address to, uint256 amount) external {
        // Check if the transaction sender has enough tokens.
        // If `require`'s first argument evaluates to `false` then the
        // transaction will revert.
        // 先檢查交易發送者tokens是否大於要交易的數量
        require(balances[msg.sender] >= amount, "Not enough tokens");

        // We can print messages and values using console.log, a feature of
        // Hardhat Network:
        console.log(
            "Transferring from %s to %s %s tokens",
            msg.sender,
            to,
            amount
        );

        // Transfer the amount.
        // 交易數量轉換
        balances[msg.sender] -= amount;
        balances[to] += amount;

        // Notify off-chain applications of the transfer.
        // 通知鏈下交易此次交易
        emit Transfer(msg.sender, to, amount);
    }

    /**
     * Read only function to retrieve the token balance of a given account.
     *
     * The `view` modifier indicates that it doesn't modify the contract's
     * state, which allows us to call it without executing a transaction.
     */
    //  balanceOf方法可以檢視餘額 而且不需要花錢
    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }
}
