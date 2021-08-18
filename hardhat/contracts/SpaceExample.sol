//"SPDX-License-Identifier: UNLICENSED"
pragma solidity 0.7.3;

contract SpaceExample{

    //0 - 3 
    enum Visibility{   
        onlyVisible,    
        onlyHidden,
        onlyPublic,
        onlyUnlisted
    }   

    struct Space {
        address owner;
        string handle;
        //string[] content_cids;    //array of content ids on ipfs
        uint block_num;
        uint timestamp;
        Visibility visibility;  //4 possible states, enum used to track
        uint followers_count;
        address[] followers;
    }

    mapping(uint => Space) public spaces;  //maps space id to space structure
    
    address[] public addresses;

    uint spaceIdIncriment = 0;    //initialise space id counter 

    function createSpace(string memory _handle, Visibility _visibility) public {
    
        spaceIdIncriment = addresses.length;

        spaces[spaceIdIncriment].owner = msg.sender;
        spaces[spaceIdIncriment].handle = _handle;
        spaces[spaceIdIncriment].block_num = block.number;
        spaces[spaceIdIncriment].timestamp = block.timestamp;
        spaces[spaceIdIncriment].visibility = _visibility;      // uint 0-3 represents 4 states of visibility
        spaces[spaceIdIncriment].followers_count = 0;
        addresses.push(msg.sender);
    }

    function transferOwnership(address _newOwner, uint _spaceId) public {
        require(msg.sender == spaces[_spaceId].owner);  //must be current owner to transfer ownership
        spaces[_spaceId].owner = _newOwner;
        addresses[_spaceId] = _newOwner;
    }

    function changeHandle(string memory _newHandle, uint _spaceId) public {
        require(msg.sender == spaces[_spaceId].owner);  //must be current owner to change handle
        spaces[_spaceId].handle = _newHandle;
    }

    function getOwner(uint _spaceId) view public returns(address) {
        return spaces[_spaceId].owner;
    }

    function getHandle(uint _spaceId) view public returns(string memory) {
        return spaces[_spaceId].handle;
    }
    
    function getBlockNumber(uint _spaceId) view public returns(uint) {
        return spaces[_spaceId].block_num;
    }

    function getTimestamp(uint _spaceId) view public returns(uint) {
        return spaces[_spaceId].timestamp;
    }

    function getVisibility(uint _spaceId) view public returns(Visibility) {
        return spaces[_spaceId].visibility;
    }

    function getFollowerCount(uint _spaceId) view public returns(uint) {
        return spaces[_spaceId].followers_count;    //or return spaces[_spaceId].followers.length
    }

    function findSpaceById(uint _spaceId) view public returns(address, string memory, uint, uint, Visibility, uint){
        return(
            spaces[_spaceId].owner,
            spaces[_spaceId].handle,
            spaces[_spaceId].block_num,
            spaces[_spaceId].timestamp,
            spaces[_spaceId].visibility,
            spaces[_spaceId].followers_count
        );
    }
}
