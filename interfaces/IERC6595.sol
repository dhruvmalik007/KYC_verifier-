// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.0;

interface IERC6595 {
    // STRUCTURE 
    /**
     * @dev metadata and Values structure of the Metadata, cited from ERC-3475
     */
    struct Metadata {
        string title;
        string _type;
        string description;
    }
    struct Values { 
        string stringValue;
        uint uintValue;
        address addressValue;
        bool boolValue;
    }
    /**
     * @dev structure that defines the parameters for specific issuance of bonds and amount which are to be transferred/issued/given allowance, etc.
     * @notice this structure is used for the verification process, it chontains the metadata, logic and expectation
     * @logic given here MUST be one of ("⊄", "⊂", "<", "<=", "==", "!=", ">=",">")
     */
    struct Requirement {
        Metadata metadata;
        string logic;
        Values expectation;
    }
    /// @notice getter function to validate if the address `verifying` is the holder of the SBT defined by the tokenId `SBTID`
    /// @dev it MUST be defining the logic corresponding to all the current possible requirements definition.
    /// @param verifying is the  EOA address that wants to validate the SBT issued to it by the KYC. 
    /// @param SBTID is the Id of the SBT that user is the claimer.
    /// @return true if the assertion is valid, else false

    function ifVerified(address verifying, uint256 SBTID) external view returns (bool);
    function standardRequirement(uint256 SBTID) external view returns (Requirement[] memory);
    function changeStandardRequirement(uint256 SBTID, Requirement[] memory requirements) external returns (bool);
    function certify(address certifying, uint256 SBTID) external returns (bool);
    function revoke(address certifying, uint256 SBTID) external returns (bool);

    event standardChanged(uint256 SBTID, Requirement[]);   
    event certified(address certifying, uint256 SBTID);
    event revoked(address certifying, uint256 SBTID);
}
