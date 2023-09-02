setup()
{
   load './setup'
   _common_setup
}

@test "Test Equations in two files," {
run node ../SWECompare testData/equations.txt testData/equations.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[1]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[2]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[3]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[4]}" "All Passed"
   # No more lines than expected
   assert_equal "${#lines[@]}" 5
}

@test "Test a Missing Global in a file" {
run node ../SWECompare testData/missingGlobal.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/missingGlobal.txt"
   assert_equal "${lines[1]}" "Reading file: testData/missingGlobal.txt"
   assert_equal "${lines[2]}" "variable: \"RailThickness\" was unused in testData/missingGlobal.txt"
   assert_equal "${lines[3]}" "Some unused globals found"
   # No more lines than expected
   assert_equal "${#lines[@]}" 4
}

@test "Test Equations in two files, second has Missing comment but -ic not specified" {
run node ../SWECompare testData/equations.txt testData/equationsMissingComment.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[1]}" "Adding file: testData/equationsMissingComment.txt"
   assert_equal "${lines[2]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[3]}" "Reading file: testData/equationsMissingComment.txt"
   assert_equal "${lines[4]}" "All Passed"
   # No more lines than expected
   assert_equal "${#lines[@]}" 5
}

@test "Test Equations in two files, second has Missing comment and -ic specified" {
run node ../SWECompare -ic testData/equations.txt testData/equationsMissingComment.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[1]}" "Adding file: testData/equationsMissingComment.txt"
   assert_equal "${lines[2]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[3]}" "Reading file: testData/equationsMissingComment.txt"
   assert_equal "${lines[4]}" "variable: \"RailThickness\" matches but not the comment in testData/equationsMissingComment.txt"
   assert_equal "${lines[5]}" "'This comment not in original file != "
   assert_equal "${lines[6]}" "variable: \"RailThickness\" matches but not the comment in testData/equations.txt"
   assert_equal "${lines[7]}" " != 'This comment not in original file"
   assert_equal "${lines[8]}" "Some FAILED"
   # No more lines than expected
   assert_equal "${#lines[@]}" 9
}

@test "Test Equations in two files, second has missing \"D1@Something\"" {
run node ../SWECompare testData/equations.txt testData/equationsMissingEquation.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[1]}" "Adding file: testData/equationsMissingEquation.txt"
   assert_equal "${lines[2]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[3]}" "Reading file: testData/equationsMissingEquation.txt"
   assert_equal "${lines[4]}" "All Passed"
   # No more lines than expected
   assert_equal "${#lines[@]}" 5
}
