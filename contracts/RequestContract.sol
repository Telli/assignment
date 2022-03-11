// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract Request {

enum Status {Pending, Approved, Rejected}

uint minimumApprovers;

uint approvalCount;

bool isRejected;


mapping (address => bool) approversList;

mapping (address => bool) isApprover;




Status public status;

address public ipName;

string public details;

uint256 public amount;


  constructor(
    address[] memory _approvers, 
    uint _minApprovers
  
  ) public {
  


  require(
            _minApprovers <= _approvers.length,
            "the minimum number of approvers should be less than or equal to the total approving participants");

       status = Status.Pending;
       isRejected = false;
     
      
        for (uint i = 0; i < _approvers.length; i++) {
            address approver = _approvers[i];
            isApprover[approver] = true;
        }



}

function makeRequest(string calldata _details, uint256 _amount ) public{

       ipName = msg.sender;
       details = _details;
       amount = _amount;

}

function approve(uint256 _amount) public{
   require(isApprover[msg.sender], "Not an approver");
   require(!isRejected, "Proposal was rejected");

 if (!approversList[msg.sender]) {
            approversList[msg.sender] = true;
            approvalCount++;
        }

 if (approvalCount == minimumApprovers) {
          
          status = Status.Approved;
          if(amount > 0 ){
          amount = _amount;
          }
        }


}



function checkStatus() public view returns (Status) {
// require(isApprover[msg.sender], "Not Authorized");
return status;
       
}



}
