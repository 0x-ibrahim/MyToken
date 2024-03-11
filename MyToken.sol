// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
// Defining the contract name
contract MyToken {
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowances;
    
    string public name = "My Token";
    string public symbol = "MIT";
    uint8 public decimals = 18;
    uint256 private _totalSupply;
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    
    constructor() {
        _totalSupply = 100000 * (10 ** uint256(decimals));
        balanceOf[msg.sender] = _totalSupply;
    }
    
    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }
    
    function transfer(address to, uint256 value) external returns (bool) {
        require(to != address(0), "ERC20: transfer to the zero address");
        require(balanceOf[msg.sender] >= value, "ERC20: transfer amount exceeds balance");
        
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        
        emit Transfer(msg.sender, to, value);
        
        return true;
    }
    
    function transferFrom(address from, address to, uint256 value) external returns (bool) {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        require(value <= balanceOf[from], "ERC20: transfer amount exceeds balance");
        require(value <= allowances[from][msg.sender], "ERC20: transfer amount exceeds allowance");
        
        balanceOf[from] -= value;
        balanceOf[to] += value;
        allowances[from][msg.sender] -= value;
        
        emit Transfer(from, to, value);
        
        return true;
    }
    
    function approve(address spender, uint256 value) external returns (bool) {
        require(spender != address(0), "ERC20: approve to the zero address");
        
        allowances[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        
        return true;
    }
}
