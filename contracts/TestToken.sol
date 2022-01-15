// SPDX-License-Identifier: MIT
// Inspired on token.sol from DappHub
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TestToken is IERC20Metadata, Ownable {

    uint256 internal _totalSupply;
    mapping (address => uint256) internal _balanceOf;
    mapping (address => mapping (address => uint256)) internal _allowance;
    string public override name = "TEST TOKEN";
    string public override symbol = "TEST";
    uint8 public override decimals = 18;

    constructor(string memory name_, string memory symbol_, uint8 decimals_) {
        name = name_;
        symbol = symbol_;
        decimals = decimals_;
    }

    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address guy) public view virtual override returns (uint256) {
        return _balanceOf[guy];
    }

    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowance[owner][spender];
    }

    function approve(address spender, uint amount) public virtual override returns (bool) {
        return _approve(msg.sender, spender, amount);
    }

    function transfer(address dst, uint amount) public virtual override returns (bool) {
        return _transfer(msg.sender, dst, amount);
    }

    function transferFrom(address src, address dst, uint amount) public virtual override returns (bool) {
        _decreaseApproval(src, amount);

        return _transfer(src, dst, amount);
    }

    function _decreaseApproval(address src, uint amount) internal virtual returns (bool) {
        if (src != msg.sender) {
            uint256 allowed = _allowance[src][msg.sender];
            if (allowed != type(uint).max) {
                require(allowed >= amount, "ERC20: Insufficient approval");
                unchecked { _approve(src, msg.sender, allowed - amount); }
            }
        }

        return true;
    }

    function _transfer(address src, address dst, uint amount) internal virtual returns (bool) {
        
        require(_balanceOf[src] >= amount, "ERC20: Insufficient balance");
        unchecked { _balanceOf[src] = _balanceOf[src] - amount; }
        _balanceOf[dst] = _balanceOf[dst] + amount;

        emit Transfer(src, dst, amount);

        return true;
    }

    function _approve(address owner, address spender, uint amount) internal virtual returns (bool) {
        _allowance[owner][spender] = amount;
        emit Approval(owner, spender, amount);

        return true;
    }

    function _mint(address dst, uint amount) internal virtual returns (bool) {
        _balanceOf[dst] = _balanceOf[dst] + amount;
        _totalSupply = _totalSupply + amount;
        emit Transfer(address(0), dst, amount);

        return true;
    }

    function _burn(address src, uint amount) internal virtual returns (bool) {
        unchecked {
            require(_balanceOf[src] >= amount, "ERC20: Insufficient balance");
            _balanceOf[src] = _balanceOf[src] - amount;
            _totalSupply = _totalSupply - amount;
            emit Transfer(src, address(0), amount);
        }

        return true;
    }

    function mint(address dst, uint amount) public onlyOwner {
        _mint(dst, amount);
    }

    function burn(address src, uint amount) public onlyOwner {
        _burn(src, amount);
    }

}