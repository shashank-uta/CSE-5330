const prompt = require('prompt-sync')({ sigint: true });
var mysql = require('mysql');

var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'Company'
});
connection.connect();

var EmployeeObj = {
    Fname: '',
    Minit: '',
    Lname: '',
    Ssn: null,
    Bdate: null,
    Address: '',
    Sex: '',
    Salary: null,
    Super_ssn: null,
    Dno: null
}

var DepartmentObj = {
    Dname: '',
    Dnumber: null,
    Mgr_ssn: null,
    Mgr_start_date: null
}
var tableName = 'Employee'
if (process.argv.slice(2)[0]) {
    tableName = process.argv.slice(2)[0]
    doesTableExists();
} else {
    checkUserPrompt();
}


function doesTableExists() {
    var query = connection.query('SHOW TABLES LIKE "' + tableName + '";', function(err, result) {
        if (err) {
            console.error("ERROR while Checking table: " + err);
            return;
        }
        if (result.length < 1) {
            console.log(" >> There is no table with the name: " + tableName + " (Try 'show tables' to list the available tables)")
            checkUserPrompt();
        } else if (result.length == 1) {
            //table exists
            console.log('\n');
            console.log(" >> Table: " + tableName);
            console.log("--------------------")
            if (tableName.toLowerCase() === 'employee')
                employeeDataController();
            else if (tableName.toLowerCase() === 'department')
                departmentDataController();
        }
    });
}

function employeeDataController() {
    EmployeeObj.Fname = prompt(" >> Fname: ");
    EmployeeObj.Minit = prompt(" >> Minit: ");
    EmployeeObj.Lname = prompt(" >> Lname: ");
    EmployeeObj.Ssn = Number(prompt(" >> SSN: "));
    EmployeeObj.Bdate = prompt(" >> Birthday: ");
    EmployeeObj.Address = prompt(" >> Address: ");
    EmployeeObj.Sex = prompt(" >> Sex: ");
    EmployeeObj.Salary = Number(prompt(" >> Salary: "));
    EmployeeObj.Super_ssn = Number(prompt(" >> Supervisor SSN: "));
    EmployeeObj.Dno = Number(prompt(" >> Department No: "));

    insertEmployeeData();
}

function departmentDataController() {
    DepartmentObj.Dname = prompt(" >> Department Name: ");
    DepartmentObj.Dnumber = prompt(" >> Department Number: ");
    DepartmentObj.Mgr_ssn = prompt(" >> Manager SSN: ");
    DepartmentObj.Mgr_start_date = prompt(" >> Manager Start Date: ");

    insertDepartmentData();
}

function insertEmployeeData() {
    var query = connection.query('insert into Employee set ?', EmployeeObj, function(err, result) {
        if (err) {
            console.error(" >> ERROR: Unable to insert data into table Employee" + err);
            return;
        }
        if (result && result.affectedRows == 1) {
            console.log("\n")
            console.log(" >> Data successfully inserted in table: " + tableName)
            checkUserPrompt();
        }
    });
}

function insertDepartmentData() {
    var query = connection.query('insert into Department set ?', DepartmentObj, function(err, result) {
        if (err) {
            console.error(" >> ERROR: Unable to insert data into table Department" + err);
            return;
        }
        if (result && result.affectedRows == 1) {
            console.log("\n")
            console.log(" >> Data successfully inserted in table: " + tableName)
            checkUserPrompt();
        }
    });
}

function checkUserPrompt() {
    console.log("\n")
    var userInput = prompt(" >> ");
    switch (userInput.toLowerCase()) {
        case 'help':
            showCommands();
            break;

        case 'insert data':
            tableName = prompt(" >> Table name: ");
            doesTableExists();
            break;

        case 'show tables':
            showTables();
            break;

        case 'exit':
            console.log(" >> GOOD BYE !!")
            process.exit(0)
            break;

        default:
            console.error(" >> Invalid statement. Try 'help' to list the commands.")
            break;
    }
}

function showCommands() {
    console.log("\n")
    console.log(" >> LIST OF COMMANDS ")
    console.log(" --------------------- ")
    console.log(" 1. insert data: Insert record in a table.")
    console.log(" 2. show tables: Displays a list of tables in the database.")
    console.log(" 3. exit: Exit the program")
    console.log("\n")

    checkUserPrompt();
}

function showTables() {
    console.log("\n")
    var query = connection.query('show tables;', function(err, result) {
        if (err) {
            console.error("ERROR while getting tables: " + err);
            return;
        }
        if (result.length < 1) {
            console.log(" >> There are no tables in the database " + connection.database)
        } else {
            console.log(" >> TABLES IN THE DATABASE: ")
            console.log(" ----------------------------")
            console.log(query)
        }
    });
    checkUserPrompt();
}   