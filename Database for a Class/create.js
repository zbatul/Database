conn = new Mongo();
db = conn.getDB("myDatabase");

// COLLECTIONS DESIGN
// I have created 3 collections for doing this assignment and designed in such a way that it supports the 6 queries asked for.
// 1. Section: This collection contains the details for each section/class. 
// 2. Student: This collection consists of the student details like first name, last name etc. We are only using student id in this assignment because no other details related to a specific student is asked for. If asked, we can either do a lookup using the student_id or put the student details in the grades table discussed below.
// 3. Grades: This collection contains the assignment and course grade information required for this assignment. The course grades are unique for a section and a student. An assignment grade is unique for a section, student and assignment name.

// DESIGN CHOICES AS PER QUERIES
// The design choices are influenced by the use case in the 6 queries asked for.
// First query asks for assignment grade for specific student and specific section. Keeping grades collection with student and section ids alongwith assignments in a bucket pattern helps in easy retrieval of required grade.
// Second query is fetched using only section collection. 
// Third query asks for a grade of specific student and specific section which can be easily retrieved from grades collection since we know the student_id and section_id
// Fourth query asks for the gpa of a specific student which can be calculated from a single collection by averaging over the grades of a student in all the sections enrolled in.
// Fifth query requires us to update the grades of all students in a particular section. This can be done on one go in the grades table.
// Sixth query requires join across the section and grades collection for the average grade of a section.
// The design is efficient because lookup is performed only for one query whose frequency of occuring (maybe once per term) is the least as compared to other queries.

/*========================================SECTION COLLECTION===================================================*/

// This collection contains:
// 1. Section ID: _id to represent a specific section.
// 2. Section Number: secnum to represent the section number for course
// 3. Term: term in which the section and course is offered
// 4. Year: year in which the section and course is offered
// 5. Course details: course which contains a course name, the department the course belongs to and number of units of course
//      - course_name
//      - dept_name
//      - units

// The combination of course, section  number, term and year should be unique handled below
db.section.createIndex( { 'secnum': 1, 'term': 1, 'year': 1, 'course': 1}, { unique: true } )

// Insert documents into the section collection
db.section.insertMany( [
    {_id: 1, 
     secnum: '01', 
     term: 9, 
     year: 2020, 
     course: { course_name: 'College Writing: Stretch I', dept_name: 'English', units: 3 }
    },
    {_id: 2, 
     secnum: '01', 
     term: 5, 
     year: 2021, 
     course: { course_name: 'College Writing: Stretch I', dept_name: 'English', units: 3 }
    },
    {_id: 3, 
     secnum: '02', 
     term: 5, 
     year: 2021, 
     course: { course_name: 'College Writing: Stretch I', dept_name: 'English', units: 3 }
    },
    {_id: 4, 
     secnum: '01', 
     term: 9, 
     year: 2020, 
     course: { course_name: 'College Writing Lab', dept_name: 'English', units: 1 }
    },
    {_id: 5, 
     secnum: '01', 
     term: 5, 
     year: 2021, 
     course: { course_name: 'College Writing Lab', dept_name: 'English', units: 1 }
    },
    {_id: 6, 
     secnum: '02', 
     term: 5, 
     year: 2021, 
     course: { course_name: 'College Writing Lab', dept_name: 'English', units: 1 }
    },
    {_id: 7, 
     secnum: '01', 
     term: 5, 
     year: 2021, 
     course: { course_name: 'Database Architecture', dept_name: 'Computer Science', units: 3 }
    },
    {_id: 8, 
     secnum: '02', 
     term: 5, 
     year: 2021, 
     course: { course_name: 'Database Architecture', dept_name: 'Computer Science', units: 3 }
    },
    {_id: 9, 
     secnum: '03', 
     term: 5, 
     year: 2021, 
     course: { course_name: 'Database Architecture', dept_name: 'Computer Science', units: 3 }
    },
    {_id: 10, 
     secnum: '01', 
     term: 9, 
     year: 2020, 
     course: { course_name: 'Database Architecture', dept_name: 'Computer Science', units: 3 }
    },
    {_id: 11, 
     secnum: '01', 
     term: 9, 
     year: 2020, 
     course: { course_name: 'Computer Graphics', dept_name: 'Computer Science', units: 3 }
    },
    {_id: 12, 
     term: 9, 
     year: 2020, 
     course: { course_name: 'Intro to College Chemistry', dept_name: 'Chemistry', units: 3 }
    },
] )

/*========================================STUDENT COLLECTION===================================================*/

// This collection contains:
// 1. Student ID: _id to represent a specific student
// 2. NetID of student: netid
// 3. First Name of student: fname
// 4. Last Name of student: lname
// 5. Year in School: yrInSchool

