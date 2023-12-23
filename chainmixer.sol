// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// MultiSwap contract for governance token with proposal and voting functionality
contract MultiSwap {
    // Token constants
    string public constant NAME = "MultiSwap";
    string public constant SYMBOL = "MSW";
    uint8 public constant DECIMALS = 18;

    // State variables
    uint256 public totalSupply;
    address public immutable owner;
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowed;
    uint256 public nextProposalId;
    mapping(uint256 => Proposal) public proposals;

    // Struct for storing proposal details
    struct Proposal {
        address proposer;
        uint256 endTime;
        bool executed;
        uint256 voteCount;
        mapping(address => bool) hasVoted; // Track if an address has voted
    }

    // Events
    // ... (Events remain unchanged)

    // Constructor sets total supply and owner's balance
    constructor() {
        owner = msg.sender;
        totalSupply = 10000000 * (10 ** uint256(DECIMALS));
        balances[owner] = totalSupply;
        emit Transfer(address(0), owner, totalSupply);
    }

    // Vote on an active proposal
    function voteOnProposal(uint256 proposalId, bool userVote) public {
        require(balances[msg.sender] > 0, "Only token holders can vote");
        Proposal storage proposal = proposals[proposalId];
        require(block.timestamp <= proposal.endTime, "Voting period has ended");
        require(!proposal.hasVoted[msg.sender], "Voter has already voted");
        proposal.hasVoted[msg.sender] = true;
        if (userVote) {
            proposal.voteCount++;
        }
        emit Voted(proposalId, userVote);
    }

    // Execute a proposal after voting period ends
    // ... (Execute proposal function remains unchanged)
}
