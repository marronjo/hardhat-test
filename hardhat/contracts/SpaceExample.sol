//"SPDX-License-Identifier: UNLICENSED"
pragma solidity 0.7.3;

contract SpaceExample{

    enum Visibility{
        onlyVisible,
        onlyHidden,
        onlyPublic,
        onlyUnlisted
    }

    struct Space {
        address owner;
        string handle;
        string[] content_cids;
        uint block_num;
        uint timestamp;
        Visibility visibility;  //4 possible states, enum used to track
        uint followers_count;
        address[] followers;
    }

    mapping(uint => Space) public spaces;  //maps space id to space structure
    
    address[] public array;

    uint spaceIdIncriment = 0;    //initialise space id counter 

    function createSpace(string memory _handle, Visibility _visibility) public {
    
        spaceIdIncriment = array.length;
        
        /*
        space.owner = msg.sender;
        space.handle = _handle;
        space.visibility = _visibility;
        */

        spaces[spaceIdIncriment].owner = msg.sender;
        spaces[spaceIdIncriment].handle = _handle;
        spaces[spaceIdIncriment].block_num = block.number;
        spaces[spaceIdIncriment].timestamp = block.timestamp;
        spaces[spaceIdIncriment].visibility = _visibility;      // uint 0-3 represents 4 states of visibility
        spaces[spaceIdIncriment].followers_count = 0;
        array.push(msg.sender);
    }

    function getOwner(uint spaceId) view public returns(address) {
        return spaces[spaceId].owner;
    }
}
