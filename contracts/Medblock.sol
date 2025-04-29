// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Medblock {
    struct Patient {
        string name;
        uint256 age;
        string sex;
        string diagnosis;
    }

    mapping(address => Patient) private patients;
    mapping(address => bool) private isRegistered;

    event PatientRegistered(address indexed patient, string name);

    function registerPatient(
        string calldata _name,
        uint256 _age,
        string calldata _sex,
        string calldata _diagnosis
    ) external {
        require(!isRegistered[msg.sender], "Already registered.");
        patients[msg.sender] = Patient(_name, _age, _sex, _diagnosis);
        isRegistered[msg.sender] = true;

        emit PatientRegistered(msg.sender, _name);
    }

    function getPatientRecord(address _patientAddr)
        external
        view
        returns (string memory name, uint256 age, string memory sex, string memory diagnosis)
    {
        require(isRegistered[_patientAddr], "Patient not found.");
        Patient storage p = patients[_patientAddr];
        return (p.name, p.age, p.sex, p.diagnosis);
    }

    function getMyRecord()
        external
        view
        returns (string memory name, uint256 age, string memory sex, string memory diagnosis)
    {
        require(isRegistered[msg.sender], "You are not registered.");
        Patient storage p = patients[msg.sender];
        return (p.name, p.age, p.sex, p.diagnosis);
    }
}
