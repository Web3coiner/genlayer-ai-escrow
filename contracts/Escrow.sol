// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Escrow {

    address public buyer;
    address public seller;

    enum Status {
        Created,
        Funded,
        Released,
        Refunded
    }

    Status public status;

    constructor(address _seller) {
        buyer = msg.sender;
        seller = _seller;
        status = Status.Created;
    }

    function deposit() external payable {
        require(msg.sender == buyer, "Only buyer");
        require(status == Status.Created, "Already funded");
        require(msg.value > 0, "No ETH sent");

        status = Status.Funded;
    }

    function releaseFunds() external {
        require(msg.sender == buyer, "Only buyer");
        require(status == Status.Funded, "Not funded");

        status = Status.Released;

        payable(seller).transfer(address(this).balance);
    }

    function refundBuyer() external {
        require(msg.sender == seller, "Only seller");
        require(status == Status.Funded, "Not funded");

        status = Status.Refunded;

        payable(buyer).transfer(address(this).balance);
    }
}
