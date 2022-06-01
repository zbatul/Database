// Create mongodb connection to our database
conn = new Mongo();
db = conn.getDB("myDatabase");

/*===================================================QUERY 1=====================================================================*/

// Query 1: List the grades a student has received in assignments in a specific section – this is kind of like what I think “My Grades” looks like for you on Blackboard

// set the grades of the students from the scores in the table as below
db.grades.aggregate( [ { "$addFields": { "assignment.assignment_grade": { $switch: { branches: [ 
            { case: { $gte : [ "$assignment.assignment_score", 90 ] }, then: "A" },
            { case: { $and : [ { $gte : [ "$assignment.assignment_score", 80 ] }, 
                              { $lt : [ "$assignment.assignment_score", 90 ] } ] }, then: "B" },
            { case: { $and : [ { $gte : [ "$assignment.assignment_score", 70 ] }, 
                              { $lt : [ "$assignment.assignment_score", 80 ] } ] }, then: "C" },
            { case: { $lt : [ "$assignment.assignment_score", 70 ] }, then: "D" }
          ],
          default: "F"
        } } } },
        {"$out": "grades"} ] );

print("\nQUERY 1: The grades a student has received in assignments in a specific section");
print("Let: student id = 1 and section id = 6")

// filter on a student id and section id and display only the assignment and assignment grade
cursor = db.grades.find( { student_id: 1, section_id: 6 }, 
                        { _id: 0, 'assignment.assignment_name': 1, 'assignment.assignment_grade': 1 } )
while ( cursor.hasNext() ) {
   printjson( cursor.next() );
}

/*===================================================QUERY 2=====================================================================*/

// Query 2:  List the sections being offered by a particular department in the current term (so right now, that would be Spring 2021) – students would check this to decide what to enroll in

print("\nQUERY 2: The sections being offered by a particular department in the current term");
print("Let: Department = Computer Science and Current term = Spring 2021")

// filter on a department name and current term, then display only section number and course details
cursor = db.section.find( { 'course.dept_name': 'Computer Science', 'term': 5, 'year': 2021 }, 
                          { '_id': 0, 'secnum': 1, 'course': 1 } )
while ( cursor.hasNext() ) {
   printjson( cursor.next() );
}

/*===================================================QUERY 3=====================================================================*/

// Query 3: List the grade for a particular student in a particular section of the current term. This could be for any student in the current term

print("\nQUERY 3: The grade for a particular student in a particular section of the current term")
print("Let: Section ID = 7, Student ID = 2")

// list the grade for a particular student in the section id of current term
// since grade is asked for a particular section of current term, the section_id is picked up such that it belongs to current term.
cursor = db.grades.find( { student_id: 2, section_id: 7 }, { _id: 0, 'grade': 1 } )
while ( cursor.hasNext() ) {
   printjson( cursor.next() );
}

/*===================================================QUERY 4=====================================================================*/

// Query 4: List the gpa (average grade) for a particular student

print("\nQUERY 4: The gpa (average grade) for a particular student")
print("Let: Student ID = 4")

// aggregate and match on student id = 4 and then group on this student id and find average grade to find gpa
cursor = db.grades.aggregate( [ { $match: { student_id: 4 } }, { $group: { _id: "$student_id", gpa: { $avg: "$grade" } } } ] )
while ( cursor.hasNext() ) {
   printjson( cursor.next() );
}

/*===================================================QUERY 5=====================================================================*/

// Query 5: Set the grades for all students of one section.

print("\nQUERY 5: Setting the grades for all students of one section")
print("Let: section id to update grades = 3")

// update the section with random grade if grade key is present otherwise upsert the grade key and update

//const query = { section_id: 3 };
function randomNum(min, max) {
	return Math.floor((Math.random() * (max*10 - min*10)) + min*10)/10; 
}
//grades = Array.from({length: 3}, () => randomNum(2.0, 4.0));
//print(grades)
//const update = { $set: { grade: randomNum(2.0,4.0) } };
//const options = { upsert: true, multi: true };
//db.grades.update(query, update, options);

print("Updated grades table: inserted grades for a section")
//cursor = db.grades.find( { section_id: 3 } )
//while ( cursor.hasNext() ) {
//   printjson( cursor.next() );
//}

db.grades.find().forEach( function(gd) {
    db.grades.update( { section_id: 3 }, { $set: { grade: randomNum(2.0, 4.0) } }, { upsert: true } )
} ) 
cursor = db.grades.find( { section_id: 3 } )
while ( cursor.hasNext() ) {
   printjson( cursor.next() );
}

/*===================================================QUERY 6=====================================================================*/

// Query 6:  List the course name and section number for any course of the current term with an average grade below 2.6

print("\nQUERY 6: The course name and section number for any course of the current term with an average grade below 2.6")

cursor = db.grades.aggregate( { 
    // group on the section id and find average grade for each section
    $group: { _id: "$section_id", avg_grade: { $avg: "$grade" } } },
    // match only the documents with average grade <= 2.6
    { $match: { avg_grade: { $lte: NumberDecimal(2.6) } } },
    // lookup (join) with section table to filter on current term and get the course name and section number
    { $lookup: {
            from: "section",
            localField: "_id",
            foreignField: "_id",
            as: "info"
    } },
    // for matching course and section in current term
    { $match: { 'info.term': 5, 'info.year': 2021 } }, 
    // select only one random document from all the sections (all sections here are with average grade <= 2.6)
    { $sample: { size: 1 } }, 
    // project only course name and section num
    { $project: { 'info.course.course_name': 1, 'info.secnum': 1, '_id': 0} }, 
    );
while ( cursor.hasNext() ) {
   printjson( cursor.next() );
}