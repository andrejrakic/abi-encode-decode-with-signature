// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Example {
    address public s;
    uint256 public a;

    function encode() public view returns(bytes memory) {
        return abi.encodeWithSignature("transfer(address,uint256)", msg.sender, 200);
    }

    function decode(bytes calldata paylaod) public pure returns(address ,uint256) {
       (address sender, uint256 amount) = abi.decode(paylaod[4:], (address,uint256));
        return (sender, amount);
    }

    function transfer(address sender, uint256 amount) public {
        s = sender;
        a = amount;
    }

    function call(bytes calldata payload) public {
        (bool success, ) = address(this).call(payload);
        require(success);
    }
}
