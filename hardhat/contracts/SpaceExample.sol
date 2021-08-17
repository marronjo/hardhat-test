//"SPDX-License-Identifier: UNLICENSED"
pragma solidity 0.7.3;

contract SpaceExample{

    enum Visibility{
        onlyVisible,
        onlyHidden,
        onlyPublic,
        onlyUnlisted
    }

    struct Spaces {
        address owner;
        string handle;
        uint block_num;
        uint timestamp;
        bool hidden;
        Visibility visibility;  //4 possible states, enum used to track
        uint followers_count;
    }

    mapping(uint => Spaces) public spaces;  //maps space id to space structure

    uint spaceIdIncriment = 0;    //initialise space id counter 

    function createSpace(string memory _handle, Visibility _visibility) public {
        //require(spaces[spaceIdIncriment].owner == );       //cannot overwrite existing space

        spaces[spaceIdIncriment].owner = msg.sender;
        spaces[spaceIdIncriment].handle = _handle;
        spaces[spaceIdIncriment].visibility = _visibility;      // uint 0-3 represents 4 states of visibility
        //....
        spaceIdIncriment++;
    }

    function getOwner(uint spaceId) public returns(address) {
        return spaces[spaceId].owner;
    }
}
