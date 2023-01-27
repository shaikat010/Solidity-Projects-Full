// Student Management System:
// This system allows a school or university to manage student records, including personal information, enrollment status, and academic performance.
// Here is an example of how the contract might be structured:
// Orginal code from ChatGPT3

// SPDX-License-Identifier: GPL-3.0
//pragma solidity ^0.6.0;
pragma solidity >=0.5.0 <0.9.0;

contract StudentManagementSystem {
  // Define a struct to hold student information
  struct Student {
    string name;
    uint age;
    string enrollmentStatus;
    uint[] grades;
  }

  // Create a mapping from student IDs to student structs
  mapping(uint => Student) public students;

  // Create an array to store the IDs of all students
  uint[] public studentIds;

  // The constructor function is called when the contract is deployed
  constructor() {
    // Create a new student with ID 1 and add them to the mapping
    students[1].name = "Alice";
    students[1].age =20;
    students[1].enrollmentStatus = "Enrolled";
    students[1].grades[0]= 90;
    students[1].grades[1]= 80;
    students[1].grades[2]= 70;
    studentIds.push(1);
    // Create a new student with ID 2 and add them to the mapping
    students[2].name = "Bob";
    students[2].age =22;
    students[2].enrollmentStatus = "Enrolled";
    students[2].grades[0]= 80;
    students[2].grades[1]= 70;
    students[2].grades[2]= 60;
    studentIds.push(2);
  }

  // This function allows a school administrator to add a new student to the system
  function addStudent(string memory name, uint age, string memory enrollmentStatus, uint[] memory grades) public {
    // Generate a new ID for the student by incrementing the length of the studentIds array
    uint newId = studentIds.length + 1;

    // Create a new student struct with the provided information and add it to the mapping
    students[newId] = Student(name, age, enrollmentStatus, grades);

    // Add the new student's ID to the array of student IDs
    studentIds.push(newId);
  }

  // This function allows a school administrator to update a student's enrollment status
  function updateEnrollmentStatus(uint studentId, string memory enrollmentStatus) public {
    // Check that the student with the given ID exists
    uint validity = 0;
    for(uint i =0;i<studentIds.length;i++){
      if(studentIds[i] == studentId){
        validity = 1;
      }
    }

    require(validity != 0, "Error: Student does not exist");
    // Update the student's enrollment status
    students[studentId].enrollmentStatus = enrollmentStatus;
  }

  // This function allows a school administrator to retrieve a student's information
  function getStudent(uint studentId) public view returns (string memory, uint, string memory, uint[] memory) {
    // Retrieve the student struct from the mapping
    Student memory student = students[studentId];

    // Return the student's information
    return (student.name, student.age, student.enrollmentStatus, student.grades);
  }
}

