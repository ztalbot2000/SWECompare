setup()
{
   load './setup'
   _common_setup
}

@test "Test Equations in two files are equal," {
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

@test "Test Equations in two files, Second has Missing comment but -ic not specified" {
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

@test "Test Equations in two files, Second has Missing comment and -ic specified" {
run node ../SWECompare -ic testData/equations.txt testData/equationsMissingComment.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[1]}" "Adding file: testData/equationsMissingComment.txt"
   assert_equal "${lines[2]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[3]}" "Reading file: testData/equationsMissingComment.txt"
   assert_equal "${lines[4]}" "variable: \"RailThickness\" matches but not the comment in testData/equationsMissingComment.txt"
   assert_equal "${lines[5]}" "'This comment not in original file != "
   assert_equal "${lines[6]}" "Some FAILED"
   # No more lines than expected
   assert_equal "${#lines[@]}" 7
}

@test "Test Equations in two files, Second has different Global vaiable value" {
run node ../SWECompare testData/equations.txt testData/equationsWithDifferentGlobal.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[1]}" "Adding file: testData/equationsWithDifferentGlobal.txt"
   assert_equal "${lines[2]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[3]}" "Reading file: testData/equationsWithDifferentGlobal.txt"
   assert_equal "${lines[4]}" "variable: \"StandardWallThickness\" matches but not the value in testData/equationsWithDifferentGlobal.txt"
   assert_equal "${lines[5]}" " 5mm !=  3mm"
   assert_equal "${lines[6]}" "Some FAILED"
   # No more lines than expected
   assert_equal "${#lines[@]}" 7
}

@test "Test Equations in two files with -r, Second has different Global vaiable value" {
run node ../SWECompare -r testData/equations.txt testData/equationsWithDifferentGlobal.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/equations.txt"
   assert_equal "${lines[1]}" "Adding file: testData/equationsWithDifferentGlobal.txt"
   assert_equal "${lines[2]}" "Reading file: testData/equations.txt"
   assert_equal "${lines[3]}" "Reading file: testData/equationsWithDifferentGlobal.txt"
   assert_equal "${lines[4]}" "variable: \"StandardWallThickness\" matches but not the value in testData/equationsWithDifferentGlobal.txt"
   assert_equal "${lines[5]}" " 5mm !=  3mm"
   assert_equal "${lines[6]}" "variable: \"StandardWallThickness\" matches but not the value in testData/equations.txt"
   assert_equal "${lines[7]}" " 3mm !=  5mm"
   assert_equal "${lines[8]}" "Some FAILED"
   # No more lines than expected
   assert_equal "${#lines[@]}" 9
}

@test "Test Equations in two files, Second has missing \"D1@Something\"" {
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

@test "Test a Missing Global in a file but found in another" {
run node ../SWECompare -v testData/missingGlobal.txt testData/foundGlobal.txt
   assert_equal "$status" 0
   assert_equal "${lines[0]}" "Adding file: testData/missingGlobal.txt"
   assert_equal "${lines[1]}" "Adding file: testData/foundGlobal.txt"
   assert_equal "${lines[2]}" "Reading file: testData/missingGlobal.txt"
   assert_equal "${lines[3]}" "Reading file: testData/foundGlobal.txt"
   assert_equal "${lines[4]}" "No unused globals found"
   # No more lines than expected
   assert_equal "${#lines[@]}" 5
}

