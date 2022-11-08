
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";

contract StudyContract is ERC1155, Ownable, ERC1155Burnable {
    constructor() ERC1155("") {}

    mapping(uint256 => uint) public studyTokenIndex; //  public

    mapping(address => studyToken[]) public studyTokensList;
    uint public studyTokenCount = 6000000;

    // mapping(uint => Token) public tokens;

    struct studyToken {      
        address account;
        address researcher;
        uint256 id; // auto increment
        uint256[] sample_token_ids; 
        uint256[] organoid_token_ids; 
        string title;
        string description; 
        string uri;
        bytes data;
	}

    // function setURI(string memory newuri) public  {
    //     _setURI(newuri);
    // }

    function mintStudyToken(address account, address researcher, uint256[] memory sample_token_ids, uint256[] memory organoid_token_ids, string memory title, string memory description, string memory uri, bytes memory data)
        public
        
    {
        require(account != address(0), "mint to zero address");

        uint256 id = studyTokenCount++;

        studyTokensList[account].push(studyToken(account, researcher, id, sample_token_ids, organoid_token_ids, title, description, uri, data));
        uint index = studyTokensList[account].length - 1;
        studyTokenIndex[id] = index;

        _mint(account, id, 1, data);
    }

    
    // function mintSampleBatch(address account, address manager, uint256[] memory sp_ids, uint256[] memory pa_ids, string[] memory sample_types, uint256[] memory amounts, bytes memory data, string[] memory status)
    //     public
    // {
    //     require(account != address(0), "mint to zero address");

    //     for (uint256 i = 0; i < sp_ids.length; i++) {
    //         sampleList[account].push(sampleToken(account, manager, sp_ids[i], pa_ids[i], sample_types[i], amounts[i], data, status[i]));
    //         uint index = sampleList[account].length - 1;
    //         sampleTokenIndex[sp_ids[i]] = index;
    //     }
    //     _mintBatch(account, sp_ids, amounts, data);
    // }

    

    function studyTokens(address account) public view returns (studyToken[] memory){
        return studyTokensList[account];
    }


    // function sampleOwnerOf(address account, uint256 tokenId) public view{
    //     uint index = sampleTokenIndex[tokenId];

    //     if(sampleList[account][index].sp_id != tokenId){
    //         uint error = 0;
    //         require(error == 1, "token doesn't exist");
    //     }
    // }


    // function burnStudyToken(address account, uint256 tokenId, uint256 amount) public {
    //     uint index = sampleTokenIndex[tokenId];

    //     if(sampleList[account][index].sp_id != tokenId){
    //         uint error = 0;
    //         require(error == 1, "token doesn't exist");
    //     }

    //     sampleList[account][index].status = 'consumed';
    //     sampleList[account][index].amount -= 1;  

    //     _burn(account,tokenId, amount);
    // }
}