// Insert documents into the student collection
db.student.insertMany( [ { _id: 1, netid: 'mp4444', fname: 'May', lname: 'Pham', yrInSchool: 'SR' },
                     { _id: 2, netid: 'hp9999', fname: 'Hal', lname: 'Prince', yrInSchool: 'FR' },
                     { _id: 3, netid: 'rj2222', fname: 'Raj', lname: 'Jain', yrInSchool: 'GR' },
                     { _id: 4, netid: 'dc3333', fname: 'Deb', lname: 'Cortez', yrInSchool: 'SO' },
                     { _id: 5, netid: 'zs8888', fname: 'Zoey', lname: 'Stein', yrInSchool: 'SO'  },
                     { _id: 6, netid: 'ge0000', fname: 'Gerald', lname: 'Elephant', yrInSchool: 'FR' } ] )

/*========================================GRADES COLLECTION=====================================================*/

// This collection contains:
// 1. Section ID: section_id to represent a specific section
// 2. Student ID: student_id to represent a specific student
// 3. Assignment details: contains the name of assignment and score of the assignment. The grade for an assignment can be added based on the score.
//  - assignment_name: name of the assignment
//  - assignment_score: score for the assignment
// 4. Grade obtained: grade in a specific section for a specific student. It is a NumberDecimal type.

// The combination of section and student is unique 
db.grades.createIndex( { section_id: 1, student_id: 1 }, { unique: true } )

// The combination of assignment name and section is unique
// For this table, the combination of assignment name, section, and student is unique
db.grades.createIndex( { section_id: 1, student_id: 1, 'assignment.assignment_name': 1 }, { unique: true } )

// Insert documents into the grades collection
db.grades.insertMany( [ 
    { section_id: 1, 
     student_id: 1, 
     assignment: [ { assignment_name: 'hw1', assignment_score: 92 }, 
                  { assignment_name: 'hw2', assignment_score: 89 },
                  { assignment_name: 'hw3', assignment_score: 95 }], 
     grade: NumberDecimal(3.9) 
    },
    { section_id: 6, 
     student_id: 1, 
     assignment: [ { assignment_name: 'hw1', assignment_score: 90 }, 
                  { assignment_name: 'hw2', assignment_score: 87 } ], 
     grade: NumberDecimal(3.0) 
    },
    { section_id: 11, 
     student_id: 1, 
     assignment: [ { assignment_name: 'hw1', assignment_score: 89 }], 
     grade: NumberDecimal(3.1) 
    },
    { section_id: 1, 
     student_id: 2, 
     assignment: [ { assignment_name: 'hw1', assignment_score: 78 }, 
                  { assignment_name: 'hw2', assignment_score: 90 } ], 
     grade: NumberDecimal(3.0) 
    },
    { section_id: 7, 
     student_id: 2, 
     assignment: [ { assignment_name: 'hw1', assignment_score: 70 }], 
     grade: NumberDecimal(2.2) 
    },
    { section_id: 11, 
     student_id: 2, 
     assignment: [ { assignment_name: 'hw1', assignment_score: 67 }], 
     grade: NumberDecimal(2.1) 
    },
    { section_id: 3, 
     student_id: 3, 
     assignment: [ { assignment_name: 'hw1', assignment_score: 90 }, 
                  { assignment_name: 'hw2', assignment_score: 98 } ]
    },
    { section_id: 8, 
     student_id: 3, 
     assignment: [ { assignment_name: 'hw1', assignment_score: 95 }, 
                  { assignment_name: 'hw2', assignment_score: 94 } ], 
     grade: NumberDecimal(3.7) 
    },
    { section_id: 4, 
     student_id: 4, 
     assignment: [ { assignment_name: 'hw1', assignment_score: 75 }, 
                  { assignment_name: 'hw2', assignment_score: 69 } ], 
     grade: NumberDecimal(2.2) 
    },
    { section_id: 9, 
     student_id: 4, 
     assignment: [ { assignment_name: 'hw1', assignment_score: 88 }, 
                  { assignment_name: 'hw2', assignment_score: 85 } ], 
     grade: NumberDecimal(3.0) 
    },
    { section_id: 5, 
     student_id: 5, 
     assignment: [ { assignment_name: 'hw1', assignment_score: 99 }, 
                  { assignment_name: 'hw2', assignment_score: 99 } ], 
     grade: NumberDecimal(4.0) 
    },
    { section_id: 10, 
     student_id: 5, 
     assignment: [ { assignment_name: 'hw1', assignment_score: 77 }, 
                  { assignment_name: 'hw2', assignment_score: 76 } ], 
     grade: NumberDecimal(2.2) 
    },
    { section_id: 5, 
     student_id: 6, 
     assignment: [ { assignment_name: 'hw1', assignment_score: 33 } ], 
     grade: NumberDecimal(1.0) 
    },
    { section_id: 3, 
     student_id: 2, 
     assignment: [ { assignment_name: 'hw1', assignment_score: 92 }, 
                  { assignment_name: 'hw2', assignment_score: 90 } ]
    },
    { section_id: 3, 
     student_id: 4, 
     assignment: [ { assignment_name: 'hw1', assignment_score: 70 }, 
                  { assignment_name: 'hw2', assignment_score: 88 } ]
    }
] )
